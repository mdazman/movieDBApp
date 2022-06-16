//
//  Movie.swift
//  MovieDBApp
//
//  Created by AZMAN MUHAMMAD on 14/6/22.
//

import Foundation

struct MovieResponse: Codable {
    let totalPages: Int?
    let results: [Movie]?
}

struct Movie: Identifiable, Codable {
    let id: Int?
    let title: String?
    let releaseDate: String?
    let voteAverage: Float?
    let overview: String?
    let posterPath: String?
    let backdropPath: String?
    
    var posterData: Data?
    var backdropData: Data?
    
    func getFullPosterPath() -> String {
        guard let path = posterPath else {
            return ""
        }
        return "https://image.tmdb.org/t/p/w200"+path
    }
    
    func getFullBackdropPath() -> String {
        guard let path = backdropPath else {
            return ""
        }
        return "https://image.tmdb.org/t/p/w400"+path
    }
}
