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
            ZStack{
                if(user.watchListIDs.isEmpty != true){
                    VStack{
                        List(user.watchListIDs, id: \.self) { id in
                            FavoriteMovieLoader(movieID: Int(id)!)
                            
                        }
                    }
                    
                }
                else {
                    VStack{
                        Text("Your Watchlist will appear here")
                            .font(.title)
                        Text("Add movie to your Watchlist by clicking \(Image(systemName: "heart.fill"))  in the details view of the movie")
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.gray.opacity(0.75))
                        
                    }
                    
                }
            }
            .navigationTitle("WatchList")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.black, for: .navigationBar)
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

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
