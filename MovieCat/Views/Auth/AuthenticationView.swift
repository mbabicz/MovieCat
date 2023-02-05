//
//  AuthenticationView.swift
//  ShoppingApp
//
//  Created by kz on 18/11/2022.
//

import SwiftUI


struct AuthenticationView: View {
    
    @EnvironmentObject var user: UserViewModel
    
    @State var showSignUp = false
    
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
                            .fill(Color(showSignUp ? "DarkRed" : "Red"))
                            .rotationEffect(Angle(degrees:showSignUp ? 70 : 20))
                            .offset(x:showSignUp ?  -getRect().width / 2 : getRect().width / 2, y: -height / 1.2)
                        
                        Rectangle()
                            .fill(Color(showSignUp ? "Red" : "DarkRed"))
                            .rotationEffect(Angle(degrees:showSignUp ? 20 : 70))
                            .shadow(color: Color.black, radius: 5, x: 10, y: 10)
                            .offset(x:showSignUp ? getRect().width / 2 : -getRect().width / 2 , y: -height / 1.2)
                    }
                )
            }
            .frame(maxHeight: getRect().width)
            
            ZStack{
                if showSignUp {
                    SignUpView()
                        .transition(.move(edge: .trailing))
                }else {
                    SignInView()
                        .transition(.move(edge: .trailing))
                }
            }
            .padding()
            .padding(.top, -maxRectangleHeight / 1.4)
            .frame(maxHeight: .infinity, alignment: .top)
            
            VStack{
                Text(showSignUp ? "Already Member ?" : "New Member ?")
                    .font(.headline)
                    .padding([.top, .leading, .trailing])
                
                Button(action: {
                    withAnimation{
                        showSignUp.toggle()
                    }
                }) {
                    Text(showSignUp ? "Sign In" : "Sign Up")
                        .font(.headline)
                        .foregroundColor(Color("DarkRed"))
                }
                Button {
                    user.signInAnonymously()
                    
                } label: {
                    Text("Continue as a guest")
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .offset(y: -56)
        }
        .alert(isPresented: $user.showingAlert){
            Alert(
                title: Text(user.alertTitle),
                message: Text(user.alertMessage),
                dismissButton: .default(Text("OK"))
            )
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
}

struct AuthenticationView_Previews: PreviewProvider {
    
    static let myEnvObject = UserViewModel()

    static var previews: some View {
        AuthenticationView()
            .preferredColorScheme(.dark)
            .environmentObject(myEnvObject)
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


