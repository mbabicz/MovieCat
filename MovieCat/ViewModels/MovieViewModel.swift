//
//  MovieViewModel.swift
//  MovieCat
//
//  Created by kz on 30/12/2022.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class MovieViewModel: ObservableObject {
    
    //RATES & REVIEWS
    @Published var movieReview = [String]()
    @Published var movieRate = [Int]()
    @Published var movieRatedByUID = [String]()
    @Published var movieRatedBy = [String]()
    @Published var movieRatesCount: Int = 0
    @Published var movieRatesTotal: Int = 0
    @Published var movieRatingAvarage : Double = 0
    
    @Published var showingAlert : Bool = false
    @Published var alertMessage = ""
    @Published var alertTitle = ""
    
    func updateAlert(title: String, message: String) {
        self.alertTitle = title
        self.alertMessage = message
        self.showingAlert = true
    }
    
    
    func addMovieReview(movieID: String, rating: Int, review: String, username: String) {
        let userID = Auth.auth().currentUser?.uid
        let db = Firestore.firestore()
        let ref = db.collection("Movies").document(movieID).collection("Reviews").document(userID!)
        
        ref.setData([
            "date": Date(),
            "movieID": movieID,
            "username": username,
            "review": review,
            "rating": rating
        ]) { error in
            if let error = error {
                self.alertTitle = "Error"
                self.alertMessage = error.localizedDescription
                self.showingAlert = true
            } else {
                self.alertTitle = "Success"
                self.showingAlert = true
            }
        }
    }

    
    
    func getMovieReviews(movieID: String, completion: @escaping (([String],[Int],[String],[String], Int, Int, Double)) -> ()){
        let db = Firestore.firestore()
        let ref = db.collection("Movies").document(movieID).collection("Reviews")
        ref.addSnapshotListener{ (snapshot, error) in
            if error != nil{
                print(error?.localizedDescription as Any)
            }
            else {
                if(snapshot?.isEmpty != true && snapshot != nil){
                    self.movieReview.removeAll(keepingCapacity: false)
                    self.movieRate.removeAll(keepingCapacity: false)
                    self.movieRatedByUID.removeAll(keepingCapacity: false)
                    self.movieRatedBy.removeAll(keepingCapacity: false)
                    self.movieRatesCount = 0
                    self.movieRatesTotal = 0
                }
                
                for document in snapshot!.documents{
                    if let rate = document.get("rate") as? Int {
                        self.movieRate.append(rate)
                        self.movieRatesCount = self.movieRatesCount + rate
                    }
                    if let review = document.get("review") as? String {
                        self.movieReview.append(review)
                    }
                    if let ratedBy = document.get("username") as? String {
                        self.movieRatedBy.append(ratedBy)
                    }
                    let ratedByUID = document.documentID
                    self.movieRatedByUID.append(ratedByUID)
                    
                }
                self.movieRatesTotal = snapshot?.count ?? 0
                
                var movieRatingAvarage: Double {
                    let avarage: Double
                    if self.movieRatesTotal != 0 {
                        avarage = Double(self.movieRatesCount)/Double(self.movieRatesTotal)
                        return Double(avarage)
                    }
                    else {
                        return 0
                    }
                }
                
                completion((self.movieRatedByUID, self.movieRate, self.movieReview, self.movieRatedBy, self.movieRatesCount, self.movieRatesTotal, movieRatingAvarage))
            }
        }
    }
}
