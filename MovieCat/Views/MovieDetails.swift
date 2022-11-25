//
//  MovieDetails.swift
//  MovieCat
//
//  Created by kz on 24/11/2022.
//

import SwiftUI

struct MovieDetails: View {
    
    let movie: Movie
    @ObservedObject var imageLoader = ImageLoader()
    
    var body: some View {
        ZStack{
            VStack{
                Text(movie.title).font(.largeTitle).foregroundColor(.red)
                MovieDetailImage(imageURL: movie.backdropURL)
                Spacer()
                
                VStack{
                    HStack{

                    }
                    Text(movie.overview)
                    Text(movie.yearText)
                    
                    Spacer()

                    
                }

            }

        }

    }
}

struct MovieDetailImage: View{
    
    @StateObject private var imageLoader = ImageLoader()
    let imageURL: URL
    
    var body: some View{
        ZStack{
            if let image = imageLoader.image{
                Image(uiImage: image).resizable()
            }
        }
        .aspectRatio(contentMode: .fit)
        .onAppear{
            imageLoader.loadImage(with: imageURL)
        }
    }
}

struct MovieDetails_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetails(movie: Movie.stubbedMovie)
    }
}
