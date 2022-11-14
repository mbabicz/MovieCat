//
//  ProfileView.swift
//  MovieCat
//
//  Created by kz on 14/11/2022.
//

import SwiftUI
import Firebase

struct ProfileView: View {

    @EnvironmentObject var viewModel: AppViewModel
    let auth = Auth.auth()

    var body: some View {
        VStack{
            
            Image("profile-picture").resizable().aspectRatio(contentMode: .fit).padding(.all).frame(width: 150, height: 150)
            
            Text(auth.currentUser?.email ?? "user email")
            
            Button {
                try? auth.signOut()
                viewModel.signedIn = false

            } label: {
                Text("Log Out")
                    .frame(width: 200, height: 50)
                    .background(Color.blue)
                    .foregroundColor(Color.black)
                    .bold()
                    .cornerRadius(8)
                    .padding()
            }

            
        }    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
