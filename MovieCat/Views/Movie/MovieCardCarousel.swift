//
//  MovieCardCarousel.swift
//  MovieCat
//
//  Created by kz on 24/11/2022.
//

import SwiftUI

struct MovieCardCarousel: View {
    
    let title: String
    let movies: [Movie]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal)
            ScrollView(.horizontal,showsIndicators: false){
                HStack(alignment: .top, spacing: 15){
                    ForEach(self.movies){ movie in
                        NavigationLink(destination: MovieDetails(movie: movie)){
                            MovieCard(movie: movie)
                        }
                            .frame(width: 270, height: 200)
                            .padding(.leading, movie.id == self.movies.first!.id ? 16  : 0)
                            .padding(.trailing, movie.id == self.movies.last!.id ? 16  : 0)

                    }
                }
            }
        }
    }
}

struct MovieCardCarousel_Previews: PreviewProvider {
    static var previews: some View {
        MovieCardCarousel(title:"Latest", movies: Movie.stubbedMovies)
    }
}
