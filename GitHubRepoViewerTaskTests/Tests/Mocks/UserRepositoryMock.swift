//
//  UserRepositoryMock.swift
//  GitHubRepoViewerTask
//
//  Created by Amr Magdy on 30/12/2025.
//


import Foundation

@testable import GitHubRepoViewerTask

final class UserRepositoryMock: UserRepositoryProtocol {
    var currentUserResult: Result<User?, Error> = .success(nil)

    func getCurrentUser() async throws -> User? {
        switch currentUserResult {
        case .success(let user): return user
        case .failure(let error): throw error
        }
    }
}
