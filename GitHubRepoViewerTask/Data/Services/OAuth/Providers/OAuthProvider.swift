//
//  OAuthProvider.swift
//  GitHubRepoViewerTask
//
//  Created by Amr Magdy on 30/12/2025.
//


import Foundation
import AuthenticationServices

// MARK: - OAuth Provider

protocol OAuthProvider {
    var name: String { get }

    var clientId: String { get }
    var clientSecret: String { get }

    var callbackURLScheme: String { get }

    var authorizationURL: URL { get }

    var tokenURL: URL { get }

    func tokenExchangeBody(authorizationCode: String) -> Data?

    func extractAccessToken(from data: Data, response: URLResponse) throws -> String

    func extractAuthorizationCode(from callbackURL: URL) -> String?
}

extension OAuthProvider {
    func extractAuthorizationCode(from callbackURL: URL) -> String? {
        guard let components = URLComponents(url: callbackURL, resolvingAgainstBaseURL: false) else { return nil }
        return components.queryItems?.first(where: { $0.name == "code" })?.value
    }
}
