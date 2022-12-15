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
    @State private var isPushed = false
    
    
    var body: some View {
        NavigationView {
            VStack{
                SearchBarView(placeholder: "Search movies", text: self.$movieSearchState.query)
                    .listRowInsets(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                
                LoadingView(isLoading: self.movieSearchState.isLoading, error: self.movieSearchState.error) {
                    self.movieSearchState.search(query: self.movieSearchState.query)
                }
                if self.movieSearchState.movies != nil {
                    List(self.movieSearchState.movies!) { movie in
                        NavigationLink(destination: MovieDetails(movieID: movie.id).onAppear{
                            //TODO: find solution to call this method
                            //user.addLatestSearched(movieID: String(movie.id))
                        }){
                            MovieCell(movieID: movie.id)
//                            HStack {
//                                HStack{
//                                    MovieImage(imageURL: movie.posterURL)
//                                    VStack(alignment: .leading){
//                                        Text(movie.title)
//                                            .padding([.top, .leading, .trailing])
//                                            .foregroundColor(.white)
//                                        Text("(\(movie.yearText))")
//                                            .padding([.bottom, .leading, .trailing])
//                                            .foregroundColor(.white)
//
//                                    }
//                                }
//                                Spacer()
//                            }
                            Divider()
                                .foregroundColor(.white)
                        }
                    }
                }
                else {
                    if user.latestSearchedIDs.isEmpty != true {
                        VStack{
                            HStack{
                                Text("Recently Searched")
                                Spacer()
                                Button {
                                    user.clearLatestSearched()
                                } label: {
                                    HStack{
                                        Image(systemName: "xmark.circle")
                                        Text("Clear")
                                        
                                    }
                                }
                                
                            }
                            List(user.latestSearchedIDs, id: \.self) { id in
                                MovieCell(movieID: Int(id)!)
                                
                            }
                        }
                        
                    }
                    else{
                        Text("Search movie")
                    }
                    
                }
                
                
                Spacer()
            }
            
        }
        
        .listStyle(.grouped)
        .scrollContentBackground(.hidden)
        .onAppear {
            self.movieSearchState.startObserve()
        }
        .navigationBarTitle("Search")
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
