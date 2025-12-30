//
//  GitHubConfig.swift
//  GitHubRepoViewerTask
//
//  Created by Amr Magdy on 30/12/2025.
//

import Foundation

struct GitHubConfig {

    private enum ConfigError: Error {
        case missingConfigFile
        case missingClientId
        case missingClientSecret
    }

    static let shared = GitHubConfig()

    let clientId: String
    let clientSecret: String
    let callbackURLScheme: String
    let scopes: [String]

    private init() {
        guard let path = Bundle.main.path(forResource: "GitHubConfig", ofType: "plist"),
              let config = NSDictionary(contentsOfFile: path) else {
            fatalError("GitHubConfig.plist file not found. Please create it with your GitHub OAuth credentials.")
        }

        guard let clientId = config["CLIENT_ID"] as? String, !clientId.isEmpty else {
            fatalError("CLIENT_ID not found in GitHubConfig.plist")
        }

        guard let clientSecret = config["CLIENT_SECRET"] as? String, !clientSecret.isEmpty else {
            fatalError("CLIENT_SECRET not found in GitHubConfig.plist")
        }

        self.clientId = clientId
        self.clientSecret = clientSecret
        self.callbackURLScheme = config["CALLBACK_URL_SCHEME"] as? String ?? "githubrepoviewer"
        self.scopes = config["SCOPES"] as? [String] ?? ["repo", "user"]
    }

    var authURL: URL? {
        var components = URLComponents(string: "https://github.com/login/oauth/authorize")
        components?.queryItems = [
            URLQueryItem(name: "client_id", value: clientId),
            URLQueryItem(name: "scope", value: scopes.joined(separator: " ")),
            URLQueryItem(name: "redirect_uri", value: "\(callbackURLScheme)://oauth-callback")
        ]
        return components?.url
    }

    var tokenExchangeURL: URL? {
        URL(string: "https://github.com/login/oauth/access_token")
    }
}
