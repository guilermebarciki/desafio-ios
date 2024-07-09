//
//  MockLoginWorker.swift
//  CoraChallengeTests
//
//  Created by Guilerme Barciki on 07/07/24.
//

import Foundation
@testable import CoraChallenge

final class MockLoginWorker: LoginWorkerProtocol {
    var loginResult: Result<Void, NetworkError>?
    var cleanTokenCalled = false
    
    func login(cpf: String, password: String) async -> Result<Void, NetworkError> {
        return loginResult ?? .failure(.unauthorized)
    }
    
    func cleanToken() {
        cleanTokenCalled = true
    }
}
