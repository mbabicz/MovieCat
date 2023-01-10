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
                    if !user.userIsAnonymous{
                        NavigationLink(destination: ChangePasswordView(), label: {
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
                    }

                    NavigationLink(destination: ThemesView(), label: {
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
                    NavigationLink(destination: AppInfoView(), label: {
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
                    
                    if !user.userIsAnonymous{
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
                
                .alert(isPresented: $user.showingAlert){
                    Alert(
                        title: Text(user.alertTitle),
                        message: Text(user.alertMessage),
                        dismissButton: .default(Text("OK"))
                    )
                }
            
            
            
            
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

struct AppInfoView: View{
    
    var body: some View {
        Text("appinfo view")
    }

}

struct ChangePasswordView: View{
    
    @State var password = ""
    @State var newPassword = ""
    @State var newPassword2 = ""
    
    @State var isSecured: Bool = true
    @State var isSecured2: Bool = true
    @State var isSecured3: Bool = true



    
    @EnvironmentObject var user: UserViewModel
    
    @State var isAnimating: Bool = false

    var body: some View {
        VStack {
            VStack{
                VStack{
                    
                    HStack{
                        
                        Image(systemName: "lock.square.fill")
                            .foregroundColor(Color.white)
                        
                        Group{
                            if isSecured {
                                SecureField("", text: $password)
                                    .placeholder(when: password.isEmpty){
                                        Text("Current password")
                                            .foregroundColor(Color.white)
                                            .font(.headline)
                                    }
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                  
                            } else {
                                TextField("", text: $password)
                                    .placeholder(when: password.isEmpty){
                                        Text("Current password")
                                            .foregroundColor(Color.white)
                                            .font(.headline)
                                    }
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                    
                            }
                        }
                        Button {
                            isSecured.toggle()
                        } label: {
                            Image(systemName: self.isSecured ? "eye.slash" : "eye").accentColor(Color("DarkRed"))
                        }.padding()
                    }
                    
                    Divider().background(Color("Red"))
                    HStack{
                        
                        Image(systemName: "lock.square.fill")
                            .foregroundColor(Color.white)
                        
                        Group{
                            if isSecured2 {
                                SecureField("", text: $newPassword)
                                    .placeholder(when: newPassword.isEmpty){
                                        Text("New password")
                                            .foregroundColor(Color.white)
                                            .font(.headline)
                                    }
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                  
                            } else {
                                TextField("", text: $newPassword)
                                    .placeholder(when: newPassword.isEmpty){
                                        Text("New password")
                                            .foregroundColor(Color.white)
                                            .font(.headline)
                                    }
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                    
                            }
                        }
                        Button {
                            isSecured2.toggle()
                        } label: {
                            Image(systemName: self.isSecured ? "eye.slash" : "eye").accentColor(Color("DarkRed"))
                        }.padding()
                    }
                    
                    Divider().background(Color("Red"))

                    HStack{
                        
                        Image(systemName: "lock.square.fill")
                            .foregroundColor(Color.white)
                        
                        Group{
                            if isSecured3 {
                                SecureField("", text: $newPassword2)
                                    .placeholder(when: newPassword2.isEmpty){
                                        Text("Repeat new password")
                                            .foregroundColor(Color.white)
                                            .font(.headline)
                                    }
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                  
                            } else {
                                TextField("", text: $newPassword2)
                                    .placeholder(when: newPassword2.isEmpty){
                                        Text("Repeat new password")
                                            .foregroundColor(Color.white)
                                            .font(.headline)
                                    }
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                    
                            }
                        }
                        Button {
                            isSecured3.toggle()
                        } label: {
                            Image(systemName: self.isSecured ? "eye.slash" : "eye").accentColor(Color("DarkRed"))
                        }.padding()
                    }
                    
                    
                    Divider().background(Color("Red"))
                    
                }
                .padding(.top)
                
                Button {
                    if !password.isEmpty && !newPassword.isEmpty && !newPassword2.isEmpty {
                        if newPassword == newPassword2{
                            user.changePassword(email: user.user!.userEmail, currentPassword: password, newPassword: newPassword){ error in
                                if error != nil {
                                    user.alertTitle = "Error"
                                    user.alertMessage = error?.localizedDescription ?? "Something went wrong"
                                    user.showingAlert = true
                                } else {
                                    user.alertTitle = "Succes"
                                    user.alertMessage = "Password has been changed succesfully"
                                    user.showingAlert = true
                                    
                                }
                            }

                        } else {
                            user.alertTitle = "Error"
                            user.alertMessage = "New password fields must be the same"
                            user.showingAlert = true
                        }
                    } else {
                        
                        user.alertTitle = "Error"
                        user.alertMessage = "Field cannot be empty"
                        user.showingAlert = true
                    }
                    
                } label: {
                    Text("Reset Password")
                        .frame(width: 200, height: 50)
                        .bold()
                        .foregroundColor(Color.white)
                        .background(Color("DarkRed"))
                        .padding()
                }
                Spacer()
                
                
            }
            .padding()
            Spacer()
        }
        .edgesIgnoringSafeArea(.bottom)
        
        .navigationTitle("Change Password")
        
    }
    
    

}

struct ThemesView: View{
    
    var body: some View {
        Text("ThemesView")
    }

}


