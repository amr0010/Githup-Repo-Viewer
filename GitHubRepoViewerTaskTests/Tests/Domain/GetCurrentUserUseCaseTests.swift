//
//  GetCurrentUserUseCaseTests.swift
//  GitHubRepoViewerTask
//
//  Created by Amr Magdy on 30/12/2025.
//

import XCTest
@testable import GitHubRepoViewerTask

final class GetCurrentUserUseCaseTests: XCTestCase {

    func test_execute_returnsUser() async throws {
        let repo = UserRepositoryMock()
        repo.currentUserResult = .success(.mockUser(id: 7))

        let sut = GetCurrentUserUseCase(userRepository: repo)

        let user = try await sut.execute()

        XCTAssertEqual(user?.id, 7)
    }

}
