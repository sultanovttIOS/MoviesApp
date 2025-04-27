//
//  NetworkService.swift
//  MoviesApp
//
//  Created by Alisher Sultanov on 26/4/25.
//

import UIKit
import OSLog

actor NetworkService: NetworkServiceProtocol {
    
    // MARK: Properties
    
    static let shared: NetworkServiceProtocol = NetworkService()
    
    private let session: URLSession = {
        let session = URLSession(configuration: .default)
        session.configuration.timeoutIntervalForRequest = 15
        return session
    }()
    
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    private let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        encoder.dateEncodingStrategy = .formatted(dateFormatter)
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()
    
    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier ?? "",
        category: String(describing: NetworkService.self)
    )
        
    private let baseURL = "https://movies-tv-shows-database.p.rapidapi.com/"
    private let apiKey = "f65c058536msh19c7f06e4be12a0p1a4907jsn4dab539d8e46"
    private let apiHost = "movies-tv-shows-database.p.rapidapi.com"
    
    
    // MARK: Get movies
    
    func getTrendingMovies(page: String?) async throws -> TrendMoviesResponse {
        guard let _ = URL(string: baseURL) else {
            logger.error("Invalid server URL: \(self.baseURL)")
            throw APIError.invalidServerURL
        }
        
        var components = URLComponents(string: baseURL)
        components?.queryItems = [
            URLQueryItem(name: "page", value: page)
        ]
        
        guard let finalURL = components?.url else {
            logger.error("Invalid URL after adding query parameters")
            throw APIError.invalidServerURL
        }
        
        var request = URLRequest(url: finalURL)
        request.httpMethod = "GET"
        request.addValue(apiHost, forHTTPHeaderField: "x-rapidapi-host")
        request.addValue(apiKey, forHTTPHeaderField: "x-rapidapi-key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("get-trending-movies", forHTTPHeaderField: "type")
        
        logger.info("Starting request: \(finalURL.absoluteString)")
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            logger.error("API response is not HTTP response")
            throw APIError.notHTTPResponse
        }
        
        guard httpResponse.statusCode == 200 else {
            var message = "Unexpected status code: \(httpResponse.statusCode)"
            if let serverMessage = String(data: data, encoding: .utf8) {
                message += "\n\(serverMessage)"
            }
            logger.error("\(message)")
            throw APIError.unexpectedStatusCode
        }
        
        if let jsonString = String(data: data, encoding: .utf8) {
            print(finalURL.absoluteString)
            print("Server response JSON:\n\(jsonString)")
        } else {
            print("Could not convert data to string.")
        }
        
        let trendMoviesResponse: TrendMoviesResponse
        do {
            trendMoviesResponse = try decoder.decode(TrendMoviesResponse.self, from: data)
            logger.info("Received trending movies for request: \(finalURL.absoluteString)")
        } catch {
            logger.error("Could not decode data for request: \(finalURL.absoluteString)\n\(error)")
            throw APIError.decodingError
        }
        return trendMoviesResponse
    }
    
    // MARK: Get Movie by ID
    
    func getMovieByID(movieID: String) async throws -> MovieDetails {
        guard let _ = URL(string: baseURL) else {
            logger.error("Invalid server URL: \(self.baseURL)")
            throw APIError.invalidServerURL
        }
        
        var components = URLComponents(string: baseURL)
        components?.queryItems = [
            URLQueryItem(name: "movieid", value: movieID)
        ]
        
        guard let finalURL = components?.url else {
            logger.error("Invalid URL after adding query parameters")
            throw APIError.invalidServerURL
        }
        
        var request = URLRequest(url: finalURL)
        request.httpMethod = "GET"
        request.addValue(apiHost, forHTTPHeaderField: "x-rapidapi-host")
        request.addValue(apiKey, forHTTPHeaderField: "x-rapidapi-key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("get-movie-details", forHTTPHeaderField: "type")
        
        logger.info("Starting request: \(finalURL.absoluteString)")
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            logger.error("API response is not HTTP response")
            throw APIError.notHTTPResponse
        }
        
        guard httpResponse.statusCode == 200 else {
            var message = "Unexpected status code: \(httpResponse.statusCode)"
            if let serverMessage = String(data: data, encoding: .utf8) {
                message += "\n\(serverMessage)"
            }
            logger.error("\(message)")
            throw APIError.unexpectedStatusCode
        }
        
        if let jsonString = String(data: data, encoding: .utf8) {
            print(finalURL.absoluteString)
            print("Server response JSON:\n\(jsonString)")
        } else {
            print("Could not convert data to string.")
        }
        
        let movieDetails: MovieDetails
        do {
            movieDetails = try decoder.decode(MovieDetails.self, from: data)
            logger.info("Received movie details for request: \(finalURL.absoluteString)")
        } catch {
            logger.error("Could not decode data for request: \(finalURL.absoluteString)\n\(error)")
            throw APIError.decodingError
        }
        return movieDetails
    }
}
