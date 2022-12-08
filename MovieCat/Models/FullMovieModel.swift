//
//  Movie.swift
//  MovieCat
//
//  Created by kz on 23/11/2022.
//

import Foundation

struct FullMovieModel: Decodable, Identifiable {
    
    let id: Int
    let title: String
    let backdropPath: String?
    let posterPath: String?
    let overview: String
    let voteAverage: Double
    let voteCount: Int
    let runtime: Int?
    let releaseDate: String?
    
    let budget: Int
    let revenue: Int
    
    let videos: MovieVideoResponse?
    let genres: [MovieGenre]?
    let credits: MovieCredit?
    
    

    
    var yearText: String {
        guard let releaseDate = self.releaseDate, let date = Utils.dateFormatter.date(from: releaseDate) else {
            return ""
        }
        return FullMovieModel.yearFormatter.string(from: date)
    }
    
    var durationText: String {
        guard let runtime = self.runtime, runtime > 0 else {
            return "n/as"
        }
        return FullMovieModel.durationFormatter.string(from: TimeInterval(runtime) * 60) ?? "n/a"

    }
    
    var backdropURL : URL{
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")!
    }
    
    var posterURL : URL{
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }
    
    var genreText: String {
        genres?.first?.name ?? "N/A"
    }
    
    
    static private let yearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }()
    
    static private let durationFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.hour, .minute]
        return formatter
    }()
    
    var youtubeTrailers: [MovieVideo]? {
        videos?.results.filter { $0.youtubeURL != nil }
    }
    
    var crew: [MovieCrew]? {
        credits?.crew
    }
    
    var directors: [MovieCrew]? {
        crew?.filter { $0.job.lowercased() == "director" }
    }
    var producers: [MovieCrew]?{
        crew?.filter{ $0.job.lowercased() == "producer"}
    }
    
    var screenWriters: [MovieCrew]?{
        crew?.filter{ $0.job.lowercased() == "story"}
    }
    
    var cast: [MovieCast]? {
        credits?.cast
    }
        
}


struct MovieCredit: Decodable {
    
    let cast: [MovieCast]
    let crew: [MovieCrew]
}

struct MovieCrew: Decodable, Identifiable {
    let id: Int
    let job: String
    let name: String
    
}

struct MovieCast: Decodable, Identifiable {
    let id: Int
    let character: String
    let name: String
    let profilePath: String?
    
    
    var profilePathURL : URL{
        return URL(string: "https://image.tmdb.org/t/p/w500\(profilePath ?? "")")!
    }
}

struct MovieGenre: Decodable {
    let name: String
}

struct MovieVideoResponse: Decodable {
    let results: [MovieVideo]
}

struct MovieVideo: Decodable, Identifiable {
    let id: String
    let key: String
    let name: String
    let site: String
    let type: String
    
    var youtubeURL: URL?{
        guard site == "YouTube" else {
            return nil
        }
        return URL(string: "https://www.youtube.com/watch?v=\(key)")
       
    }
}
