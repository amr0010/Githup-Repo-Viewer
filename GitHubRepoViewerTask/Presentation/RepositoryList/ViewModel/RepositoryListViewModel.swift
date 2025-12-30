//
//  RepositoryListViewModel.swift
//  GitHubRepoViewerTask
//
//  Created by Amr Magdy on 30/12/2025.
//

import Foundation
import Combine

@MainActor
final class RepositoryListViewModel: ObservableObject {

    @Published var repositories: [Repository] = []
    @Published var filteredRepositories: [Repository] = []
    @Published var searchQuery = ""
    @Published var isLoading = false
    @Published var isRefreshing = false
    @Published var isLoadingMore = false
    @Published var errorMessage: String?

    private let getRepositoriesUseCase: GetRepositoriesUseCaseProtocol
    private let searchRepositoriesUseCase: SearchRepositoriesUseCaseProtocol

    private var currentPage = 1
    private var hasMorePages = true
    private let perPage = APIConstants.Pagination.defaultPageSize

    private var cancellables = Set<AnyCancellable>()

    init(
        getRepositoriesUseCase: GetRepositoriesUseCaseProtocol,
        searchRepositoriesUseCase: SearchRepositoriesUseCaseProtocol
    ) {
        self.getRepositoriesUseCase = getRepositoriesUseCase
        self.searchRepositoriesUseCase = searchRepositoriesUseCase
        setupSearchDebounce()
    }

    private func setupSearchDebounce() {
        $searchQuery
            .debounce(for: .seconds(APIConstants.Search.debounceDelay), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] query in
                self?.performSearch(query: query)
            }
            .store(in: &cancellables)
    }

    func loadRepositories() {
        Task {
            isLoading = true
            errorMessage = nil
            currentPage = 1
            hasMorePages = true

            do {
                let repos = try await getRepositoriesUseCase.execute(page: currentPage, perPage: perPage)
                repositories = repos
                filteredRepositories = repos
                hasMorePages = repos.count == perPage
            } catch {
                errorMessage = error.localizedDescription
                repositories = []
                filteredRepositories = []
            }

            isLoading = false
        }
    }

    func refreshRepositories() {
        Task {
            isRefreshing = true
            errorMessage = nil
            currentPage = 1
            hasMorePages = true

            do {
                let repos = try await getRepositoriesUseCase.execute(page: currentPage, perPage: perPage)
                repositories = repos
                performSearch(query: searchQuery)
                hasMorePages = repos.count == perPage
            } catch {
                errorMessage = error.localizedDescription
            }

            isRefreshing = false
        }
    }

    func loadMoreRepositories() {
        guard !isLoadingMore && hasMorePages else { return }

        Task {
            isLoadingMore = true

            do {
                currentPage += 1
                let newRepos = try await getRepositoriesUseCase.execute(page: currentPage, perPage: perPage)
                repositories.append(contentsOf: newRepos)
                performSearch(query: searchQuery)
                hasMorePages = newRepos.count == perPage
            } catch {
                errorMessage = error.localizedDescription
                currentPage -= 1
            }

            isLoadingMore = false
        }
    }

    private func performSearch(query: String) {
        if query.isEmpty {
            filteredRepositories = repositories
        } else {
            filteredRepositories = repositories.filter { repository in
                repository.name.localizedCaseInsensitiveContains(query) ||
                (repository.description?.localizedCaseInsensitiveContains(query) ?? false)
            }
        }
    }

    func clearError() {
        errorMessage = nil
    }
}