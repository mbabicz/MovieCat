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
            if user.userIsAuthenticated && !user.userIsAuthenticatedAndSynced {
                LoadingView()
            }
            else if user.userIsAuthenticatedAndSynced{
                
                MainView()
            
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
