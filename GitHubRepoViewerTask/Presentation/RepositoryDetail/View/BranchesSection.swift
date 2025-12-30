//
//  BranchesSection.swift
//  GitHubRepoViewerTask
//
//  Created by Amr Magdy on 30/12/2025.
//

import SwiftUI

struct BranchesSection: View {

    enum State { case loading, empty, loaded, loadingMore }

    let branches: [Branch]
    let state: State
    let onLoadMore: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            header

            switch state {
            case .loading:
                loadingView
            case .empty:
                emptyView
            case .loaded, .loadingMore:
                listView
            }
        }
    }

    private var header: some View {
        HStack {
            Image(systemName: "arrow.branch").foregroundColor(.blue)
            Text("Branches").font(.headline).fontWeight(.semibold)

            Spacer()

            if state != .loading {
                Text("\(branches.count)")
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(.blue.opacity(0.1))
                    .foregroundColor(.blue)
                    .clipShape(Capsule())
            }
        }
        .padding(.horizontal)
        .padding(.top, 16)
        .padding(.bottom, 12)
    }

    private var loadingView: some View {
        HStack(spacing: 8) {
            Spacer()
            ProgressView().scaleEffect(0.85)
            Text("Loading branches...")
                .font(.caption)
                .foregroundColor(.secondary)
            Spacer()
        }
        .padding()
    }

    private var emptyView: some View {
        VStack(spacing: 8) {
            Image(systemName: "arrow.branch")
                .font(.largeTitle)
                .foregroundColor(.secondary)
            Text("No branches found")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 32)
    }

    private var listView: some View {
        LazyVStack(spacing: 0) {
            ForEach(branches) { branch in
                BranchRowView(branch: branch)
                    .onAppear {
                        if branch.id == branches.last?.id {
                            onLoadMore()
                        }
                    }

                if branch.id != branches.last?.id {
                    Divider().padding(.leading, 56)
                }
            }

            if state == .loadingMore {
                HStack(spacing: 8) {
                    Spacer()
                    ProgressView().scaleEffect(0.7)
                    Text("Loading more...")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                    Spacer()
                }
                .padding(.vertical, 12)
            }
        }
    }
}
