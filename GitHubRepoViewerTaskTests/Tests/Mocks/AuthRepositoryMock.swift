//
//  AuthRepositoryMock.swift
//  GitHubRepoViewerTask
//
//  Created by Amr Magdy on 30/12/2025.
//

import Foundation
@testable import GitHubRepoViewerTask

final class AuthRepositoryMock: AuthRepositoryProtocol {
    var loginCallCount = 0
    var loginResult: String?
    var loginError: Error?

    func login() async throws -> String {
        loginCallCount += 1
        if let loginError { throw loginError }
        return loginResult ?? ""
    }

    func logout() async throws {}
    func getStoredAccessToken() -> String? { nil }
    func isLoggedIn() -> Bool { false }
}
