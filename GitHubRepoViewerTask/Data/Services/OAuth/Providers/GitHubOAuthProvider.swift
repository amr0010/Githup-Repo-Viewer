//
//  GitHubOAuthProvider.swift
//  GitHubRepoViewerTask
//
//  Created by Amr Magdy on 30/12/2025.
//


import Foundation

struct GitHubOAuthProvider: OAuthProvider {

    let name: String = "GitHub"
    private let config: GitHubConfig

    init(config: GitHubConfig = .shared) {
        self.config = config
    }

    var clientId: String { config.clientId }
    var clientSecret: String { config.clientSecret }
    var callbackURLScheme: String { config.callbackURLScheme }

    var authorizationURL: URL {
        guard let url = config.authURL else { fatalError("Invalid GitHub authURL") }
        return url
    }

    var tokenURL: URL {
        guard let url = config.tokenExchangeURL else { fatalError("Invalid GitHub tokenURL") }
        return url
    }

    func tokenExchangeBody(authorizationCode: String) -> Data? {
        let parameters = [
            "client_id=\(clientId)",
            "client_secret=\(clientSecret)",
            "code=\(authorizationCode)",
            "redirect_uri=\(callbackURLScheme)://oauth-callback"
        ].joined(separator: "&")

        return parameters.data(using: .utf8)
    }

    func extractAccessToken(from data: Data, response: URLResponse) throws -> String {
        guard let http = response as? HTTPURLResponse else {
            throw AuthError.tokenExchangeFailed
        }

        guard http.statusCode == 200 else {
            let responseString = String(data: data, encoding: .utf8) ?? ""
            print("GitHub OAuth Error - Status: \(http.statusCode)")
            print("Response: \(responseString)")
            throw AuthError.tokenExchangeFailed
        }

        if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
           let token = json["access_token"] as? String {
            return token
        }

        let responseString = String(data: data, encoding: .utf8) ?? ""
        let components = responseString.components(separatedBy: "&")
        for component in components {
            let keyValue = component.components(separatedBy: "=")
            if keyValue.count == 2, keyValue[0] == "access_token" {
                return keyValue[1]
            }
        }

        throw AuthError.invalidTokenResponse
    }
}
