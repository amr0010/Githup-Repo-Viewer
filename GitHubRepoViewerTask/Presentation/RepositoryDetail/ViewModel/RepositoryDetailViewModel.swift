//
//  RepositoryDetailViewModel.swift
//  GitHubRepoViewerTask
//
//  Created by Amr Magdy on 30/12/2025.
//

import Foundation
import Combine

@MainActor
final class RepositoryDetailViewModel: ObservableObject {

    @Published var repository: Repository
    @Published var branches: [Branch] = []
    @Published var isLoadingBranches = false
    @Published var isLoadingMoreBranches = false
    @Published var errorMessage: String?

    private let getBranchesUseCase: GetBranchesUseCaseProtocol

    private var currentPage = 1
    private var hasMorePages = true
    private let perPage = APIConstants.Pagination.defaultPageSize

    private var cancellables = Set<AnyCancellable>()

    init(
        repository: Repository,
        getBranchesUseCase: GetBranchesUseCaseProtocol
    ) {
        self.repository = repository
        self.getBranchesUseCase = getBranchesUseCase
    }

    func loadBranches() {
        Task {
            isLoadingBranches = true
            errorMessage = nil
            currentPage = 1
            hasMorePages = true

            do {
                let branchList = try await getBranchesUseCase.execute(
                    owner: repository.owner.login,
                    repo: repository.name,
                    page: currentPage,
                    perPage: perPage
                )
                branches = branchList
                hasMorePages = branchList.count == perPage
            } catch {
                errorMessage = error.localizedDescription
                branches = []
            }

            isLoadingBranches = false
        }
    }

    func loadMoreBranches() {
        guard !isLoadingMoreBranches && hasMorePages else { return }

        Task {
            isLoadingMoreBranches = true

            do {
                currentPage += 1
                let newBranches = try await getBranchesUseCase.execute(
                    owner: repository.owner.login,
                    repo: repository.name,
                    page: currentPage,
                    perPage: perPage
                )
                branches.append(contentsOf: newBranches)
                hasMorePages = newBranches.count == perPage
            } catch {
                errorMessage = error.localizedDescription
                currentPage -= 1
            }

            isLoadingMoreBranches = false
        }
    }

    func refreshBranches() {
        Task {
            errorMessage = nil
            currentPage = 1
            hasMorePages = true

            do {
                let branchList = try await getBranchesUseCase.execute(
                    owner: repository.owner.login,
                    repo: repository.name,
                    page: currentPage,
                    perPage: perPage
                )
                branches = branchList
                hasMorePages = branchList.count == perPage
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }

    func clearError() {
        errorMessage = nil
    }
}