//
//  APIError.swift
//  MoviesApp
//
//  Created by Alisher Sultanov on 26/4/25.
//

import Foundation

enum APIError: Error {
    
    case invalidServerURL
    case notHTTPResponse
    case unexpectedStatusCode
    case decodingError
    case encodingError
}
