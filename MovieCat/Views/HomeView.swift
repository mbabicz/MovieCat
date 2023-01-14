//
//  HomeView.swift
//  MovieCat
//
//  Created by kz on 14/11/2022.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject private var nowPlayingState = MovieListState()
    @ObservedObject private var upcomingState = MovieListState()
    @ObservedObject private var topRatedState = MovieListState()
    @ObservedObject private var popularState = MovieListState()
    
    @ObservedObject var movieSearchState = MovieSearchState()
    
    
    var body: some View {
        NavigationView{
            VStack{
                LoadingView(isLoading: self.movieSearchState.isLoading, error: self.movieSearchState.error) {
                    self.movieSearchState.search(query: self.movieSearchState.query)
                }
                if self.movieSearchState.movies != nil {
                    List(self.movieSearchState.movies!) { movie in
                        
                        MovieCell(movieID: movie.id)
                        
                    }
                } else {
                    List{
                        
                        Group{
                            if nowPlayingState.movies != nil {
                                MoviePosterCardCarousel(title: "IN CINEMA", movies: nowPlayingState.movies!)
                            } else {
                                LoadingView(isLoading: nowPlayingState.isLoading, error: nowPlayingState.error){
                                    self.nowPlayingState.loadMovies(with: .nowPlaying)
                                    
                                }
                            }
                        }
                        .listRowInsets(EdgeInsets(top: 14, leading: -15, bottom: 8, trailing: 0))
                        .listRowSeparator(.hidden)
                        
                        Group{
                            
                            if upcomingState.movies != nil {
                                MoviePosterCardCarousel(title: "UPCOMING", movies: upcomingState.movies!)
                            } else {
                                LoadingView(isLoading: upcomingState.isLoading, error: upcomingState.error){
                                    self.upcomingState.loadMovies(with: .upcoming)
                                    
                                }
                                
                            }
                        }
                        .listRowInsets(EdgeInsets(top: 14, leading: -15, bottom: 8, trailing: 0))
                        .listRowSeparator(.hidden)
                        
                        Group{
                            
                            if topRatedState.movies != nil {
                                MoviePosterCardCarousel(title: "TOP RATED", movies: topRatedState.movies!)
                            } else {
                                LoadingView(isLoading: topRatedState.isLoading, error: topRatedState.error){
                                    self.topRatedState.loadMovies(with: .topRated)
                                    
                                }
                                
                            }
                        }
                        .listRowInsets(EdgeInsets(top: 14, leading: -15, bottom: 8, trailing: 0))
                        .listRowSeparator(.hidden)
                        
                        Group{
                            
                            if popularState.movies != nil {
                                MoviePosterCardCarousel(title: "POPULAR", movies: popularState.movies!)
                            } else {
                                LoadingView(isLoading: popularState.isLoading, error: popularState.error){
                                    self.popularState.loadMovies(with: .popular)
                                    
                                }
                                
                            }
                        }
                        .listRowInsets(EdgeInsets(top: 14, leading: -15, bottom: 8, trailing: 0))
                        .listRowSeparator(.hidden)
                        
                    }
                    .listStyle(PlainListStyle())
                    .navigationTitle("MovieCat")
                    .navigationBarTitleDisplayMode(.inline)
                    .foregroundColor(Color.white)
                }
            }
            
            .padding(.bottom, 40)
            .onAppear{
                setupAppearance()
                self.nowPlayingState.loadMovies(with: .nowPlaying)
                self.upcomingState.loadMovies(with: .upcoming)
                self.popularState.loadMovies(with: .popular)
                self.topRatedState.loadMovies(with: .topRated)
                
                self.movieSearchState.startObserve()
                
            }
            
            .searchable(text: self.$movieSearchState.query)
        }
    }
        
        
    func setupAppearance(){
        UITableView.appearance().separatorStyle = .none
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
