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
                    HStack{
                        
                        Rectangle()
                            .frame(width: 100, height: 100)
                            .foregroundColor(Color("DarkRed"))
                            .shadow(color: Color("Red"), radius: 5, x: 0, y: 0)
                            .padding()
                            .overlay(content: {
                                Image(systemName: "person")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(.white)
                                    .clipped()
                                    .frame(width: 90, height: 90)
                                    
                                                                
                            })
                        
                        VStack(alignment: .leading) {
                            Rectangle()
                                .frame(height: 30)
                                .foregroundColor(Color("DarkRed").opacity(0.5))
                                .padding(.vertical, 5)
                                .overlay(content: {
                                    Text(user.user?.username ?? "username")
                                    
                                        .font(.system(size: 20, weight: .bold, design: .rounded))
                                        .foregroundColor(.white)
                                })
                            
                            if auth.currentUser?.email != nil{
                            Rectangle()
                                .frame(height: 30)
                                .foregroundColor(Color("DarkRed").opacity(0.5))
                                .padding(.vertical, 5)
                                .overlay(content: {
                                    
                                    Text(auth.currentUser?.email ?? "")
                                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                                        .foregroundColor(.white)
                                })
                        }
                            
                        }
                        Spacer()
                    }
                    
                    Button(action: {
                        
                    }, label: {
                        Rectangle()
                            .frame(height: 60)
                            .foregroundColor(Color("DarkRed"))
                            .padding()
                            .overlay(content: {
                                
                                Text("CHANGE PASSWORD")
                                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                                    .foregroundColor(.white)
                            })
                    })
                    Button(action: {
                        
                    }, label: {
                        Rectangle()
                            .frame(height: 60)
                            .foregroundColor(Color("DarkRed"))
                            .padding()
                            .overlay(content: {
                                
                                Text("THEMES")
                                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                                    .foregroundColor(.white)
                            })
                    })
                    Button(action: {
                        
                    }, label: {
                        Rectangle()
                            .frame(height: 60)
                            .foregroundColor(Color("DarkRed"))
                            .padding()
                            .overlay(content: {
                                
                                Text("APP INFO")
                                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                                    .foregroundColor(.white)
                            })
                    })
                    
                    Spacer()
                    
                    if auth.currentUser?.email != nil{
                        Button(action: {
                            
                            user.signOut()
                            
                        }, label: {
                            HStack{
                                Circle()
                                    .frame(height: 65)
                                    .foregroundColor(Color("DarkRed"))
                                    .overlay(content: {
                                        Image(systemName: "door.left.hand.open")
                                            .resizable()
                                            .frame(width: 40, height: 40)
                                        
                                            .foregroundColor(.white)
                                    })
                                    .padding()
                                    .padding(.bottom, 40)
                                
                                Spacer()
                                
                            }
                        })
                    }
                    else {
                        Button(action: {
                            
                            user.signOut()
                            
                        }, label: {
                            HStack{
                               Rectangle()
                                    .frame(width: 140, height: 60)
                                    .foregroundColor(Color("DarkRed"))
                                    .overlay(content: {
                                        Text("LOG IN")
                                            .font(.system(size: 20, weight: .semibold, design: .rounded))
                                            .foregroundColor(.white)
                                    })
                                    .padding()
                                    .padding(.bottom, 40)
                                
                                Spacer()
                                
                            }
                        })
                    }
                    
                    
                    
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Account")
                
            
            
            
            
            
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
