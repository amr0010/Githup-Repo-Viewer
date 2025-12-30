//
//  RepositoryRepository.swift
//  GitHubRepoViewerTask
//
//  Created by Amr Magdy on 30/12/2025.
//

import Foundation

final class RepositoryRepository: RepositoryRepositoryProtocol {

    private let gitHubAPIClient: GitHubAPIClientProtocol
    private let authRepository: AuthRepositoryProtocol

    init(
        gitHubAPIClient: GitHubAPIClientProtocol,
        authRepository: AuthRepositoryProtocol
    ) {
        self.gitHubAPIClient = gitHubAPIClient
        self.authRepository = authRepository
    }

    func getRepositories(page: Int, perPage: Int) async throws -> [Repository] {
        guard let accessToken = authRepository.getStoredAccessToken() else {
            throw NetworkError.unauthorized
        }

        return try await gitHubAPIClient.getRepositories(
            accessToken: accessToken,
            page: page,
            perPage: perPage
        )
    }

    func searchRepositories(query: String, page: Int, perPage: Int) async throws -> [Repository] {
        guard let accessToken = authRepository.getStoredAccessToken() else {
            throw NetworkError.unauthorized
        }

        let allRepositories = try await gitHubAPIClient.getRepositories(
            accessToken: accessToken,
            page: page,
            perPage: perPage
        )

        if query.isEmpty {
            return allRepositories
        }

        return allRepositories.filter { repository in
            repository.name.localizedCaseInsensitiveContains(query)
        }
    }

    func getBranches(owner: String, repo: String, page: Int, perPage: Int) async throws -> [Branch] {
        guard let accessToken = authRepository.getStoredAccessToken() else {
            throw NetworkError.unauthorized
        }

        return try await gitHubAPIClient.getBranches(
            accessToken: accessToken,
            owner: owner,
            repo: repo,
            page: page,
            perPage: perPage
        )
    }
}