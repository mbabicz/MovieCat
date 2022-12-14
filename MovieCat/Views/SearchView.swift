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
                
                LoadingCardView(isLoading: self.movieSearchState.isLoading, error: self.movieSearchState.error) {
                    self.movieSearchState.search(query: self.movieSearchState.query)
                }
                if self.movieSearchState.movies != nil {
                    List(self.movieSearchState.movies!) { movie in
                        NavigationLink(destination: MovieDetails(movieID: movie.id).onAppear{
                            //TODO: find solution to call this method
                            //user.addLatestSearched(movieID: String(movie.id))
                        }){
                            HStack {
                                HStack{
                                    MovieImage(imageURL: movie.posterURL)
                                    VStack(alignment: .leading){
                                        Text(movie.title)
                                            .padding([.top, .leading, .trailing])
                                            .foregroundColor(.white)
                                        Text("(\(movie.yearText))")
                                            .padding([.bottom, .leading, .trailing])
                                            .foregroundColor(.white)
                                        
                                    }
                                }
                                Spacer()
                                //                                        Image(systemName: "chevron.right")
                                //                                            .resizable()
                                //                                            .aspectRatio(contentMode: .fit)
                                //                                            .frame(width: 7)
                                //                                            .foregroundColor(Color("DarkRed"))
                            }
                            Divider()
                                .foregroundColor(.white)
                        }
                    }
                }
                else {
                    if user.latestSearchedIDs.isEmpty != true {
                        //List{
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
                                MovieCardLoader(movieID: Int(id)!)

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


struct MovieCardLoader: View{
    
    let movieID: Int
    @ObservedObject private var movieDetailState = MovieDetailState()


    var body: some View{
        ZStack{
            LoadingCardView(isLoading: self.movieDetailState.isLoading, error: self.movieDetailState.error){
                self.movieDetailState.loadMovie(id: self.movieID)
            }
            
            if movieDetailState.movie != nil {
                MovieCardx(movie: self.movieDetailState.movie!)
            }
        }
        
        .onAppear{
            self.movieDetailState.loadMovie(id: self.movieID)
        }
    }
    
}

struct MovieCardx: View{
    
    let movie: FullMovieModel
    @ObservedObject var imageLoader = ImageLoader()
    
    var body: some View{
 
        HStack {
            HStack{
                MovieImage(imageURL: movie.posterURL)
                VStack(alignment: .leading){
                    Text(movie.title)
                        .padding([.top, .leading, .trailing])
                    HStack{
                        Text("(\(movie.yearText))")
                        Text("\(movie.durationText)")
                    }
                    .padding([ .leading, .trailing])
                    HStack{
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                            .bold()
                        Text("\(movie.voteAverage, specifier: "%.1f")")
                            .foregroundColor(.white)
                            .bold()
                    }
                    .padding([.bottom, .leading, .trailing])
                }
            }
                   Spacer()
                   Image(systemName: "chevron.right")
                     .resizable()
                     .aspectRatio(contentMode: .fit)
                     .frame(width: 7)
                     .foregroundColor(Color("DarkRed"))
                 }
                 .foregroundColor(.white)
                 .background(
                    NavigationLink(destination: MovieDetails(movieID: movie.id)) {}
                       .opacity(0)
                 )
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
    static var previews: some View {
        SearchView()
    }
}
