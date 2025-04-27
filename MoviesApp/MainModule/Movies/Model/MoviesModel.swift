//
//  MoviesModel.swift
//  MoviesApp
//
//  Created by Alisher Sultanov on 26/4/25.
//

import Foundation

final class MoviesModel: MoviesModelProtocol {
    
    // MARK: Properties
    
    private let networkService: NetworkServiceProtocol
    private(set) var countOfAllMovies = 0
    private(set) var movies: [Movie] = []
    private var page: String = "2"
    
    // MARK: Lifecycle
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchMovies(append: Bool) async throws {
        if append && movies.count >= countOfAllMovies { return }
        
        let moviesResponse: TrendMoviesResponse
        
        if append {
            guard let pageInt = Int(page) else { return }
            page = String(pageInt + 1)
            moviesResponse = try await networkService.getTrendingMovies(page: page)
        } else {
            moviesResponse = try await networkService.getTrendingMovies(page: page)
            guard let totalMoviesCount = Int(moviesResponse.totalResults) else { return }
            countOfAllMovies = totalMoviesCount
        }
        movies.append(contentsOf: moviesResponse.movieResults)
        print(page)
    }
}
