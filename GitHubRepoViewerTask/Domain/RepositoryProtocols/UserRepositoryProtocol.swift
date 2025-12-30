//
//  UserRepositoryProtocol.swift
//  GitHubRepoViewerTask
//
//  Created by Amr Magdy on 30/12/2025.
//
import Foundation

protocol UserRepositoryProtocol {
    func getCurrentUser() async throws -> User?
}
