//
//  DIContainer.swift
//  GitHubRepoViewerTask
//
//  Created by Amr Magdy on 30/12/2025.
//

import Foundation

final class DIContainer {

    static let shared = DIContainer()
    private init() {}

    // MARK: - Constants

    private let accessTokenKey = "github_access_token"

    // MARK: - Infrastructure

    lazy var keychainService: KeychainServiceProtocol = KeychainService()

    lazy var apiClient: APIClientProtocol = APIClient()

    // MARK: - OAuth

    lazy var oauthManager: OAuthManaging = OAuthManager()

    lazy var oauthProvider: OAuthProvider = GitHubOAuthProvider()

    // MARK: - API Clients

    lazy var gitHubAPIClient: GitHubAPIClientProtocol = GitHubAPIClient(api: apiClient)

    // MARK: - Repositories

    lazy var authRepository: AuthRepositoryProtocol = AuthRepository(
        oauthManager: oauthManager,
        oauthProvider: oauthProvider,
        keychainService: keychainService,
        accessTokenKey: accessTokenKey
    )

    lazy var userRepository: UserRepositoryProtocol = UserRepository(
        apiClient: gitHubAPIClient,
        authRepository: authRepository,
        keychainService: keychainService,
        accessTokenKey: accessTokenKey
    )

    lazy var repositoryRepository: RepositoryRepositoryProtocol = RepositoryRepository(
        gitHubAPIClient: gitHubAPIClient,
        authRepository: authRepository
    )

    // MARK: - Use Cases

    lazy var loginUseCase: LoginUseCaseProtocol = LoginUseCase(
        authRepository: authRepository,
        userRepository: userRepository
    )

    lazy var logoutUseCase: LogoutUseCaseProtocol = LogoutUseCase(
        authRepository: authRepository
    )

    lazy var getCurrentUserUseCase: GetCurrentUserUseCaseProtocol = GetCurrentUserUseCase(
        userRepository: userRepository
    )

    lazy var getRepositoriesUseCase: GetRepositoriesUseCaseProtocol = GetRepositoriesUseCase(
        repositoryRepository: repositoryRepository
    )

    lazy var searchRepositoriesUseCase: SearchRepositoriesUseCaseProtocol = SearchRepositoriesUseCase(
        repositoryRepository: repositoryRepository
    )

    lazy var getBranchesUseCase: GetBranchesUseCaseProtocol = GetBranchesUseCase(
        repositoryRepository: repositoryRepository
    )

    // MARK: - Presentation Factories

    @MainActor
    func makeAppState() -> AppState {
        AppState(getCurrentUserUseCase: getCurrentUserUseCase)
    }

    @MainActor
    func makeAuthenticationViewModel() -> AuthenticationViewModel {
        AuthenticationViewModel(
            loginUseCase: loginUseCase,
            logoutUseCase: logoutUseCase,
            getCurrentUserUseCase: getCurrentUserUseCase
        )
    }

    @MainActor
    func makeRepositoryListViewModel() -> RepositoryListViewModel {
        RepositoryListViewModel(
            getRepositoriesUseCase: getRepositoriesUseCase,
            searchRepositoriesUseCase: searchRepositoriesUseCase
        )
    }

    @MainActor
    func makeRepositoryDetailViewModel(repository: Repository) -> RepositoryDetailViewModel {
        RepositoryDetailViewModel(
            repository: repository,
            getBranchesUseCase: getBranchesUseCase
        )
    }
}
