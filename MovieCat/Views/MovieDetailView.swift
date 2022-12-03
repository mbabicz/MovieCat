//
//  MovieDetailView.swift
//  MovieCat
//
//  Created by Bartosz Rzechółka on 03/12/2022.
//

import SwiftUI

struct MovieDetailView: View {
    var body: some View {
        ZStack{
            
         Color("DarkRed")
                
            
            VStack {
                Image("1234")
                    .resizable()
                    .cornerRadius(20)
                    .ignoresSafeArea()
                    .scaledToFit()

                Rectangle()
                    .foregroundColor(Color("DarkRed"))
                    .frame(height: 70)
                    .cornerRadius(20, corners: [.topLeft, .bottomLeft])
                    .shadow(color: .black, radius: 10)
                    .padding(.leading,60)
                    .overlay(content: {
                        HStack{
                            VStack {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.black)
                                .bold()
                                Text("678")
                                    .foregroundColor(.black)
                                    .bold()
                            }
                            
                            Spacer()
                            
                            VStack {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                .bold()
                                Text("678")
                                    .foregroundColor(.black)
                                    .bold()
                            }
                            
                            Spacer()
                            
                            VStack {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.black)
                                .bold()
                                Text("678")
                                    .foregroundColor(.black)
                                    .bold()
                            }
                        }
                        .padding(.horizontal)
                        .padding(.leading, 70)
                        .padding(.trailing, 20)
                    })
                    .offset(y:-40)

                
                Text("Title")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.black)
                    .font(.system(size:30, weight: .heavy, design: .none))
                    .padding(.leading)
                
                HStack{
                    Text("2022")
                    Text("PG-13")
                    Text("2h20min")
                }
                .foregroundColor(.black.opacity(0.5))
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
                
                Text("Bruce Banner, a scientist on the run from the U.S. Government, must find a cure for the monster he turns into whenever he loses his temper.")
                    .foregroundColor(.black)
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .padding()
                
                
                Spacer()
                
              
                    
                    
                
                    
         
            }
            
        }
        
        
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView()
            .preferredColorScheme(.dark)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
