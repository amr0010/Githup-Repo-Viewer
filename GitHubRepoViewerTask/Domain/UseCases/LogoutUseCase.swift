//
//  LogoutUseCase.swift
//  GitHubRepoViewerTask
//
//  Created by Amr Magdy on 30/12/2025.
//

import Foundation

protocol LogoutUseCaseProtocol {
    func execute() async throws
}

final class LogoutUseCase: LogoutUseCaseProtocol {

    private let authRepository: AuthRepositoryProtocol

    init(authRepository: AuthRepositoryProtocol) {
        self.authRepository = authRepository
    }

    func execute() async throws {
        try await authRepository.logout()
    }
}