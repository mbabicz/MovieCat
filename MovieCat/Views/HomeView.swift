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
    @ObservedObject private var latestState = MovieListState()

    var body: some View {
        NavigationView{
            List{
                Group{
                    if nowPlayingState.movies != nil {
                        MoviePosterCardCarousel(title: "Now Playing 🎬", movies: nowPlayingState.movies!)
                    } else {
                        LoadingCardView(isLoading: nowPlayingState.isLoading, error: nowPlayingState.error){
                            self.nowPlayingState.loadMovies(with: .nowPlaying)
                            
                        }
                    }
                }
                .listRowInsets(EdgeInsets(top: 14, leading: -15, bottom: 8, trailing: 0))
                .listRowSeparator(.hidden)
                Group{
                    
                    if upcomingState.movies != nil {
                        MovieCardCarousel(title: "Upcoming 📅", movies: upcomingState.movies!)
                    } else {
                        LoadingCardView(isLoading: upcomingState.isLoading, error: upcomingState.error){
                            self.upcomingState.loadMovies(with: .upcoming)
                            
                        }
                        
                    }
                }
                .listRowInsets(EdgeInsets(top: 14, leading: -15, bottom: 8, trailing: 0))
                .listRowSeparator(.hidden)

                Group{
                    
                    if topRatedState.movies != nil {
                        MoviePosterCardCarousel(title: "Top Rated 🌟", movies: topRatedState.movies!)
                    } else {
                        LoadingCardView(isLoading: topRatedState.isLoading, error: topRatedState.error){
                            self.topRatedState.loadMovies(with: .topRated)
                            
                        }
                        
                    }
                }
                .listRowInsets(EdgeInsets(top: 14, leading: -15, bottom: 8, trailing: 0))
                .listRowSeparator(.hidden)

                Group{
                    
                    if popularState.movies != nil {
                        MovieCardCarousel(title: "Popular 📈", movies: popularState.movies!)
                    } else {
                        LoadingCardView(isLoading: popularState.isLoading, error: popularState.error){
                            self.popularState.loadMovies(with: .popular)
                            
                        }
                        
                    }
                }
                .listRowInsets(EdgeInsets(top: 14, leading: -15, bottom: 8, trailing: 0))
                .listRowSeparator(.hidden)

                Group{
                    
                    if latestState.movies != nil {
                        MoviePosterCardCarousel(title: "Latest 🆕", movies: latestState.movies!)
                    } else {
                        LoadingCardView(isLoading: latestState.isLoading, error: latestState.error){
                            self.latestState.loadMovies(with: .popular)
                            
                        }
                        
                    }
                }
                .listRowInsets(EdgeInsets(top: 14, leading: -15, bottom: 8, trailing: 0))
                .listRowSeparator(.hidden)

            }
            .listStyle(PlainListStyle())
            .navigationTitle("MovieCat")
            .navigationBarTitleDisplayMode(.inline)
            .foregroundColor(.red)
        }
        .padding(.bottom, 40)
        .onAppear{
            setupAppearance()
            self.nowPlayingState.loadMovies(with: .nowPlaying)
            self.upcomingState.loadMovies(with: .upcoming)
            self.popularState.loadMovies(with: .popular)
            self.topRatedState.loadMovies(with: .topRated)
            self.latestState.loadMovies(with: .latest)

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
