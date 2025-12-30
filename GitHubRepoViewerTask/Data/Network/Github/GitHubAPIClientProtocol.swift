//
//  GitHubAPIClientProtocol.swift
//  GitHubRepoViewerTask
//
//  Created by Amr Magdy on 30/12/2025.
//


import Foundation

protocol GitHubAPIClientProtocol {
    func getCurrentUser(accessToken: String) async throws -> User
    func getRepositories(accessToken: String, page: Int, perPage: Int) async throws -> [Repository]
    func getBranches(accessToken: String, owner: String, repo: String, page: Int, perPage: Int) async throws -> [Branch]
}

