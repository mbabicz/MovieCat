//
//  ProfileView.swift
//  MovieCat
//
//  Created by kz on 14/11/2022.
//

import SwiftUI
import Firebase

struct ProfileView: View {

    @EnvironmentObject var user: UserViewModel
    let auth = Auth.auth()

    var body: some View {

        NavigationView{
            VStack{
                VStack{
                    Text(user.user?.username ?? "username").font(.largeTitle)
                    Text(auth.currentUser?.email ?? "user email")
                }
                .frame(maxWidth: .infinity, alignment: .top)
                .border(.red)
                .padding()
                
                Spacer()
            
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Accoount")
            .toolbar{
//                ToolbarItem(placement: .principal){
//                    Text("Profile")
//                        .font(.headline)
//                        .bold()
//                }
                ToolbarItem(placement: .navigationBarTrailing){
                    Button {
                        user.signOut()
                    } label: {
                        Image(systemName: "person")
                    }

                }

            }
            .border(.green)
        }
        
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    
    static let myEnvObject = UserViewModel()

    static var previews: some View {
        ProfileView()
            .environmentObject(myEnvObject)

    }
}
