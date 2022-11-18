//
//  LoginView.swift
//  MovieCat
//
//  Created by Bartosz Rzechółka on 18/11/2022.
//

import SwiftUI

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    
    @State var maxRectangleHeight: CGFloat = 0
    
    @State var isSecured: Bool = true
    @State var isAnimtaing: Bool = false
    
    var body: some View {
        VStack {
            
            GeometryReader{proxy -> AnyView in
                
                let height = proxy.frame(in: .global).height
                
                DispatchQueue.main.async {
                    if maxRectangleHeight == 0 {
                        maxRectangleHeight = height
                    }
                }
                
                return AnyView(
                
                    ZStack{
                        Rectangle()
                            .fill(Color("Red"))
                            .rotationEffect(Angle(degrees: 20))
                            .offset(x:getRect().width / 2, y: -height / 1.2)
                        
                        Rectangle()
                            .fill(Color("DarkRed"))
                            .rotationEffect(Angle(degrees: 70))
                            .shadow(color: Color.black, radius: 5, x: 10, y: 0)
                            .offset(x: -getRect().width / 2, y: -height / 1.2)
                           
                    
                    }
                
                )
            }
            .frame(maxHeight: getRect().width)
            
            
            VStack {
             Text("Sign In")
                    .font(.title)
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
                
                Button(action: {
                    
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
                
                Text("Don't have an account yet?")
                    .font(.headline)
                    .padding([.top, .leading, .trailing])
                NavigationLink("Create Account", destination: SignUpView())
                    .padding([.leading, .bottom, .trailing])
                
            }
            .padding()
            .onAppear(perform: addAnimation)
            .padding(.top, -maxRectangleHeight / 2 )
            .frame(maxHeight: .infinity, alignment: .top)
            
           
            
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(
            HStack{
                Rectangle()
                    .fill(Color("Red"))
                    .rotationEffect(Angle(degrees: 100))
                    .frame(width: 100, height: 100)
                    .offset(x: -30, y: 100)
                
                Spacer(minLength: 0)
                
                Rectangle()
                    .fill(Color("DarkRed"))
                    .rotationEffect(Angle(degrees: 30))
                    .frame(width: 130, height: 130)
                    .offset(x: 30, y: 80)
                
            }
            ,alignment: .bottom
        )
        

    }
    func addAnimation(){
        guard !isAnimtaing else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5)  {
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


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

extension View{
    
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
    

}
