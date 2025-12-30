//
//  NetworkError.swift
//  GitHubRepoViewerTask
//
//  Created by Amr Magdy on 30/12/2025.
//


import Foundation

enum NetworkError: Error, LocalizedError, Equatable {
    case invalidURL
    case noData
    case invalidResponse
    case decodingError(Error)
    case encodingError(Error)
    case serverError(Int)
    case unauthorized
    case networkUnavailable
    case timeout
    case unknown(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .noData:
            return "No data received"
        case .invalidResponse:
            return "Invalid response"
        case .decodingError(let error):
            return "Decoding failed: \(error.localizedDescription)"
        case .encodingError(let error):
            return "Encoding failed: \(error.localizedDescription)"
        case .serverError(let code):
            return "Server error with code: \(code)"
        case .unauthorized:
            return "Unauthorized access"
        case .networkUnavailable:
            return "Network unavailable"
        case .timeout:
            return "Request timeout"
        case .unknown(let error):
            return "Unknown error: \(error.localizedDescription)"
        }
    }

    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL),
             (.noData, .noData),
             (.invalidResponse, .invalidResponse),
             (.unauthorized, .unauthorized),
             (.networkUnavailable, .networkUnavailable),
             (.timeout, .timeout):
            return true
        case (.serverError(let a), .serverError(let b)):
            return a == b
        case (.decodingError, .decodingError),
             (.encodingError, .encodingError),
             (.unknown, .unknown):
            return true
        default:
            return false
        }
    }
}
