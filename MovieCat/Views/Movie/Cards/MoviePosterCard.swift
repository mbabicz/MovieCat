//
//  MoviePosterCard.swift
//  MovieCat
//
//  Created by kz on 24/11/2022.
//

import SwiftUI

struct MoviePosterCard: View {
    
    let movie: Movie
    @ObservedObject var imageLoader = ImageLoader()


    var body: some View {
            ZStack{
                
                if self.imageLoader.image != nil{
                    Image(uiImage: self.imageLoader.image!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(13)
                        .shadow(radius: 5)
                } else {
                    Rectangle()
                        .cornerRadius(13)
                        .shadow(radius: 5)
                    Text(movie.title).multilineTextAlignment(.center)

                }
            }
            
            .frame(width: 200, height: 300)
            .onAppear{
                self.imageLoader.loadImage(with: self.movie.posterURL)
            }
    }

}

struct MoviePosterCard_Previews: PreviewProvider {
    static var previews: some View {
        MoviePosterCard(movie: Movie.stubbedMovie)
    }
}
