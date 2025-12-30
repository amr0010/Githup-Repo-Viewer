//
//  User.swift
//  GitHubRepoViewer
//
//  Created by Amr Magdy on 30/12/2025.
//

import Foundation

struct User: Identifiable, Codable, Equatable, Hashable {
    let id: Int
    let login: String
    let name: String?
    let email: String?
    let avatarUrl: String
    let htmlUrl: String
    let publicRepos: Int
    let followers: Int
    let following: Int
    let createdAt: Date

    enum CodingKeys: String, CodingKey {
        case id
        case login
        case name
        case email
        case avatarUrl = "avatar_url"
        case htmlUrl = "html_url"
        case publicRepos = "public_repos"
        case followers
        case following
        case createdAt = "created_at"
    }
}