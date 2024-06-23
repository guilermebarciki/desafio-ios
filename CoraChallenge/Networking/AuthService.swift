//
//  AuthService.swift
//  CoraChallenge
//
//  Created by Guilerme Barciki on 23/06/24.
//

import Foundation

protocol AuthServiceProtocol {
    func login(cpf: String, password: String) async -> Result<String, NetworkError>
    func refreshToken(oldToken: String) async -> Result<String, NetworkError>
}

final class AuthService: AuthServiceProtocol {
    private let networkService: NetworkServiceProtocol
    private let apiKey: String

    init(networkService: NetworkServiceProtocol, apiKey: String) {
        self.networkService = networkService
        self.apiKey = apiKey
    }

    func login(cpf: String, password: String) async -> Result<String, NetworkError> {
        let body = ["cpf": cpf, "password": password]
        let bodyData = try? JSONSerialization.data(withJSONObject: body)

        let headers = ["apikey": apiKey]

        let result: Result<AuthResponse, NetworkError> = await networkService.request(endpoint: .login, headers: headers, body: bodyData)

        switch result {
        case .success(let authResponse):
            return .success(authResponse.token)
        case .failure(let error):
            return .failure(error)
        }
    }

    func refreshToken(oldToken: String) async -> Result<String, NetworkError> {
        let body = ["token": oldToken]
        let bodyData = try? JSONSerialization.data(withJSONObject: body)

        let headers = ["apikey": apiKey]

        let result: Result<AuthResponse, NetworkError> = await networkService.request(endpoint: .refreshToken, headers: headers, body: bodyData)

        switch result {
        case .success(let authResponse):
            return .success(authResponse.token)
        case .failure(let error):
            return .failure(error)
        }
    }
}

struct AuthResponse: Decodable {
    let token: String
}

