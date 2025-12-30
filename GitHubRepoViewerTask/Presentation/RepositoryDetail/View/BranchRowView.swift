//
//  BranchRowView.swift
//  GitHubRepoViewerTask
//
//  Created by Amr Magdy on 30/12/2025.
//

import SwiftUI

struct BranchRowView: View {

    let branch: Branch

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "arrow.branch")
                .foregroundColor(.blue)
                .frame(width: 20)

            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(branch.name)
                        .font(.body)
                        .fontWeight(.medium)

                    if branch.protected {
                        Image(systemName: "shield.fill")
                            .font(.caption)
                            .foregroundColor(.orange)
                            .accessibilityLabel("Protected branch")
                    }

                    Spacer()
                }

                Text(shortSHA)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .background(.gray.opacity(0.12))
                    .clipShape(Capsule())
            }

            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 12)
    }

    private var shortSHA: String {
        String(branch.commit.sha.prefix(7))
    }
}
