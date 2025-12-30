//
//  UserRepository.swift
//  GitHubRepoViewerTask
//
//  Created by Amr Magdy on 30/12/2025.
//

import Foundation

final class UserRepository: UserRepositoryProtocol {

    private let apiClient: GitHubAPIClientProtocol
    private let authRepository: AuthRepositoryProtocol
    private let keychainService: KeychainServiceProtocol
    private let accessTokenKey: String

    init(
        apiClient: GitHubAPIClientProtocol,
        authRepository: AuthRepositoryProtocol,
        keychainService: KeychainServiceProtocol,
        accessTokenKey: String
    ) {
        self.apiClient = apiClient
        self.authRepository = authRepository
        self.keychainService = keychainService
        self.accessTokenKey = accessTokenKey
    }

    func getCurrentUser() async throws -> User? {
        guard let token = authRepository.getStoredAccessToken() else { return nil }

        do {
            return try await apiClient.getCurrentUser(accessToken: token)
        } catch {
            if case NetworkError.unauthorized = error {
                try? keychainService.delete(forKey: accessTokenKey)
                return nil
            }
            throw error
        }
    }
}
