//
//  GitHubAPIClient.swift
//  GitHubRepoViewerTask
//
//  Created by Amr Magdy on 30/12/2025.
//


final class GitHubAPIClient: GitHubAPIClientProtocol {
    private let api: APIClientProtocol

    init(api: APIClientProtocol) {
        self.api = api
    }

    func getCurrentUser(accessToken: String) async throws -> User {
        try await api.request(.user(accessToken: accessToken))
    }

    func getRepositories(accessToken: String, page: Int, perPage: Int) async throws -> [Repository] {
        try await api.request(.repositories(accessToken: accessToken, page: page, perPage: perPage))
    }

    func getBranches(accessToken: String, owner: String, repo: String, page: Int, perPage: Int) async throws -> [Branch] {
        try await api.request(.branches(accessToken: accessToken, owner: owner, repo: repo, page: page, perPage: perPage))
    }
}
