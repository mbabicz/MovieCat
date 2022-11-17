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
//        NavigationView{
//            VStack{
//
//                VStack{
//                    Text(auth.currentUser?.email ?? "user email")
//                    //TODO: read username
//                    Text("username")
//                }
//                .frame(maxWidth: .infinity, alignment: .top)
//                .border(.red)
//                .padding()
//
//                Spacer()
//
//                Button {
//                    try? auth.signOut()
//                    viewModel.signedIn = false
//
//                } label: {
//                    Text("Log Out")
//                        .frame(width: 200, height: 50)
//                        .background(Color.blue)
//                        .foregroundColor(Color.black)
//                        .bold()
//                        .cornerRadius(8)
//                        .padding()
//                }
//            }
//            .navigationTitle("")
//            .navigationBarItems(leading:
//                                    Text("Profile").font(.largeTitle).bold()
//                                , trailing: Button(action: {
//
//            }, label: {
//                Text("Log out").font(.system(size: 30))
//            }))
//        }
//        //.navigationTitle("Profile")
        NavigationView{
            VStack{
                
                VStack{
                    Text(auth.currentUser?.email ?? "user email")
                    //TODO: read username
                    Text("username")
                }
                .frame(maxWidth: .infinity, alignment: .top)
                .border(.red)
                .padding()
                
                Spacer()
                
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
            }
            //.navigationTitle("Profile").
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .principal){
                    Text("Profile").font(.headline).bold()
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    Button {
                        
                    } label: {
                        Text("Log out").font(.headline).foregroundColor(.blue)
                    }

                }
                
            }
            .border(.green)
        }
        //.navigationTitle("Profile")
        
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
