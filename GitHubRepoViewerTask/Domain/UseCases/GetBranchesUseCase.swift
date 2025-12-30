//
//  GetBranchesUseCase.swift
//  GitHubRepoViewerTask
//
//  Created by Amr Magdy on 30/12/2025.
//

import Foundation

protocol GetBranchesUseCaseProtocol {
    func execute(owner: String, repo: String, page: Int, perPage: Int) async throws -> [Branch]
}

final class GetBranchesUseCase: GetBranchesUseCaseProtocol {

    private let repositoryRepository: RepositoryRepositoryProtocol

    init(repositoryRepository: RepositoryRepositoryProtocol) {
        self.repositoryRepository = repositoryRepository
    }

    func execute(
        owner: String,
        repo: String,
        page: Int = 1,
        perPage: Int = APIConstants.Pagination.defaultPageSize
    ) async throws -> [Branch] {
        return try await repositoryRepository.getBranches(
            owner: owner,
            repo: repo,
            page: page,
            perPage: perPage
        )
    }
}