//
//  GetRepositoriesUseCase.swift
//  GitHubRepoViewerTask
//
//  Created by Amr Magdy on 30/12/2025.
//

import Foundation

protocol GetRepositoriesUseCaseProtocol {
    func execute(page: Int, perPage: Int) async throws -> [Repository]
}

final class GetRepositoriesUseCase: GetRepositoriesUseCaseProtocol {

    private let repositoryRepository: RepositoryRepositoryProtocol

    init(repositoryRepository: RepositoryRepositoryProtocol) {
        self.repositoryRepository = repositoryRepository
    }

    func execute(page: Int = 1, perPage: Int = APIConstants.Pagination.defaultPageSize) async throws -> [Repository] {
        return try await repositoryRepository.getRepositories(page: page, perPage: perPage)
    }
}