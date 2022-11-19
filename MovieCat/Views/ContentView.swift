//
//  ContentView2.swift
//  ShoppingApp
//
//
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var user: UserViewModel
    
    var body: some View {
        NavigationView {
            if user.userIsAuthenticatedAndSynced{
                TabView{
                    HomeView().tabItem {
                        Image(systemName: "house.fill")
                    }.tag(0)
                    SearchView().tabItem {
                        Image(systemName: "magnifyingglass")
                    }.tag(1)
                    FavoritesView().tabItem {
                        Image(systemName: "star.fill")
                    }.tag(2)
                    ProfileView().tabItem {
                        Image(systemName: "person.fill")
                    }.tag(3)

                }.accentColor(.black)
                
                ProfileView()
            }
            else{
                AuthenticationView()
            }
        }
        .onAppear{
            if user.userIsAuthenticated{
                user.sync()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
