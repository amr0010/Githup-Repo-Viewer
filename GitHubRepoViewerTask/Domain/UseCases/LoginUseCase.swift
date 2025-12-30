//
//  LoginUseCase.swift
//  GitHubRepoViewerTask
//
//  Created by Amr Magdy on 30/12/2025.
//

import Foundation

protocol LoginUseCaseProtocol {
    func execute() async throws -> User
}

final class LoginUseCase: LoginUseCaseProtocol {

    private let authRepository: AuthRepositoryProtocol
    private let userRepository: UserRepositoryProtocol

    init(authRepository: AuthRepositoryProtocol, userRepository: UserRepositoryProtocol) {
           self.authRepository = authRepository
           self.userRepository = userRepository
       }

    func execute() async throws -> User {
          _ = try await authRepository.login()
          guard let user = try await userRepository.getCurrentUser() else {
              throw AuthError.tokenExchangeFailed
          }
          return user
      }
}
