//
//  FavoritesView.swift
//  MovieCat
//
//  Created by kz on 14/11/2022.
//

import SwiftUI

struct FavoritesView: View {
    
    @EnvironmentObject var user: UserViewModel

    var body: some View {
        NavigationView{
            if(user.watchListIDs.isEmpty != true){
                VStack{
                    List(user.watchListIDs, id: \.self) { id in
                        //Text(id)
                        FavoriteMovieLoader(movieID: Int(id)!)

                    }
                }

            }
            else {
                HStack{
                    Text("fav")
                    Button {
                        user.getUserWatchList()
                    } label: {
                        Text("test")
                    }
                }


            }
        }

        
    }

}

struct FavoriteMovieLoader: View{
    
    let movieID: Int
    @ObservedObject private var movieDetailState = MovieDetailState()


    var body: some View{
        ZStack{
            LoadingCardView(isLoading: self.movieDetailState.isLoading, error: self.movieDetailState.error){
                self.movieDetailState.loadMovie(id: self.movieID)
            }
            
            if movieDetailState.movie != nil {
                FavoriteMovieCard(movie: self.movieDetailState.movie!)
            }
        }
        
        .onAppear{
            self.movieDetailState.loadMovie(id: self.movieID)
        }
    }
    
}

struct FavoriteMovieCard: View{
    
    let movie: FullMovieModel
    @ObservedObject var imageLoader = ImageLoader()
    
    var body: some View{
        NavigationLink(destination: MovieDetails(movieID: movie.id)){
            HStack{
                MovieImage(imageURL: movie.posterURL)
                VStack{
                    Text(movie.title)
                        .padding([.top, .leading, .trailing])
                        .multilineTextAlignment(.center)
                    Text("(\(movie.yearText))")
                        .padding([.bottom, .leading, .trailing])
                    Spacer()
                }
            }
            
        }
    }
    
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
