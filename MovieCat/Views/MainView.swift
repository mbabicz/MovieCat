//
//  MainView.swift
//  MovieCat
//
//  Created by Bartosz Rzechółka on 27/11/2022.
//

import SwiftUI

struct MainView: View {
    
    @State var currentTab: Tab = .Home
  
    
    init(){
        UITabBar.appearance().isHidden = true
    }
    
    @Namespace var animation
    
    @State var currnetXValue: CGFloat = 0
    
    var body: some View {
        
        TabView(selection: $currentTab){
            
            HomeView()
               
                .tag(Tab.Home)
            
            SearchView()
              
                .tag(Tab.Search)
            
            FavoritesView()
               
                .tag(Tab.Favorites)
            
            ProfileView()
              
                .tag(Tab.Profile)
        }
      
        
        .overlay(
            HStack(spacing: 0){
                
                ForEach(Tab.allCases,id: \.rawValue){ tab in
                    
                    TabButton(tab: tab)
                    
                }
                
            }
                .padding(.vertical)
                .padding(.bottom, GetSafeArea().bottom == 0 ? 10 : (GetSafeArea().bottom - 10))
                .background(
                    Color("DarkRed")
                        .clipShape(TabbarCurve(currnetXValue: currnetXValue))
                
                )
            
            ,alignment: .bottom
        )
        .ignoresSafeArea(.all, edges: .bottom)
    }
    
    @ViewBuilder
    func TabButton(tab: Tab)->some View{
        
        GeometryReader {proxy in
            
            Button {
                withAnimation(.spring()){
                    currentTab = tab
                    
                    currnetXValue = proxy.frame(in: .global).midX
                }
            } label: {
                Image(systemName: tab.rawValue)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .padding(currentTab == tab ? 15 : 0)
                    .background(
                        ZStack{
                            if currentTab == tab{
                                Color("Red")
                                    .clipShape(Circle())
                                    .matchedGeometryEffect(id: "TAB", in: animation)
                            }
                        }
                            
                    )
                    .contentShape(Rectangle())
                    .offset(y: currentTab == tab ? -42 : 0)
            }
            
            .onAppear{
                
                if tab == Tab.allCases.first && currnetXValue == 0 {
                    
                    currnetXValue = proxy.frame(in: .global).midX
                }
                
            }
        }
        .frame(height: 20)
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .preferredColorScheme(.dark)
    }
}

enum Tab: String,CaseIterable{
    case Home = "popcorn.fill"
    case Search = "magnifyingglass"
    case Favorites = "heart.fill"
    case Profile = "person.fill"
}


extension View{
    
    func GetSafeArea()->UIEdgeInsets{
        
         guard let screen =
                UIApplication.shared.connectedScenes.first as?
                UIWindowScene else{
             return.zero
         }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else{
            return.zero
        }
        return safeArea
    }
}
