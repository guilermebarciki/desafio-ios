//
//  CoraSession.swift
//  CoraChallenge
//
//  Created by Guilerme Barciki on 23/06/24.
//

import Foundation

final class CoraSession {
    
    
    // MARK: - Private Properties
    
    static private(set) var current = CoraSession()
    
    private let keychainManager = ""
    
    // MARK: - Init
    
    private init() {}
    
    
    // MARK: - Public Properties
    
    var loginType: LoginType {
        return token == nil ? .logedOut : .logedIn
    }
    
    private(set) var token: String?
    //    {
    //        return nil //keychainManager.getStoredAttribute()
    //    }
    
}


// MARK: - Keychain methods

extension CoraSession {
    
    func setToken(with token: String) {
        if let _ = self.token {
            updateStoredTokenInKeychain(with: token)
        } else {
            storeTokenInKeychain(with: token)
        }
    }
    
    private func storeTokenInKeychain(with token: String) {
        //        keychainManager.storeAttribute(with: token, success: {
        //            debugPrint("token stored successfully - \(token)")
        //        }, fail: {
        //            debugPrint("fail to storage the token")
        //        })
        self.token = token
    }
    
    private func updateStoredTokenInKeychain(with token: String) {
        //        keychainManager.setStoredAttribute(with: token, success: {
        //            debugPrint("token updated successfully - \(token)")
        //        }, fail: {
        //            debugPrint("fail to update the token")
        //        })
        self.token = token
    }
    
}


public enum LoginType {
    
    case logedIn
    case logedOut
    
}



protocol TokenStorageProtocol {
    func getToken() async -> String?
    func saveToken(_ token: String)
    func setRefreshing(_ refreshing: Bool)
}

final class TokenStorage: TokenStorageProtocol {
    static let shared = TokenStorage()
    
    private var token: String?
    private var isRefreshing = false
    private let queue = DispatchQueue(label: "com.tokenStorage.queue")
    
    private init() { }
    
    func getToken() async -> String? {
        await withCheckedContinuation { continuation in
            queue.async {
                while self.isRefreshing {
                    usleep(50_000)
                }
                continuation.resume(returning: self.token)
            }
        }
    }
    
    func saveToken(_ token: String) {
        queue.async {
            self.token = token
            print("token: \(token)")
        }
    }
    
    func setRefreshing(_ refreshing: Bool) {
        queue.async {
            self.isRefreshing = refreshing
            print("refreshing: \(refreshing)")
        }
    }
}
