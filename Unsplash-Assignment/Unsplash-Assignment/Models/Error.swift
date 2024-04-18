//
//  Error.swift
//  Unsplash-Assignment
//
//  Created by Ashwin Kumar on 16/04/24.
//

import Foundation

// Enum defining possible application errors
enum AppError: Error, LocalizedError {
    case invalidData // Invalid data received from the server
    case invalidURL // Invalid or broken URL
    case serverError // Issue connecting to the server
    case unknown(Error) // Unknown error
    
    // Error descriptions for different cases
    var errorDescription: String? {
        switch self {
            case .invalidData:
                return "The data received from the server is invalid. Please try again later."
            case .invalidURL:
                return "The URL is invalid or may be broken. Please try again later."
            case .serverError:
                return "There was an issue connecting to the server. Please try again later."
            case .unknown(let error):
                return error.localizedDescription
        }
    }
}
