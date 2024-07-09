//
//  MockAuthService.swift
//  CoraChallengeTests
//
//  Created by Guilerme Barciki on 09/07/24.
//

import Foundation
@testable import CoraChallenge

class MockAuthService: AuthServiceProtocol {
    var loginResult: Result<String, NetworkError>?
    var refreshTokenResult: Result<String, NetworkError>?

    func login(cpf: String, password: String) async -> Result<String, NetworkError> {
        return loginResult ?? .failure(.unauthorized)
    }

    func refreshToken(oldToken: String) async -> Result<String, NetworkError> {
        return refreshTokenResult ?? .failure(.unauthorized)
    }

    func startTokenRefresh() {
        // Mock implementation
    }

    func stopTokenRefresh() {
        // Mock implementation
    }
}
