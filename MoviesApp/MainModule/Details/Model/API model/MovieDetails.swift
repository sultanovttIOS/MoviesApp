//
//  MovieDetails.swift
//  MoviesApp
//
//  Created by Alisher Sultanov on 26/4/25.
//

import Foundation

struct MovieDetails: Codable {
    let title: String?
    let description: String?
    let tagline: String?
    let year: String?
    let releaseDate: String?
    let imdbRating: String?
    let runtime: Int?
    let genres: [String]?
    let imdbId: String?
    let directors: [String]?
    let stars: [String]?
    let youtubeTrailerKey: String?
    let language: [String]?
    let countries: [String]?
}

