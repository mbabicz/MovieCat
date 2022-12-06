//
//  MovieCastCard.swift
//  MovieCat
//
//  Created by kz on 05/12/2022.
//

import SwiftUI

struct MovieCastCard: View {
    
    //let movie.cast: Movie.
    //let imageURL: URL

    
    @ObservedObject var imageLoader = ImageLoader()

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
//    .onAppear{
//        self.imageLoader.loadImage(with: self.movie.backdropURL)
//    }
}

struct MovieCastCard_Previews: PreviewProvider {
    static var previews: some View {
        MovieCastCard(/*imageURL: imageURL*/)
    }
}
