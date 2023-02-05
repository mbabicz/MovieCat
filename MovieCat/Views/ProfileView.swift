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
            ZStack{
                Rectangle()
                    .foregroundColor(Color("DarkRed"))
                    .cornerRadius(20, corners: [.topLeft, .topRight])
                    .shadow(color: .white, radius: 5)
                    .padding(.horizontal)
                    .padding(.top, 60)
                
                VStack {
                    Circle()
                        .frame(width: 100)
                        .foregroundColor(.black)
                        .shadow(color: .white, radius: 5)
                        .overlay(content: {
                            Image(systemName: "person")
                                .resizable()
                                .frame(width: 65, height: 65)
                        })
                    if !user.userIsAnonymous {
                        VStack(alignment: .leading) {
                            Text(user.user?.username ?? "username")
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                            
                            Text(auth.currentUser?.email ?? "")
                                .font(.system(size: 20, weight: .semibold, design: .rounded))
                                .foregroundColor(.white)
                            
                            NavigationLink(destination: ChangePasswordView()) {
                                Text("Change Password")
                                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 15, style: .continuous)
                                        .fill(Color.black)
                                        .shadow(color: .black, radius: 5))
                            }
                        }
                    }
                    else{
                        Rectangle()
                            .foregroundColor(.black)
                            .frame(height: 70)
                            .cornerRadius(15, corners: [.topLeft, .bottomLeft])
                            .shadow(color: .black, radius: 5)
                            .padding(.leading, 40)
                            .padding(.vertical)
                            .overlay(content: {
                                HStack{
                                    Text("Change Password")
                                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                                        .foregroundColor(.white)
                                    Image(systemName: "lock.fill")
                                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                                        .foregroundColor(.white)
                                }
                            })
                    }
                    
                    NavigationLink(destination: NotificationsView(), label: {
                        Rectangle()
                            .foregroundColor(.black)
                            .frame(height: 70)
                            .cornerRadius(15, corners: [.topRight, .bottomRight])
                            .shadow(color: .black, radius: 5)
                            .padding(.trailing, 40)
                            .padding(.vertical)
                            .overlay(content: {
                                Text("Notifications")
                                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                                    .foregroundColor(.white)
                            })
                    })
                    NavigationLink(destination: AppInfoView(), label: {
                        Rectangle()
                            .foregroundColor(.black)
                            .frame(height: 70)
                            .cornerRadius(15, corners: [.topLeft, .bottomLeft])
                            .shadow(color: .black, radius: 5)
                            .padding(.leading, 40)
                            .padding(.vertical)
                            .overlay(content: {
                                Text("App Info")
                                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                                    .foregroundColor(.white)
                            })
                    })
                    
                    Spacer()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Account")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button {
                        user.signOut()
                    } label: {
                        Image(systemName: "rectangle.portrait.and.arrow.forward.fill")
                    }
                    
                }
            }
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
                                    user.updateAlert(title: "Error", message: error?.localizedDescription ?? "Something went wrong")
                                } else {
                                    user.updateAlert(title: "Error", message: "Password has been changed succesfully")
                                }
                            }
                            
                        } else {
                            user.updateAlert(title: "Error", message: "New password fields must be the same")
                            
                        }
                    } else {
                        user.updateAlert(title: "Error", message: "Field cannot be empty")
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



