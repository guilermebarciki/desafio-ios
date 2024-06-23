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
        return token == nil ? .guest : .hard
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
