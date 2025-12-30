//
//  Branch.swift
//  GitHubRepoViewer
//
//  Created by Amr Magdy on 30/12/2025.
//

import Foundation

struct Branch: Identifiable, Codable, Equatable, Hashable {
    let name: String
    let commit: BranchCommit
    let protected: Bool

    var id: String { name }

    enum CodingKeys: String, CodingKey {
        case name
        case commit
        case protected
    }
}

struct BranchCommit: Codable, Equatable, Hashable {
    let sha: String
    let url: String
}