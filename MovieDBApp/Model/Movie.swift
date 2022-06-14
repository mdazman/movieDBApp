//
//  Movie.swift
//  MovieDBApp
//
//  Created by AZMAN MUHAMMAD on 14/6/22.
//

import Foundation

struct Movie: Identifiable {
    let id: Int?
    let title: String?
    let releaseDate: String?
    let voteAverage: Float?
    let overview: String?
    let posterPath: String?
    let backdropPath: String?
}
