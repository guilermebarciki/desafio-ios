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
    func startTokenRefresh()
    func stopTokenRefresh()
}

final class AuthService: AuthServiceProtocol {
    
    static let shared = AuthService()
    
    private let networkService: NetworkServiceProtocol
    private let apiKey: String
    private let tokenStorage: TokenStorageProtocol
    private var isTimerActive = false
    
    private lazy var refreshTimer: DispatchSourceTimer = {
        let timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
        timer.schedule(deadline: .now() + 60, repeating: 60)
        timer.setEventHandler { [weak self] in
            self?.handleTokenRefresh()
        }
        timer.resume()
        return timer
    }()
    
    private init(networkService: NetworkServiceProtocol = NetworkService(), apiKey: String = Configuration.apiKey, tokenStorage: TokenStorageProtocol = TokenStorage.shared) {
        self.networkService = networkService
        self.apiKey = apiKey
        self.tokenStorage = tokenStorage
        self.refreshTimer.suspend()
    }
    
    func login(cpf: String, password: String) async -> Result<String, NetworkError> {
        let body = ["cpf": cpf, "password": password]
        let bodyData = try? JSONSerialization.data(withJSONObject: body)
        
        let headers = [
            "apikey": apiKey,
            "Content-Type": "application/json"
        ]
        
        let result: Result<AuthResponse, NetworkError> = await networkService.request(endpoint: .login, headers: headers, body: bodyData)
        
        switch result {
        case .success(let authResponse):
            tokenStorage.saveToken(authResponse.token)
            startTokenRefresh()
            return .success(authResponse.token)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func refreshToken(oldToken: String) async -> Result<String, NetworkError> {
        tokenStorage.setRefreshing(true)
        defer { tokenStorage.setRefreshing(false) }
        
        let body = ["token": oldToken]
        let bodyData = try? JSONSerialization.data(withJSONObject: body)
        
        let headers = ["apikey": apiKey,
                       "Content-Type": "application/json"]
        
        let result: Result<AuthResponse, NetworkError> = await networkService.request(endpoint: .refreshToken, headers: headers, body: bodyData)
        
        switch result {
        case .success(let authResponse):
            tokenStorage.saveToken(authResponse.token)
            return .success(authResponse.token)
        case .failure(let error):
            stopTokenRefresh()
            return .failure(error)
        }
    }
    
    func startTokenRefresh() {
        guard !isTimerActive else { return }
        refreshTimer.resume()
        isTimerActive = true
    }
    
    func stopTokenRefresh() {
        guard isTimerActive else { return }
        refreshTimer.suspend()
        isTimerActive = false
    }
    
    private func handleTokenRefresh() {
        Task {
            await self.performTokenRefresh()
        }
    }
    
    private func performTokenRefresh() async {
        guard let oldToken = await tokenStorage.getToken(), !oldToken.isEmpty else { return }
        _ = await refreshToken(oldToken: oldToken)
    }
}

struct AuthResponse: Decodable {
    let token: String
}
