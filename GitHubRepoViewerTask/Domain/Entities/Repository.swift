//
//  Repository.swift
//  GitHubRepoViewer
//
//  Created by Amr Magdy on 30/12/2025.
//

import Foundation

struct Repository: Identifiable, Codable, Equatable, Hashable {
    let id: Int
    let name: String
    let fullName: String
    let description: String?
    let isPrivate: Bool
    let htmlUrl: String
    let stargazersCount: Int
    let forksCount: Int
    let language: String?
    let updatedAt: Date
    let createdAt: Date
    let owner: RepositoryOwner
    let defaultBranch: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case fullName = "full_name"
        case description
        case isPrivate = "private"
        case htmlUrl = "html_url"
        case stargazersCount = "stargazers_count"
        case forksCount = "forks_count"
        case language
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case owner
        case defaultBranch = "default_branch"
    }
}

struct RepositoryOwner: Codable, Equatable, Hashable {
    let login: String
    let avatarUrl: String
    let htmlUrl: String

    enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl = "avatar_url"
        case htmlUrl = "html_url"
    }
}
