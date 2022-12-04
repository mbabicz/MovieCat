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
                    if self.movieSearchState.movies != nil {
                        ForEach(self.movieSearchState.movies!) { movie in
                            NavigationLink(destination: MovieDetails(movieID: movie.id)) {
                                VStack(alignment: .leading){
                                    Text(movie.title)
                                    Text("(\(movie.yearText))")

                                }
                            }
                        }
                    }
                    
                }
                .onAppear{
                    self.movieSearchState.startObserve()
                }
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .principal){
                    Text("Wyszukiwarka").font(.headline).bold()
                }
            }
        }
        .accentColor(Color("DarkRed"))
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
