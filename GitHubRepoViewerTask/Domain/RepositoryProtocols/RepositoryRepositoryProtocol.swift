//
//  RepositoryRepositoryProtocol.swift
//  GitHubRepoViewerTask
//
//  Created by Amr Magdy on 30/12/2025.
//

import Foundation

protocol RepositoryRepositoryProtocol {
    func getRepositories(page: Int, perPage: Int) async throws -> [Repository]
    func searchRepositories(query: String, page: Int, perPage: Int) async throws -> [Repository]
    func getBranches(owner: String, repo: String, page: Int, perPage: Int) async throws -> [Branch]
}