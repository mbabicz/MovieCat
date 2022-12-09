//
//  FavoritesView.swift
//  MovieCat
//
//  Created by kz on 14/11/2022.
//

import SwiftUI

struct FavoritesView: View {
    var body: some View {
        NavigationView{
            VStack{
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            }
            .navigationTitle("Favoritres")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
