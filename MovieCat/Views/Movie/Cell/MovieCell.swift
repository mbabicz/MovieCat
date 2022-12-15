//
//  MovieCell.swift
//  MovieCat
//
//  Created by kz on 15/12/2022.
//

import SwiftUI

struct MovieCell: View {
    
    let movieID: Int
    @ObservedObject private var movieDetailState = MovieDetailState()


    var body: some View{
        ZStack{
            LoadingView(isLoading: self.movieDetailState.isLoading, error: self.movieDetailState.error){
                self.movieDetailState.loadMovie(id: self.movieID)
            }
            
            if movieDetailState.movie != nil {
                MovieCellView(movie: self.movieDetailState.movie!)
            }
        }
        
        .onAppear{
            self.movieDetailState.loadMovie(id: self.movieID)
        }
    }
}



struct MovieCellView: View{
    
    let movie: FullMovieModel
    @ObservedObject var imageLoader = ImageLoader()
    
    var body: some View{
        
        HStack {
            HStack{
                MovieCellImage(imageURL: movie.posterURL)
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


struct MovieCellImage: View{
    
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

struct MovieCell_Previews: PreviewProvider {
    static var previews: some View {
        MovieCell(movieID: Movie.stubbedMovie.id)
    }
}
