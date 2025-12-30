//
//  SearchRepositoriesUseCase.swift
//  GitHubRepoViewerTask
//
//  Created by Amr Magdy on 30/12/2025.
//

import Foundation

protocol SearchRepositoriesUseCaseProtocol {
    func execute(query: String, page: Int, perPage: Int) async throws -> [Repository]
}

final class SearchRepositoriesUseCase: SearchRepositoriesUseCaseProtocol {

    private let repositoryRepository: RepositoryRepositoryProtocol

    init(repositoryRepository: RepositoryRepositoryProtocol) {
        self.repositoryRepository = repositoryRepository
    }

    func execute(
        query: String,
        page: Int = 1,
        perPage: Int = APIConstants.Pagination.defaultPageSize
    ) async throws -> [Repository] {
        return try await repositoryRepository.searchRepositories(
            query: query,
            page: page,
            perPage: perPage
        )
    }
}