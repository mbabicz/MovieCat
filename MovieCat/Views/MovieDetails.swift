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
                HStack(){
                    Text(movie.yearText).foregroundColor(.orange).bold().padding(.leading)
                    Spacer()
                    Text("TODO: runtime").foregroundColor(.orange).bold().padding([.leading, .trailing])
                    Spacer()
                    Text("TODO: smth").foregroundColor(.orange).bold().padding(.trailing)

                }
                .padding()
                
                Text("TODO: tmdb rating").bold()
                Text("TODO: moviecat rating").bold()
                    .padding(.bottom)

                Text(movie.overview)


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
        .frame(maxWidth: .infinity)
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
