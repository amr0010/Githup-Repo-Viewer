//
//  UserMock.swift
//  GitHubRepoViewerTask
//
//  Created by Amr Magdy on 30/12/2025.
//

import Foundation
@testable import GitHubRepoViewerTask

extension User {

    static func mockUser(
        id: Int = 1,
        login: String = "amrmagdy",
        name: String? = "Amr Magdy",
        email: String? = "amr@example.com",
        avatarUrl: String = "https://google.com/",
        htmlUrl: String = "https://github.com",
        publicRepos: Int = 10,
        followers: Int = 100,
        following: Int = 50,
        createdAt: Date = Date(timeIntervalSince1970: 1_600_000_000)
    ) -> User {
        User(
            id: id,
            login: login,
            name: name,
            email: email,
            avatarUrl: avatarUrl,
            htmlUrl: htmlUrl,
            publicRepos: publicRepos,
            followers: followers,
            following: following,
            createdAt: createdAt
        )
    }
}
