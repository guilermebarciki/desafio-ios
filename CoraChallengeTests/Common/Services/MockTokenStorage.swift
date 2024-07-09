//
//  MockTokenStorage.swift
//  CoraChallengeTests
//
//  Created by Guilerme Barciki on 09/07/24.
//

import Foundation
@testable import CoraChallenge

class MockTokenStorage: TokenStorageProtocol {
    var savedToken: String?
    var isRefreshing: Bool = false

    func getToken() async -> String? {
        return savedToken
    }

    func saveToken(_ token: String) {
        savedToken = token
    }

    func setRefreshing(_ refreshing: Bool) {
        isRefreshing = refreshing
    }
}
