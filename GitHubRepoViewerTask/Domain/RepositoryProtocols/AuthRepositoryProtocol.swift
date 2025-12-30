//
//  AuthRepositoryProtocol.swift
//  GitHubRepoViewerTask
//
//  Created by Amr Magdy on 30/12/2025.
//

import Foundation

protocol AuthRepositoryProtocol {
    func login() async throws -> String
    func logout() async throws
    func isLoggedIn() -> Bool
    func getStoredAccessToken() -> String?
}

