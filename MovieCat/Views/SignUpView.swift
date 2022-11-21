//
//  SignUpView.swift
//  MovieCat
//
//  Created by Bartosz Rzechółka on 21/11/2022.
//

import SwiftUI

struct SignUpView: View {
    
    @EnvironmentObject var user: UserViewModel
    
    @State var email = ""
    @State var password = ""
    @State var username = ""
    @State var passwordConfirmation = ""
    
    @State var maxRectangleHeight: CGFloat = 0
    
    @State var isSecured: Bool = true
    @State var isSecuredConfirmation: Bool = true
    @State var isAnimtaing: Bool = false
    
    var body: some View {
        VStack {
         Text("Sign Up")
                .font(.system(size: 40))
                .fontWeight(.bold)
                .foregroundColor(Color("DarkRed"))
                .kerning(1.9)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack{
                
                HStack{
                    
                    Image(systemName: "person.circle.fill")
                        .foregroundColor(Color.white)
                    
                    TextField("", text: $username)
                        .placeholder(when: username.isEmpty) {
                            Text("Username")
                                .foregroundColor(Color.white)
                                .font(.headline)
                    }
                        
                       
                        
                        
                }
                Divider().background(Color("Red").opacity(0.5))
            }
            .padding(.bottom)
            
            VStack{
                
                HStack{
                    
                    Image(systemName: "envelope.fill")
                        .foregroundColor(Color.white)
                    
                    TextField("", text: $email)
                        .placeholder(when: email.isEmpty) {
                            Text("Email Adress")
                                .foregroundColor(Color.white)
                                .font(.headline)
                    }
                        
                       
                        
                        
                }
                Divider().background(Color("Red").opacity(0.5))
            }
            
            
            
            VStack{
                
                HStack{
                    
                    Image(systemName: "lock.square.fill")
                        .foregroundColor(Color.white)
                    
                    Group{
                        if isSecured {
                            SecureField("", text: $password)
                                .placeholder(when: password.isEmpty){
                                    Text("Password")
                                        .foregroundColor(Color.white)
                                        .font(.headline)
                                }
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                              
                        } else {
                            TextField("", text: $password)
                                .placeholder(when: password.isEmpty){
                                    Text("Password")
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
                Divider().background(Color("Red").opacity(0.5))
            }
           
            
            VStack{
                
                HStack{
                    
                    Image(systemName: "lock.square.fill")
                        .foregroundColor(Color.white)
                    
                    Group{
                        if isSecuredConfirmation {
                            SecureField("", text: $passwordConfirmation)
                                .placeholder(when: passwordConfirmation.isEmpty){
                                    Text("Confirm Password")
                                        .foregroundColor(Color.white)
                                        .font(.headline)
                                }
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                              
                        } else {
                            TextField("", text: $passwordConfirmation)
                                .placeholder(when: passwordConfirmation.isEmpty){
                                    Text("Confirm Password")
                                        .foregroundColor(Color.white)
                                        .font(.headline)
                                }
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                                
                        }
                    }
                    Button {
                        isSecuredConfirmation.toggle()
                    } label: {
                        Image(systemName: self.isSecuredConfirmation ? "eye.slash" : "eye").accentColor(Color("DarkRed"))
                    }.padding()
                }
                Divider().background(Color("Red").opacity(0.5))
            }
            .padding(.bottom)
            
            Button(action: {
                if (!username.isEmpty && !email.isEmpty && !password.isEmpty && !passwordConfirmation.isEmpty ){
                    if password == passwordConfirmation {
                        user.signUp(email: email, password: password, username: username)
                    }
                    else{
                        user.alertTitle = "Error"
                        user.alertMessage = "Your password and confirmation password do not match"
                        user.showingAlert = true
                    }

                } else {
                    user.alertTitle = "Error"
                    user.alertMessage = "Fields cannot be empty"
                    user.showingAlert = true
                }
            }){
                Text("Sign Up")
                    .frame(width: 200, height: 50)
                    .cornerRadius(10)
                    .bold()
                    .foregroundColor(Color.white)
                    .background(isAnimtaing ?  Color("Red") : Color("DarkRed"))
                    .shadow(
                        color: isAnimtaing ? Color("Red") : Color("DarkRed"),
                        radius: isAnimtaing ? 20 : 10,
                        x: 0,
                        y: isAnimtaing ? 10 : 5)
                    .scaleEffect(isAnimtaing ? 1.1 : 1.0)
                    .offset(y: isAnimtaing ? -7 : 0)
                    .padding()
            }
            
            
        }
        .onAppear(perform: addAnimation)
       
        
    }
    func addAnimation(){
        guard !isAnimtaing else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() )  {
            withAnimation(
            Animation
                .easeInOut(duration:  2.0)
                .repeatForever()
            ) {
                isAnimtaing.toggle()
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
