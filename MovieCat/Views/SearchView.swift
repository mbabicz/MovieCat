//
//  SearchView.swift
//  ShoppingApp
//
//  Created by kz on 14/11/2022.
//

import SwiftUI

struct SearchView: View {
    
    @ObservedObject var movieSearchState = MovieSearchState()
    
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
                            NavigationLink(destination: MovieDetails(movieID: movie.id)){
                                HStack{
                                    MovieImage(imageURL: movie.posterURL)
                                    VStack{
                                        Text(movie.title)
                                            .padding([.top, .leading, .trailing])
                                            .multilineTextAlignment(.center)
                                        Text("(\(movie.yearText))")
                                            .padding([.bottom, .leading, .trailing])
                                        Spacer()
                                    }
                                }
                                
                            }
                            
                        }
                        
                    }
                    
                }
                .onAppear{
                    self.movieSearchState.startObserve()
                }
                
            }
            .navigationTitle("Wyszukiwarka")
            .navigationBarTitleDisplayMode(.inline)
        }
        
        
//        .toolbar{
//            ToolbarItem(placement: .principal){
//                Text("Wyszukiwarka").font(.headline).bold()
//            }
//        }
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
        .frame(width: 100, height: 150)
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
