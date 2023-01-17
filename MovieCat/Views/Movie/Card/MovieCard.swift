//
//  MovieCard.swift
//  MovieCat
//
//  Created by kz on 23/11/2022.
//

import SwiftUI

struct MovieCard: View {
    
    let movie: Movie
    @ObservedObject var imageLoader = ImageLoader()


    var body: some View {
        VStack(alignment: .leading){
            ZStack{
                Rectangle()
                
                if self.imageLoader.image != nil{
                    Image(uiImage: self.imageLoader.image!)
                        .resizable()
                }
            }
            .aspectRatio(contentMode: .fit)
            .cornerRadius(13)
            .shadow(radius: 5)
            
            HStack{
                Text(movie.title)
                Text("(\(movie.yearText))")

            }
            
            }
        .lineLimit(1)
        .onAppear{
            self.imageLoader.loadImage(with: self.movie.backdropURL)
        }
    }

}

struct MovieCard_Previews: PreviewProvider {
    static var previews: some View {
        MovieCard(movie: Movie.stubbedMovie)
    }
}
