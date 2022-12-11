//
//  UserViewModel.swift
//  ShoppingApp
//
//  Created by kz on 18/11/2022.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift


class UserViewModel: ObservableObject {
    
    @Published var user: User?
    
    @Published var showingAlert : Bool = false
    @Published var alertMessage = ""
    @Published var alertTitle = ""
    
    var userIsGuest: Bool = false
    
    @Published var watchListIDs = [String]()


    
    
    private let auth = Auth.auth()
    private let db = Firestore.firestore()
    
    var uuid: String? {
        auth.currentUser?.uid
    }
    
    var userIsAuthenticated: Bool {
        auth.currentUser != nil
    }
    
    var userIsAuthenticatedAndSynced: Bool {
        user != nil && userIsAuthenticated
    }
    

    func signUp(email: String, password: String, username: String){
        auth.createUser(withEmail: email, password: password){ (result, error) in
            if error != nil{
                self.alertTitle = "Error"
                self.alertMessage = error?.localizedDescription ?? "Something went wrong"
                self.showingAlert = true
            } else {
                DispatchQueue.main.async{
                    self.add(User(username: username, userEmail: email))
                    self.sync()
                }
            }
        }
    }
    
    
    func signIn(email: String, password: String){
        auth.signIn(withEmail: email, password: password){ (result, error) in
            if error != nil{
                self.alertTitle = "Errors"
                self.alertMessage = error?.localizedDescription ?? "Something went wrong"
                self.showingAlert = true
            } else {
                DispatchQueue.main.async{
                    //Success
                    self.sync()

                }
            }
        }
    }
    
    func singInAnonymously(){
        auth.signInAnonymously(){ authResult, error in
            guard let user = authResult?.user else { return }
            self.userIsGuest = user.isAnonymous
            DispatchQueue.main.async{
                //Success
                self.add(User(username: "guest", userEmail: "guest"))
                self.sync()
                
            }
        }

    }

    func resetPassword(email: String){
        auth.sendPasswordReset(withEmail: email) { error in
            if error != nil{
                self.alertTitle = "Error"
                self.alertMessage = error?.localizedDescription ?? "Something went wrong"
                self.showingAlert = true
            } else {
                self.alertTitle = "Succes"
                self.alertMessage = "A Password change request has been sent to your email adress."
                self.showingAlert = true
            }
        }
        
    }
    
    func signOut(){
        do{
            try auth.signOut()
            self.user = nil
        }
        catch{
            print("Error signing out user: \(error)")
        }
    }
    
    //MARK: firestore functions for user data
    
    func sync(){
        guard userIsAuthenticated else { return }
        db.collection("Users").document(self.uuid!).getDocument { document, error in
            guard document != nil, error == nil else { return }
            do{
                try self.user = document!.data(as: User.self)
            } catch{
                print("sync error: \(error)")
            }
        }
        self.getUserWatchList()

    }
    
    private func add(_ user: User){
        guard userIsAuthenticated else { return }
        do {
            let _ = try db.collection("Users").document(self.uuid!).setData(from: user)

        } catch {
            print("Error adding: \(error)")
        }
    }
    
    private func update(){
        guard userIsAuthenticatedAndSynced else { return }
        do{
            let _ = try db.collection("Users").document(self.uuid!).setData(from: user)
        } catch{
            print("error updating \(error)")
        }
    }
    
    func addMovieToWatchList(movieID: String){
        let userID = Auth.auth().currentUser?.uid
        let ref = db.collection("Users").document(userID!).collection("WatchList").document(movieID)
        let date = ["date:" : Date.now] as [String : Any]
        let movie = ["movieID:" : movieID] as [String : Any]
        ref.setData(date, merge: true)
        ref.setData(movie, merge: true)
        
    }
    
    func deleteMovieFromWatchList(movieID: String){
        let userID = Auth.auth().currentUser?.uid
        let ref = db.collection("Users").document(userID!).collection("WatchList").document(movieID)
        ref.delete(){ err in
            if let err = err {
                print("Error removing doc: \(err)")
            }
            else {
                print("WatchList document succesfully removed")
            }
        }
        
    }
    
    func getUserWatchList(){
        let userID = Auth.auth().currentUser?.uid
        //self.watchListIDs = nil
        self.watchListIDs.removeAll(keepingCapacity: false)
        
        db.collection("Users").document(userID!).collection("WatchList").addSnapshotListener{ (snapshot, error) in
            if error != nil {
                print(error?.localizedDescription as Any)
            }
            else {
                if(snapshot?.isEmpty != true && snapshot != nil){
                    
                    self.watchListIDs.removeAll(keepingCapacity: false)
                    
                    for document in snapshot!.documents {
                        let documentID = document.documentID
                        self.watchListIDs.append(documentID)
                    }
                    
                }

            }
        }
        print("watchlist: \(self.watchListIDs)")

    }
    
}
