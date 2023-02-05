//
//  SearchView.swift
//  ShoppingApp
//
//  Created by kz on 14/11/2022.
//

import SwiftUI

struct SearchView: View {
    
    @ObservedObject var movieSearchState = MovieSearchState()
    @EnvironmentObject var user: UserViewModel
        
    var body: some View {
        NavigationView {
            VStack{
                LoadingView(isLoading: self.movieSearchState.isLoading, error: self.movieSearchState.error) {
                    self.movieSearchState.search(query: self.movieSearchState.query)
                }
                if self.movieSearchState.movies != nil {
                    List(self.movieSearchState.movies!) { movie in
                        MovieCell(movieID: movie.id)
                    }
                }
                Spacer()
            }
            .navigationBarTitle("Search")
            .navigationBarTitleDisplayMode(NavigationBarItem.TitleDisplayMode.inline)
        }
        .listStyle(.sidebar)
        .scrollContentBackground(.hidden)
        .onAppear {
            self.movieSearchState.startObserve()
        }
        .searchable(text: self.$movieSearchState.query)
    }
}

struct MovieImage: View{

    @StateObject private var imageLoader = ImageLoader()
    let imageURL: URL

    var body: some View{
        ZStack{
            if let image = imageLoader.image{
                Image(uiImage: image).resizable()
            }
        }
        .frame(width: 50, height: 75)
        .aspectRatio(contentMode: .fit)
        .onAppear{
            imageLoader.loadImage(with: imageURL)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    
    static let myEnvObject = UserViewModel()
    static var previews: some View {
        SearchView()
            .environmentObject(myEnvObject)
    }
}
