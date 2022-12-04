//
//  MovieDetails.swift
//  MovieCat
//
//  Created by kz on 24/11/2022.
//

import SwiftUI

struct MovieDetails: View {
    
    let movieID: Int
    
    @ObservedObject private var movieDetailState = MovieDetailState()

    var body: some View{
        ZStack{
            LoadingCardView(isLoading: self.movieDetailState.isLoading, error: self.movieDetailState.error){
                self.movieDetailState.loadMovie(id: self.movieID)
            }
            
            if movieDetailState.movie != nil {
                MovieDetailsView(movie: self.movieDetailState.movie!)
            }
        }
        .onAppear{
            self.movieDetailState.loadMovie(id: self.movieID)
        }
    }
    
}


struct MovieDetailsView: View {
    
    let movie: Movie
    @ObservedObject var imageLoader = ImageLoader()
    @State private var selectedTrailer: MovieVideo?
    
    
    var body: some View {
        
        ZStack{
            ScrollView{
                VStack{
                    Text(movie.title).font(.largeTitle).foregroundColor(.red)
                    MovieDetailImage(imageURL: movie.backdropURL)
                    HStack(){
                        Text(movie.yearText).foregroundColor(.orange).bold().padding(.leading)
                        Spacer()
                        Text(movie.durationText).foregroundColor(.orange).bold().padding([.leading, .trailing])
                        Spacer()
                        Text(movie.genreText).foregroundColor(.orange).bold().padding(.trailing)

                    }
                    .padding()
                                    
                    HStack(spacing: 2) {
                        VStack{
                            HStack{
                                Text("TMDB").foregroundColor(.orange).bold().font(.title2)
                                Image(systemName: "star.fill").foregroundColor(.yellow).font(.title2).offset(y:-1)
                                Text("\(movie.voteAverage, specifier: "%.1f")").font(.title2)
                                Text("(\(movie.voteCount))").font(.caption2)
                                    .foregroundColor(.secondary)
                                    .offset(y: 3)
                            }
                            
                            HStack{
                                Text("MOVIECAT").foregroundColor(.orange).bold().font(.title2)
                                Image(systemName: "star.fill").foregroundColor(.yellow).font(.title2).offset(y:-1)
                                Text("\(movie.voteAverage, specifier: "%.1f")").font(.title2)
                                Text("(\(movie.voteCount))").font(.caption2)
                                    .foregroundColor(.secondary)
                                    .offset(y: 3)
                            }
                        }
     
                    }
                    .padding(.bottom, 5)

                    Text(movie.overview).padding(.bottom)
                    
                    if movie.youtubeTrailers != nil && movie.youtubeTrailers!.count > 0 {
                        Text("TRAILERS").padding()

                        ForEach(movie.youtubeTrailers!){ trailer in
                            if(trailer.type == "Trailer"){
                                Button {
                                //TODO: open safari or youtube player
                                    //OpenURLAction(handler: URL(trailer.youtubeURL))


                                } label: {
                                    HStack{
                                        Text(trailer.name)
                                             .padding()
                                        Image(systemName: "play.circle")

                                    }
                                }
                            }

                        }
                    }

                    if movie.directors != nil && movie.directors!.count > 0 {
//                        Text("Rezyser").padding()
//                        ForEach(movie.directors!)
//                    }

                    Text("Obsada").padding()

                    
                    
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
        .frame(maxWidth: .infinity)
        .aspectRatio(contentMode: .fit)
        .onAppear{
            imageLoader.loadImage(with: imageURL)
        }
    }
}

struct MovieDetails_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetails(movieID: Movie.stubbedMovie.id)
    }
}
