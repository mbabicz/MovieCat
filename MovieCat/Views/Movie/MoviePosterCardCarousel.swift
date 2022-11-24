//
//  MoviePosterCardCarousel.swift
//  MovieCat
//
//  Created by kz on 24/11/2022.
//

import SwiftUI

struct MoviePosterCardCarousel: View {
    
    let title: String
    let movies: [Movie]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15){
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal)
            ScrollView(.horizontal, showsIndicators: false){
                HStack(alignment: .top, spacing: 15){
                    ForEach(self.movies){ movie in
                        MoviePosterCard(movie: movie)
                            .padding(.leading, movie.id == self.movies.first!.id ? 16  : 0)
                            .padding(.trailing, movie.id == self.movies.last!.id ? 16  : 0)

                    }
                }
            }
        }
    }
}

struct MoviePosterCardCarousel_Previews: PreviewProvider {
    static var previews: some View {
        MoviePosterCardCarousel(title:"Now Playing", movies: Movie.stubbedMovies)
    }
}
