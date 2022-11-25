//
//  MovieSearchState.swift
//  MovieCat
//
//  Created by kz on 25/11/2022.
//

import Foundation
import Combine

class MovieSearchState: ObservableObject{
    
    @Published var movies: [Movie]?
    @Published var isLoading = false
    @Published var error: NSError?
    @Published var query = ""

    let movieService: MovieService
    
    private var token: AnyCancellable?
    
    init(movieService: MovieService = MovieStore.shared){
        self.movieService = movieService
    }
    
    func startObserve(){
        guard token == nil else { return }
        self.token = self.$query.map{ [weak self] text in
            self?.movies = nil
            self?.error = nil
            return text
        }
        .throttle(for: 1, scheduler: DispatchQueue.main, latest: true)
        .sink {[weak self] in self?.search(query: $0)}
    
    }
    
    func search(query: String){
        self.movies = nil
        self.isLoading = false
        self.error = nil
        
        if !query.isEmpty {
            
            self.isLoading = true
            self.movieService.searchMovie(query: query){ [weak self] (result) in
                guard let self = self, self.query == query else { return }
                
                self.isLoading = false
                switch result {
                case .success(let response):
                    self.movies = response.results
                case .failure(let error):
                    self.error = error as NSError
                }

            }
            
        }
        
    }
    
    deinit{
        self.token?.cancel()
        self.token = nil
    }
}

