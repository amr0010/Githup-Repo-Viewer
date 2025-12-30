//
//  AppState.swift
//  GitHubRepoViewerTask
//
//  Created by Amr Magdy on 30/12/2025.
//

import Foundation

@MainActor
final class AppState: ObservableObject {

    @Published var isAuthenticated = false
    @Published var currentUser: User?

    private let getCurrentUserUseCase: GetCurrentUserUseCaseProtocol

    init(getCurrentUserUseCase: GetCurrentUserUseCaseProtocol) {
        self.getCurrentUserUseCase = getCurrentUserUseCase
        checkAuthStatus()
    }

    func checkAuthStatus() {
        Task {
            do {
                currentUser = try await getCurrentUserUseCase.execute()
                isAuthenticated = (currentUser != nil)
            } catch {
                currentUser = nil
                isAuthenticated = false
            }
        }
    }

    func didLogin(user: User) {
        currentUser = user
        isAuthenticated = true
    }

    func didLogout() {
        currentUser = nil
        isAuthenticated = false
    }
}
