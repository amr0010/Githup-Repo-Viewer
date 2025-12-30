//
//  GetCurrentUserUseCase.swift
//  GitHubRepoViewerTask
//
//  Created by Amr Magdy on 30/12/2025.
//

import Foundation

protocol GetCurrentUserUseCaseProtocol {
    func execute() async throws -> User?
}

final class GetCurrentUserUseCase: GetCurrentUserUseCaseProtocol {

    private let userRepository: UserRepositoryProtocol

    init(userRepository: UserRepositoryProtocol) {
        self.userRepository = userRepository
    }

    func execute() async throws -> User? {
        try await userRepository.getCurrentUser()
    }
}
