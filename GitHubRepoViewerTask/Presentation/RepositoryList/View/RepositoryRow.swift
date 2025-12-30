//
//  RepositoryRow.swift
//  GitHubRepoViewerTask
//
//  Created by Amr Magdy on 30/12/2025.
//


import SwiftUI

struct RepositoryRow: View {

    let repository: Repository

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            header
            footer
        }
        .padding(.vertical, 4)
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 8) {
                Text(repository.name)
                    .font(.headline)

                Image(systemName: repository.isPrivate ? "lock.fill" : "globe")
                    .font(.caption)
                    .foregroundColor(repository.isPrivate ? .orange : .blue)

                Spacer()
            }

            if let description = repository.description, !description.isEmpty {
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
        }
    }

    private var footer: some View {
        HStack(spacing: 14) {
            if let language = repository.language {
                HStack(spacing: 6) {
                    Circle()
                        .fill(.blue)
                        .frame(width: 8, height: 8)
                    Text(language)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            if repository.stargazersCount > 0 {
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .font(.caption)
                        .foregroundColor(.yellow)
                    Text("\(repository.stargazersCount)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            if repository.forksCount > 0 {
                HStack(spacing: 4) {
                    Image(systemName: "tuningfork")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("\(repository.forksCount)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            Spacer()

            Text("Updated \(repository.updatedAt.timeAgoDisplay)")
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}
