//
//  SearchView.swift
//  ShoppingApp
//
//  Created by kz on 14/11/2022.
//

import SwiftUI

struct SearchView: View {
    
    @ObservedObject var movieSearchState = MovieSearchState()
    @EnvironmentObject var user: UserViewModel
    @State private var isPushed = false
    
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                ZStack{
                    Rectangle()
                        .foregroundColor(Color.gray.opacity(0.25))
                    HStack{
                        Image(systemName: "magnifyingglass")
                        TextField("Search...", text: self.$movieSearchState.query)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                        if !movieSearchState.query.isEmpty{
                            Button {
                                self.movieSearchState.query = ""
                                
                            } label: {
                                Image(systemName: "multiply.circle.fill")
                                    .accentColor(Color("DarkRed"))
                            }.padding()
                        }
                        
                    }
                    .padding(.leading, 20)
                }
                .frame(height: 40)
                .cornerRadius(13)
                .padding()
                
                
                List{
                    LoadingCardView(isLoading: self.movieSearchState.isLoading, error: self.movieSearchState.error){
                        self.movieSearchState.search(query: self.movieSearchState.query)
                    }
                    if self.movieSearchState.query != "" && self.movieSearchState.movies != nil {
                        
                        ForEach(self.movieSearchState.movies!) { movie in
                            HStack {
                                HStack{
                                    MovieImage(imageURL: movie.posterURL)
                                    VStack(alignment: .leading){
                                        Text(movie.title)
                                            .padding([.top, .leading, .trailing])
                                        Text("(\(movie.yearText))")
                                            .padding([.bottom, .leading, .trailing])
                                    }
                                }
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 7)
                                    .foregroundColor(Color("DarkRed"))
                            }
                            .foregroundColor(.white)
                            .background(
                                NavigationLink(destination: MovieDetails(movieID: movie.id)){}
                                    .opacity(0)
                                
                            )
                        }
                        
                        
                    } else {
                        //                        if(user.latestSearchedIDs.isEmpty != true){
                        //                            VStack{
                        //                                ForEach(user.latestSearchedIDs, id: \.self) { id in
                        //                                    //FavoriteMovieLoader(movieID: Int(id)!)
                        //                                    Text(id)
                        //
                        //                                }
                        //                            }
                        //
                    }
                    
                    //                        
                    //                        ForEach(self.movieSearchState.movies!) { movie in
                    //                            HStack {
                    //                                HStack{
                    //                                    MovieImage(imageURL: movie.posterURL)
                    //                                    VStack(alignment: .leading){
                    //                                        Text(movie.title)
                    //                                            .padding([.top, .leading, .trailing])
                    //                                        Text("(\(movie.yearText))")
                    //                                            .padding([.bottom, .leading, .trailing])
                    //                                    }
                    //                                }
                    //                                       Spacer()
                    //                                       Image(systemName: "chevron.right")
                    //                                         .resizable()
                    //                                         .aspectRatio(contentMode: .fit)
                    //                                         .frame(width: 7)
                    //                                         .foregroundColor(Color("DarkRed"))
                    //                                     }
                    //                                     .foregroundColor(.white)
                    //                                     .background(
                    //                                        NavigationLink(destination: MovieDetails(movieID: movie.id).onAppear{
                    //                                            user.addLatestSearched(movieID: String(movie.id))
                    //                                        }) {}
                    //                                           .opacity(0)
                    //                                     )
                    //
                    //                        }
                    
                }
                
            }
            .onAppear{
                self.movieSearchState.startObserve()
            }
            
        }
        .navigationTitle("Wyszukiwarka")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MovieImage: View{
    
    @StateObject private var imageLoader = ImageLoader()
    let imageURL: URL
    
    var body: some View{
        ZStack{
            if let image = imageLoader.image{
                Image(uiImage: image).resizable()
            }
        }
        .frame(width: 50, height: 75)
        .aspectRatio(contentMode: .fit)
        .onAppear{
            imageLoader.loadImage(with: imageURL)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
