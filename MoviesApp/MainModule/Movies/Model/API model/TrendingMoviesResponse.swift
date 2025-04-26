//
//  MoviesResponse.swift
//  MoviesApp
//
//  Created by Alisher Sultanov on 26/4/25.
//

import Foundation

struct TrendMoviesResponse: Codable {
    let movieResults: [Movie]
    let results: Int
    let totalResults: String
}

struct Movie: Codable {
    let title: String
    let year: String
    let imdbId: String
}

