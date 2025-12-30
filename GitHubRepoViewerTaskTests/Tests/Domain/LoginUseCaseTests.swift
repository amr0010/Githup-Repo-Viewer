//
//  LoginUseCaseTests.swift
//  GitHubRepoViewerTask
//
//  Created by Amr Magdy on 30/12/2025.
//

import XCTest
@testable import GitHubRepoViewerTask

final class LoginUseCaseTests: XCTestCase {

    func test_execute_returnsUser_whenLoginAndFetchSucceed() async throws {
        let auth = AuthRepositoryMock()
        let users = UserRepositoryMock()
        let sut = LoginUseCase(authRepository: auth, userRepository: users)

        auth.loginResult = "token"
        users.currentUserResult = .success(User.mockUser())

        let user = try await sut.execute()

        XCTAssertEqual(auth.loginCallCount, 1)
        XCTAssertEqual(users.getCurrentUserCallCount, 1)
        XCTAssertEqual(user.id, User.mockUser().id)
    }

    func test_execute_throws_whenAuthLoginFails() async {
        let auth = AuthRepositoryMock()
        let users = UserRepositoryMock()
        let sut = LoginUseCase(authRepository: auth, userRepository: users)

        auth.loginError = TestError.any

        do {
            _ = try await sut.execute()
            XCTFail("Expected throw")
        } catch {
            XCTAssertEqual(auth.loginCallCount, 1)
            XCTAssertEqual(users.getCurrentUserCallCount, 0)
        }
    }
}

