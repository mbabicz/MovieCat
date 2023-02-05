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
    @State var isAnimating: Bool = false
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
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                        
                       
                        
                        
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
                    user.updateAlert(title: "Error", message: "Fields cannot be empty")
                }
            }){
                Text("Sign In")
                    .frame(width: 200, height: 50)
                    .cornerRadius(10)
                    .bold()
                    .foregroundColor(Color.white)
                    .background(isAnimating ?  Color("Red") : Color("DarkRed"))
                    .shadow(
                        color: isAnimating ? Color("Red") : Color("DarkRed"),
                        radius: isAnimating ? 20 : 10,
                        x: 0,
                        y: isAnimating ? 10 : 5)
                    .scaleEffect(isAnimating ? 1.1 : 1.0)
                    .offset(y: isAnimating ? -7 : 0)
                    .padding()
            }
            
           
            
        }
        .onAppear(perform: addAnimation)
       
        
    }
    func addAnimation(){
        guard !isAnimating else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() )  {
            withAnimation(
            Animation
                .easeInOut(duration:  2.0)
                .repeatForever()
            ) {
                isAnimating.toggle()
            }
        }
    }
}

struct ResetPasswordView: View {
    
    @State var email = ""
    
    @EnvironmentObject var user: UserViewModel
    
    @State var isAnimating: Bool = false

    var body: some View {
        VStack {
            VStack{
                VStack{
                    
                    HStack{
                        
                        Image(systemName: "envelope.fill")
                            .foregroundColor(Color.white)
                        
                        TextField("", text: $email)
                            .placeholder(when: email.isEmpty) {
                                Text("Email Adress")
                                    .foregroundColor(Color.white)
                                    .font(.headline)
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                        }                           
                            
                            
                    }
                    Divider().background(Color("Red"))
                        
                }
                .padding(.top)
                    
                Button {
                    if !email.isEmpty {
                        user.resetPassword(email: email)
                        
                    } else {
                        user.updateAlert(title: "Error", message: "Fields cannot be empty")

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
                
                Image(systemName: "arrow.triangle.2.circlepath")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color("DarkRed").opacity(0.5))
                
                Spacer()

            }
            .padding()
            Spacer()
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(
            HStack{
                Rectangle()
                    .fill(Color("Red"))
                    .rotationEffect(Angle(degrees: 100))
                    .frame(width: 100, height: 100)
                    .offset(x: -30, y: 100)
                    .shadow(
                        color:  Color("Red"),
                        radius: 20,
                        x: 0,
                        y: 5)
                
                Spacer(minLength: 0)
                
                Rectangle()
                    .fill(Color("DarkRed"))
                    .rotationEffect(Angle(degrees: 30))
                    .frame(width: 130, height: 130)
                    .offset(x: 30, y: 80)
                    .shadow(
                        color:  Color("DarkRed"),
                        radius: 20,
                        x: 0,
                        y: 5)
                
            }
            ,alignment: .bottom
        )
        
        .navigationTitle("Recover Password")

    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
