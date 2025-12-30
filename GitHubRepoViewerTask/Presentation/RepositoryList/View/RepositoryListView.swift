//
//  RepositoryListView.swift
//  GitHubRepoViewerTask
//
//  Created by Amr Magdy on 30/12/2025.
//

import SwiftUI

struct RepositoryListView: View {

    @EnvironmentObject private var appState: AppState
    @StateObject private var viewModel = DIContainer.shared.makeRepositoryListViewModel()

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                RepositorySearchBar(text: $viewModel.searchQuery)

                content
            }
            .navigationTitle("Repositories")
            .navigationBarTitleDisplayMode(.large)
            .toolbar { toolbarContent }
            .refreshable { viewModel.refreshRepositories() }
            .task { viewModel.loadRepositories() }
            .alert("Error", isPresented: isShowingError) {
                Button("OK") { viewModel.clearError() }
            } message: {
                Text(viewModel.errorMessage ?? "")
            }
        }
    }

    @ViewBuilder
    private var content: some View {
        if viewModel.isLoading {
            RepositoryLoadingView()
        } else if viewModel.filteredRepositories.isEmpty {
            RepositoryEmptyState(searchQuery: viewModel.searchQuery)
        } else {
            RepositoryList(
                repositories: viewModel.filteredRepositories,
                isLoadingMore: viewModel.isLoadingMore,
                onLoadMore: viewModel.loadMoreRepositories
            )
        }
    }

    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Menu {
                Button("Sign Out", action: signOut)
            } label: {
                UserAvatar(urlString: appState.currentUser?.avatarUrl)
            }
        }
    }

    private var isShowingError: Binding<Bool> {
        Binding(
            get: { viewModel.errorMessage != nil },
            set: { if !$0 { viewModel.clearError() } }
        )
    }

    private func signOut() {
        Task {
            try? await DIContainer.shared.logoutUseCase.execute()
            appState.didLogout()
        }
    }
}
