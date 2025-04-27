//
//  DetailsModel.swift
//  MoviesApp
//
//  Created by Alisher Sultanov on 26/4/25.
//

import Foundation

class DetailsModel: DetailsModelProtocol {
    
    private let networkService: NetworkServiceProtocol
    private(set) var movie: MovieDetails?
    
    // MARK: Lifecycle
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    // MARK: Get Movie
    
    func getMovieByID(movieID: String) async throws {
        let movie = try await networkService.getMovieByID(movieID: movieID)
        self.movie = movie
    }
}
