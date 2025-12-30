//
//  RepositoryEmptyState.swift
//  GitHubRepoViewerTask
//
//  Created by Amr Magdy on 30/12/2025.
//

import SwiftUI

struct RepositoryEmptyState: View {

    let searchQuery: String

    var body: some View {
        VStack(spacing: 14) {
            Image(systemName: searchQuery.isEmpty ? "folder" : "magnifyingglass")
                .font(.system(size: 56))
                .foregroundColor(.secondary)

            Text(title)
                .font(.title3)
                .multilineTextAlignment(.center)

            Text(subtitle)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private var title: String {
        searchQuery.isEmpty ? "No repositories found" : "No results for '\(searchQuery)'"
    }

    private var subtitle: String {
        searchQuery.isEmpty ? "You don't have any repositories yet." : "Try adjusting your search."
    }
}
