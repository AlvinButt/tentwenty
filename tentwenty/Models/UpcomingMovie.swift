//
//  UpcomingMovie.swift
//  tentwenty
//
//  Created by Arslan Ahmad on 09/08/2022.
//

import Foundation

struct UpcomingMovie: Decodable {
    
    let results: [Movie]
}


struct Movie: Decodable, Identifiable, Hashable {
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id: Int
    let title: String
    let backdrop_path: String?
    let poster_path: String?
    let overview: String
    let vote_average: Double
    let vote_count: Int
    let runtime: Int?
    let release_date: String?
    
    let genres: [MovieGenre]?
    let credits: MovieCredit?
    let videos: MovieVideoResponse?
    
//    enum CodingKeys: String, CodingKey {
//        case voteAverage = "vote_average"
//    }
    
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
    
    var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdrop_path ?? "")")!
    }
    
    var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(poster_path ?? "")")!
    }
    
    var genreText: String {
        genres?.first?.name ?? "n/a"
    }
    
    var ratingText: String {
        let rating = Int(vote_average)
        let ratingText = (0..<rating).reduce("") { (acc, _) -> String in
            return acc + "★"
        }
        return ratingText
    }
    
    var scoreText: String {
        guard ratingText.count > 0 else {
            return "n/a"
        }
        return "\(ratingText.count)/10"
    }
    
    var yearText: String {
        guard let releaseDate = self.release_date, let date = Utils.dateFormatter.date(from: releaseDate) else {
            return "n/a"
        }
        return Movie.yearFormatter.string(from: date)
    }
    
    var durationText: String {
        guard let runtime = self.runtime, runtime > 0 else {
            return "n/a"
        }
        return Movie.durationFormatter.string(from: TimeInterval(runtime) * 60) ?? "n/a"
    }
    
    var cast: [MovieCast]? {
        credits?.cast
    }
    
    var crew: [MovieCrew]? {
        credits?.crew
    }
    
    var directors: [MovieCrew]? {
        crew?.filter { $0.job.lowercased() == "director" }
    }
    
    var producers: [MovieCrew]? {
        crew?.filter { $0.job.lowercased() == "producer" }
    }
    
    var screenWriters: [MovieCrew]? {
        crew?.filter { $0.job.lowercased() == "story" }
    }
    
    var youtubeTrailers: [MovieVideo]? {
        videos?.results.filter { $0.youtubeURL != nil }
    }
    
}

struct MovieGenre: Decodable {
    
    let name: String
}

struct MovieCredit: Decodable {
    
    let cast: [MovieCast]
    let crew: [MovieCrew]
}

struct MovieCast: Decodable, Identifiable {
    let id: Int
    let character: String
    let name: String
}

struct MovieCrew: Decodable, Identifiable {
    let id: Int
    let job: String
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
    
    var youtubeURL: URL? {
        guard site == "YouTube" else {
            return nil
        }
        return URL(string: "https://youtube.com/watch?v=\(key)")
    }
}



//// MARK: - UpcomingMovie
//struct UpcomingMovie: Codable {
//    let results: [Movie]
//    let dates: Dates
//    let totalPages, page, totalResults: Int
//
//    enum CodingKeys: String, CodingKey {
//        case results, dates
//        case totalPages = "total_pages"
//        case page
//        case totalResults = "total_results"
//    }
//}
//
//// MARK: - Dates
//struct Dates: Codable {
//    let maximum, minimum: String
//}
//
//// MARK: - Result
//struct Movie: Codable {
//    let genreIDS: [Int]
//    let adult: Bool
//    let backdropPath: String
//    let id: Int
//    let originalTitle: String
//    let voteAverage, popularity: Double
//    let posterPath, overview, title: String
//    let originalLanguage: OriginalLanguage
//    let voteCount: Int
//    let releaseDate: String
//    let video: Bool
//
//    enum CodingKeys: String, CodingKey {
//        case genreIDS = "genre_ids"
//        case adult
//        case backdropPath = "backdrop_path"
//        case id
//        case originalTitle = "original_title"
//        case voteAverage = "vote_average"
//        case popularity
//        case posterPath = "poster_path"
//        case overview, title
//        case originalLanguage = "original_language"
//        case voteCount = "vote_count"
//        case releaseDate = "release_date"
//        case video
//    }
//}
//
//enum OriginalLanguage: String, Codable {
//    case en = "en"
//    case fi = "fi"
//    case fr = "fr"
//    case ja = "ja"
//}


class Utils {
    
    static let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return jsonDecoder
    }()
    
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        return dateFormatter
    }()
}
