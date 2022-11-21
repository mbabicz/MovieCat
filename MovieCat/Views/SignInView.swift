//
//  SignInView.swift
//  MovieCat
//
//  Created by Bartosz Rzechółka on 21/11/2022.
//

import SwiftUI

struct SignInView: View {
    
    @EnvironmentObject var user: UserViewModel
    
    @State var email = ""
    @State var password = ""
    
    @State var maxRectangleHeight: CGFloat = 0
    
    @State var isSecured: Bool = true
    @State var isAnimtaing: Bool = false
    var body: some View {
        VStack {
         Text("Sign In")
                .font(.system(size: 40))
                .fontWeight(.bold)
                .foregroundColor(Color("DarkRed"))
                .kerning(1.9)
                .frame(maxWidth: .infinity, alignment: .leading)
            
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
            .padding(.vertical)
            
            
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
            .padding(.vertical)
            
            NavigationLink("Forgot password?", destination: ResetPasswordView()).padding([.leading, .bottom, .trailing]).frame(maxWidth: .infinity, alignment: .trailing)
            
            Button(action: {
                if (!email.isEmpty && !password.isEmpty){
                    user.signIn(email: email, password: password)
                } else{
                    user.alertTitle = "Error"
                    user.alertMessage = "Fields cannot be empty"
                    user.showingAlert = true
                }
            }){
                Text("Sign In")
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

struct ResetPasswordView: View {
    
    @State var email = ""
    
    @EnvironmentObject var user: UserViewModel

    var body: some View {
        VStack {
            VStack{
                VStack{
                    
                    TextField("Email Adress", text: $email).padding()
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .background(Color(.secondarySystemBackground))
                        
                }
                    
                Button {
                    if !email.isEmpty {
                        user.resetPassword(email: email)
                        
                    } else {
                        user.alertTitle = "Error"
                        user.alertMessage = "Field cannot be empty"
                        user.showingAlert = true
                    }
                        
                } label: {
                    Text("Reset Password").frame(width: 200, height: 50).bold().foregroundColor(Color.white).background(Color.blue).cornerRadius(8).padding()
                }

            }
            .padding()
            Spacer()
        }
        .navigationTitle("Recover Password")

    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
