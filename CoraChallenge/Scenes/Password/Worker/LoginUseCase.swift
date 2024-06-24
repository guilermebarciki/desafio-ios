//
//  PasswordWorker.swift
//  CoraChallenge
//
//  Created by Guilerme Barciki on 23/06/24.
//

import Foundation

protocol LoginWorkerProtocol {
    func login(cpf: String, password: String) async -> Result<Void, NetworkError>
}

final class LoginWorker: LoginWorkerProtocol {
    private let authService: AuthServiceProtocol
    private var tokenStorage: TokenStorageProtocol

    init(authService: AuthServiceProtocol = AuthService(), tokenStorage: TokenStorageProtocol = TokenStorage.shared) {
        self.authService = authService
        self.tokenStorage = tokenStorage
    }

    func login(cpf: String, password: String) async -> Result<Void, NetworkError> {
        let result = await authService.login(cpf: cpf, password: password)
        switch result {
        case .success(let token):
            tokenStorage.saveToken(token)
            return .success(())
        case .failure(let error):
            return .failure(error)
        }
    }
}
