//
//  MovieDetails.swift
//  MovieCat
//
//  Created by kz on 24/11/2022.
//

import SwiftUI

struct MovieDetails: View {
    
    let movieID: Int
    @ObservedObject var imageLoader = ImageLoader()
    
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
    
    let movie: FullMovieModel
    @ObservedObject var imageLoader = ImageLoader()
    @EnvironmentObject var user: UserViewModel
    
    var body: some View {
        ZStack{
            ScrollView{
                Color.black
                
                VStack {
                    MovieDetailImage(imageURL: movie.backdropURL)
                    
                    
                    Rectangle()
                        .foregroundColor(Color("DarkRed"))
                        .frame(height: 70)
                        .cornerRadius(20, corners: [.topLeft, .bottomLeft])
                        .shadow(color: .black, radius: 10)
                        .padding(.leading,60)
                        .overlay(content: {
                            HStack{
                                if user.watchListIDs.contains(String(movie.id)) {
                                    Button {
                                        user.deleteMovieFromWatchList(movieID: String(movie.id))
                                    } label: {
                                        Image(systemName: "heart.fill")
                                            .resizable()
                                            .frame(width: 30, height: 25)
                                            .scaledToFit()
                                            .foregroundColor(Color("Red"))
                                            .bold()
                                    }
                                    
                                } else {
                                    Button {
                                        user.addMovieToWatchList(movieID: String(movie.id))
                                    } label: {
                                        Image(systemName: "heart.fill")
                                            .resizable()
                                            .frame(width: 30, height: 25)
                                            .scaledToFit()
                                            .foregroundColor(.white)
                                            .bold()
                                    }
                                }
                                
                                Spacer()
                                
                                VStack{
                                    HStack{
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.yellow)
                                            .bold()
                                        Text("\(movie.voteAverage, specifier: "%.1f")")
                                            .foregroundColor(.white)
                                            .bold()
                                    }
                                    Text("TMDB")
                                        .foregroundColor(.white)
                                        .bold()
                                        .font(.title2)
                                }
                                
                                Spacer()
                                
                                VStack{
                                    HStack{
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.yellow)
                                            .bold()
                                        Text("\(movie.voteAverage, specifier: "%.1f")")
                                            .foregroundColor(.white)
                                            .bold()
                                    }
                                    Text("MOVIECAT")
                                        .foregroundColor(.white)
                                        .bold()
                                        .font(.title2)
                                    
                                }
                                
                            }
                            .padding(.horizontal)
                            .padding(.leading, 70)
                            .padding(.trailing, 20)
                        })
                        .offset(y:-40)
                    
                    
                    Text(movie.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.white)
                        .font(.system(size:30, weight: .heavy, design: .none))
                        .padding(.leading)
                    
                    HStack{
                        Text(movie.yearText)
                        Text(movie.durationText)
                        Text(movie.genreText)
                    }
                    .foregroundColor(.white.opacity(0.5))
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                    
                    
                    Text(movie.overview)
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        .padding()
                    
                    
                    VStack{
                        if movie.cast != nil && movie.cast!.count > 0 {
                            VStack(alignment: .leading, spacing: 0){
                                Text("Stars")
                                    .foregroundColor(Color("Red"))
                                    .font(.system(size: 25, weight: .semibold, design: .rounded))
                                    .padding()
                                ScrollView(.horizontal, showsIndicators: false){
                                    HStack( spacing: 20){
                                        ForEach(movie.cast!.prefix(10)){ cast in
                                            GeometryReader { geometry in
                                                VStack{
                                                    MovieCastImage(imageURL: cast.profilePathURL)
                                                        .rotation3DEffect(Angle(degrees: (Double(geometry.frame(in: .global).minX) - 40) / 20), axis: (x: 0, y: 10, z: 0))
                                                    Text(cast.name)
                                                    Text(cast.character)
                                                }
                                            }
                                            .frame(width: 200, height: 250)
                                        }
                                    }
                                    .padding(.horizontal, 40)
                                    .padding(.top, 20)
                                    .padding(.bottom, 40)
                                    
                                }
                            }
                            
                        }
                        
                        if movie.directors != nil && movie.directors!.count > 0 {
                            VStack(alignment: .leading, spacing: 0){
                                Text("Directors")
                                    .foregroundColor(Color("Red"))
                                    .font(.system(size: 25, weight: .semibold, design: .rounded))
                                    .padding()
                                
                                ForEach(movie.directors!){ crew in
                                    ListBackGround(text: crew.name)
                                }
                            }
                        }
                        
                        if movie.producers != nil && movie.producers!.count > 0 {
                            VStack(alignment: .leading, spacing: 0){
                                Text("Producers")
                                    .foregroundColor(Color("Red"))
                                    .font(.system(size: 25, weight: .semibold, design: .rounded))
                                    .padding()
                                
                                ForEach(movie.producers!){ crew in
                                    ListBackGround(text: crew.name)
                                }
                            }
                        }
                        
                        if movie.screenWriters != nil && movie.screenWriters!.count > 0 {
                            VStack(alignment: .leading, spacing: 0){
                                Text("Screenwriters")
                                    .foregroundColor(Color("Red"))
                                    .font(.system(size: 25, weight: .semibold, design: .rounded))
                                    .padding()
                                
                                
                                ForEach(movie.screenWriters!){ crew in
                                    ListBackGround(text: crew.name)
                                }
                            }
                        }
                        
                        if movie.youtubeTrailers != nil && movie.youtubeTrailers!.count > 0 {
                            VStack(alignment: .leading, spacing: 0){
                                Text("Trailers")
                                    .foregroundColor(Color("Red"))
                                    .font(.system(size: 25, weight: .semibold, design: .rounded))
                                    .padding()
                                ForEach(movie.youtubeTrailers!){ trailer in
                                    if(trailer.type == "Trailer"){
                                        
                                        VideoView(videoID: trailer.key )
                                            .frame(height: 200)
                                            .cornerRadius(12)
                                            .padding(.horizontal, 24)
                                            .padding(.bottom,3)
                                    }
                                }
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 0){
                            Text("Boxoffice")
                                .foregroundColor(Color("Red"))
                                .font(.system(size: 25, weight: .semibold, design: .rounded))
                                .padding()
                            
                            Rectangle()
                                .frame(height: 20)
                                .foregroundColor(Color("DarkRed").opacity(0.5))
                                .cornerRadius(12)
                                .padding(.horizontal)
                                .padding(.vertical, 5)
                                .overlay {
                                    HStack{
                                        Text("Revenue:")
                                            .foregroundColor(.white)
                                            .font(.headline)
                                            .bold()
                                        Spacer()
                                        Text(movie.revenue, format: .currency(code: "USD").precision(.fractionLength(0)))
                                            .foregroundColor(.white)
                                            .font(.headline)
                                            .bold()
                                    }
                                    .padding(.horizontal, 25)
                                }
                            
                            Rectangle()
                                .frame(height: 20)
                                .foregroundColor(Color("DarkRed").opacity(0.5))
                                .cornerRadius(12)
                                .padding(.horizontal)
                                .padding(.vertical, 5)
                                .overlay {
                                    HStack{
                                        Text("Budget:")
                                            .foregroundColor(.white)
                                            .font(.headline)
                                            .bold()
                                        Spacer()
                                        Text(movie.budget, format: .currency(code: "USD").precision(.fractionLength(0)))
                                            .foregroundColor(.white)
                                            .font(.headline)
                                            .bold()
                                    }
                                    .padding(.horizontal, 25)
                                }
                            
                        }
                        
                        Rectangle()
                            .foregroundColor(.black)
                        
                        
                    }
                }
            }
        }
        .ignoresSafeArea()
            
        }
        
        
    }



extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct ListBackGround: View {
    
    let text: String
    
    var body: some View{
        
        Rectangle()
            .frame(height: 20)
            .foregroundColor(Color("DarkRed").opacity(0.5))
            .cornerRadius(12)
            .padding(.horizontal)
            .padding(.vertical, 5)
            .overlay {
                Text(text)
                    .foregroundColor(.white)
                    .font(.headline)
                    .bold()
            }
        
        
        
    }
}


struct MovieCastImage: View{

    @StateObject private var imageLoader = ImageLoader()
    let imageURL: URL

    var body: some View{
        ZStack{
            if let image = imageLoader.image{
                Image(uiImage: image).resizable().scaledToFit()
            }
        }
        .frame(height: 250)
        .scaledToFill()
        .cornerRadius(12)
        .shadow(color: Color("DarkRed"), radius: 5)
        .onAppear{
            imageLoader.loadImage(with: imageURL)
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
        .cornerRadius(12)
        .shadow(color: Color("DarkRed"), radius: 5)
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
