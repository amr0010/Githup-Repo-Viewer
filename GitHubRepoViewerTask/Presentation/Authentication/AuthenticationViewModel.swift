//
//  AuthenticationViewModel.swift
//  GitHubRepoViewerTask
//
//  Created by Amr Magdy on 30/12/2025.
//

import Foundation
import Combine

@MainActor
final class AuthenticationViewModel: ObservableObject {

    @Published var isLoading = false
    @Published var errorMessage: String?

    private let loginUseCase: LoginUseCaseProtocol
    private let logoutUseCase: LogoutUseCaseProtocol
    private let getCurrentUserUseCase: GetCurrentUserUseCaseProtocol

    var onLoginSuccess: ((User) -> Void)?
    var onLogoutSuccess: (() -> Void)?

    private var cancellables = Set<AnyCancellable>()

    init(
        loginUseCase: LoginUseCaseProtocol,
        logoutUseCase: LogoutUseCaseProtocol,
        getCurrentUserUseCase: GetCurrentUserUseCaseProtocol
    ) {
        self.loginUseCase = loginUseCase
        self.logoutUseCase = logoutUseCase
        self.getCurrentUserUseCase = getCurrentUserUseCase
    }

    func login() {
        Task { @MainActor in
            isLoading = true
            errorMessage = nil

            do {
                let user = try await loginUseCase.execute()
                onLoginSuccess?(user)
            } catch {
                errorMessage = error.localizedDescription
            }

            isLoading = false
        }
    }

    func logout() {
        Task { @MainActor in
            isLoading = true
            errorMessage = nil

            do {
                try await logoutUseCase.execute()
                onLogoutSuccess?()
            } catch {
                errorMessage = error.localizedDescription
            }

            isLoading = false
        }
    }


    func clearError() {
        errorMessage = nil
    }
}


