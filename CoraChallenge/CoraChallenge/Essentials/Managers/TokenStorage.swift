//
//  TokenStorage.swift
//  CoraChallenge
//
//  Created by Guilerme Barciki on 24/06/24.
//
import Foundation

protocol TokenStorageProtocol {
    func getToken() async -> String?
    func saveToken(_ token: String)
    func setRefreshing(_ refreshing: Bool)
}

final class TokenStorage: TokenStorageProtocol {
    static let shared = TokenStorage()
    
    private let keychainKey = "com.example.app.token"
    private var isRefreshing = false
    private let queue = DispatchQueue(label: "com.tokenStorage.queue")
    
    private init() { }
    
    func getToken() async -> String? {
        await withCheckedContinuation { continuation in
            queue.async {
                while self.isRefreshing {
                    usleep(50_000)
                }
                let tokenData = KeychainManager.load(key: self.keychainKey)
                let token = tokenData.flatMap { String(data: $0, encoding: .utf8) }
                continuation.resume(returning: token)
            }
        }
    }
    
    func saveToken(_ token: String) {
        queue.async {
            let tokenData = token.data(using: .utf8)!
            KeychainManager.save(key: self.keychainKey, data: tokenData)
        }
    }
    
    func setRefreshing(_ refreshing: Bool) {
        queue.async {
            self.isRefreshing = refreshing
        }
    }
}
