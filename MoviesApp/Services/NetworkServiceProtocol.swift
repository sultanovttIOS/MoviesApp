//
//  NetworkServiceProtocol.swift
//  MoviesApp
//
//  Created by Alisher Sultanov on 26/4/25.
//

import Foundation

protocol NetworkServiceProtocol: Actor {
    
    func getTrendingMovies(page: String?) async throws -> TrendMoviesResponse
    func getMovieByID(movieID: String) async throws -> MovieDetails
}
