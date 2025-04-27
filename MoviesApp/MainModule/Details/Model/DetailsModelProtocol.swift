//
//  DetailsModelProtocol.swift
//  MoviesApp
//
//  Created by Alisher Sultanov on 26/4/25.
//

import Foundation

protocol DetailsModelProtocol {
    var movie: MovieDetails? { get }
    
    func getMovieByID(movieID: String) async throws
}
