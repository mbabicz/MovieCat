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
                VStack{
                    if self.imageLoader.image != nil{
                        Image(uiImage: self.imageLoader.image!)
                            .resizable()
                            .frame(width: 150, height: 225)
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(13)
                            .shadow(color: Color("Red"),radius: 5)
                    } else {
                        Rectangle()
                            .cornerRadius(13)
                            .shadow(color: Color("Red"),radius: 5)
                        Text(movie.title).multilineTextAlignment(.center)
                        
                    }
                    
                    
                        Text(movie.title)
                        .foregroundColor(.white)
                        Text("(\(movie.yearText))")
                        .foregroundColor(.white)

                }
                
            }
            .frame(maxWidth: 150)
            
            .padding()
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
