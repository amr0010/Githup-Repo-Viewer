//
//  RepositoryDetailStats.swift
//  GitHubRepoViewerTask
//
//  Created by Amr Magdy on 30/12/2025.
//

import SwiftUI

struct RepositoryDetailStats: View {

    let repository: Repository

    var body: some View {
        HStack(spacing: 24) {
            StatView(icon: "star.fill", tint: .yellow, value: repository.stargazersCount, label: "Stars")
            StatView(icon: "tuningfork", tint: .blue, value: repository.forksCount, label: "Forks")

            if let language = repository.language {
                LanguageStat(language: language)
            }

            Spacer()
        }
    }
}

private struct StatView: View {
    let icon: String
    let tint: Color
    let value: Int
    let label: String

    var body: some View {
        VStack(spacing: 4) {
            HStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.caption)
                    .foregroundColor(tint)
                Text("\(value)")
                    .font(.caption)
                    .fontWeight(.medium)
            }
            Text(label)
                .font(.caption2)
                .foregroundColor(.secondary)
        }
    }
}

private struct LanguageStat: View {
    let language: String

    var body: some View {
        VStack(spacing: 4) {
            HStack(spacing: 6) {
                Circle()
                    .fill(.green)
                    .frame(width: 10, height: 10)

                Text(language)
                    .font(.caption)
                    .fontWeight(.medium)
            }
            Text("Language")
                .font(.caption2)
                .foregroundColor(.secondary)
        }
    }
}
