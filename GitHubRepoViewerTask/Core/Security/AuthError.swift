//
//  AuthError.swift
//  GitHubRepoViewerTask
//
//  Created by Amr Magdy on 30/12/2025.
//

import Foundation

enum AuthError: Error, LocalizedError, Equatable {
    case invalidAuthURL
    case invalidCallback
    case authCancelled
    case tokenExchangeFailed
    case invalidTokenResponse
    case networkError(Error)
    case keychainError(Error)

    var errorDescription: String? {
        switch self {
        case .invalidAuthURL:
            return "Invalid authentication URL"
        case .invalidCallback:
            return "Invalid callback URL"
        case .authCancelled:
            return "Authentication was cancelled"
        case .tokenExchangeFailed:
            return "Failed to exchange authorization code for access token"
        case .invalidTokenResponse:
            return "Invalid token response from GitHub"
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        case .keychainError(let error):
            return "Keychain error: \(error.localizedDescription)"
        }
    }

    static func == (lhs: AuthError, rhs: AuthError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidAuthURL, .invalidAuthURL),
             (.invalidCallback, .invalidCallback),
             (.authCancelled, .authCancelled),
             (.tokenExchangeFailed, .tokenExchangeFailed),
             (.invalidTokenResponse, .invalidTokenResponse):
            return true
        case (.networkError, .networkError),
             (.keychainError, .keychainError):
            return true
        default:
            return false
        }
    }
}