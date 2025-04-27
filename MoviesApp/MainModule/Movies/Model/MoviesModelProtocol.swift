//
//  MoviesModelProtocol.swift
//  MoviesApp
//
//  Created by Alisher Sultanov on 26/4/25.
//

import Foundation

protocol MoviesModelProtocol {
    var movies: [Movie] { get }
    
    func fetchMovies(append: Bool) async throws
}
