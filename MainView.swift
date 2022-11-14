//
//  MainView.swift
//  MovieCat
//
//  Created by kz on 14/11/2022.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView{
            HomeView().tabItem {
                Image(systemName: "house.fill")
            }.tag(0)
            SearchView().tabItem {
                Image(systemName: "house.fill")
            }.tag(1)
            SearchView().tabItem {
                Image(systemName: "house.fill")
            }.tag(2)
        }.accentColor(.black)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
