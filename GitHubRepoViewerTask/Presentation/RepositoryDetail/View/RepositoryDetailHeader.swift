//
//  RepositoryDetailHeader.swift
//  GitHubRepoViewerTask
//
//  Created by Amr Magdy on 30/12/2025.
//


import SwiftUI

struct RepositoryDetailHeader: View {

    let repository: Repository

    var body: some View {
        VStack(spacing: 16) {
            topRow
            descriptionRow
            RepositoryDetailStats(repository: repository)
            datesRow
        }
        .padding()
    }

    private var topRow: some View {
        HStack(spacing: 12) {
            Avatar(urlString: repository.owner.avatarUrl)

            VStack(alignment: .leading, spacing: 4) {
                Text(repository.owner.login)
                    .font(.headline)

                Text(repository.name)
                    .font(.title2)
                    .fontWeight(.bold)
            }

            Spacer()

            VisibilityBadge(isPrivate: repository.isPrivate)
        }
    }

    @ViewBuilder
    private var descriptionRow: some View {
        if let description = repository.description, !description.isEmpty {
            Text(description)
                .font(.body)
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    private var datesRow: some View {
        HStack {
            Text("Updated \(repository.updatedAt.timeAgoDisplay)")
            Spacer()
            Text("Created \(repository.createdAt.timeAgoDisplay)")
        }
        .font(.caption)
        .foregroundColor(.secondary)
    }
}

private struct Avatar: View {
    let urlString: String

    var body: some View {
        AsyncImage(url: URL(string: urlString)) { image in
            image.resizable().scaledToFill()
        } placeholder: {
            Circle().fill(.gray.opacity(0.2))
        }
        .frame(width: 60, height: 60)
        .clipShape(Circle())
    }
}

private struct VisibilityBadge: View {
    let isPrivate: Bool

    var body: some View {
        Image(systemName: isPrivate ? "lock.fill" : "globe")
            .font(.title2)
            .foregroundColor(isPrivate ? .orange : .blue)
            .accessibilityLabel(isPrivate ? "Private repository" : "Public repository")
    }
}
