//
//  AuthRepository.swift
//  GitHubRepoViewerTask
//
//  Created by Amr Magdy on 30/12/2025.
//

import Foundation

final class AuthRepository: AuthRepositoryProtocol {
 

    private let oauthManager: OAuthManaging
    private let oauthProvider: OAuthProvider
    private let keychainService: KeychainServiceProtocol

    private let accessTokenKey: String

    init(
        oauthManager: OAuthManaging,
        oauthProvider: OAuthProvider,
        keychainService: KeychainServiceProtocol,
        accessTokenKey: String
    ) {
        self.oauthManager = oauthManager
        self.oauthProvider = oauthProvider
        self.keychainService = keychainService
        self.accessTokenKey = accessTokenKey
    }

    func login() async throws -> String {
        let token = try await oauthManager.authenticate(using: oauthProvider)
        do {
            try keychainService.saveString(token, forKey: accessTokenKey)
        } catch {
            throw AuthError.keychainError(error)
        }
        return token
    }

    func logout() async throws {
        do {
            try keychainService.delete(forKey: accessTokenKey)
        } catch {
            throw AuthError.keychainError(error)
        }
    }

    func isLoggedIn() -> Bool {
        keychainService.exists(forKey: accessTokenKey)
    }

    func getStoredAccessToken() -> String? {
        try? keychainService.loadString(forKey: accessTokenKey)
    }
}
