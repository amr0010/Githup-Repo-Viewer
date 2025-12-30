//
//  RepositoryDetailView.swift
//  GitHubRepoViewerTask
//
//  Created by Amr Magdy on 30/12/2025.
//

import SwiftUI

struct RepositoryDetailView: View {

    let repository: Repository
    @StateObject private var viewModel: RepositoryDetailViewModel

    init(repository: Repository) {
        self.repository = repository
        _viewModel = StateObject(
            wrappedValue: DIContainer.shared.makeRepositoryDetailViewModel(repository: repository)
        )
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                RepositoryDetailHeader(repository: repository)

                Divider().padding(.horizontal)

                BranchesSection(
                    branches: viewModel.branches,
                    state: branchesState,
                    onLoadMore: viewModel.loadMoreBranches
                )
            }
        }
        .navigationTitle(repository.name)
        .navigationBarTitleDisplayMode(.large)
        .task { viewModel.loadBranches() }
        .refreshable { viewModel.refreshBranches() }
        .alert("Error", isPresented: isShowingError) {
            Button("OK") { viewModel.clearError() }
        } message: {
            Text(viewModel.errorMessage ?? "")
        }
    }

    private var branchesState: BranchesSection.State {
        if viewModel.isLoadingBranches { return .loading }
        if viewModel.branches.isEmpty { return .empty }
        if viewModel.isLoadingMoreBranches { return .loadingMore }
        return .loaded
    }

    private var isShowingError: Binding<Bool> {
        Binding(
            get: { viewModel.errorMessage != nil },
            set: { if !$0 { viewModel.clearError() } }
        )
    }
}
