//
//  RepositoryList.swift
//  GitHubRepoViewerTask
//
//  Created by Amr Magdy on 30/12/2025.
//

import SwiftUI

struct RepositoryList: View {

    let repositories: [Repository]
    let isLoadingMore: Bool
    let onLoadMore: () -> Void

    var body: some View {
        List {
            ForEach(repositories) { repository in
                NavigationLink(destination: RepositoryDetailView(repository: repository)) {
                    RepositoryRow(repository: repository)
                }
                .onAppear {
                    if repository.id == repositories.last?.id {
                        onLoadMore()
                    }
                }
            }

            if isLoadingMore {
                HStack(spacing: 8) {
                    Spacer()
                    ProgressView().scaleEffect(0.85)
                    Text("Loading more...")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Spacer()
                }
                .padding(.vertical, 8)
            }
        }
        .listStyle(.plain)
    }
}
