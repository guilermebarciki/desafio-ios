//
//  MockPasswordDelegate.swift
//  CoraChallengeTests
//
//  Created by Guilerme Barciki on 07/07/24.
//

import Foundation
@testable import CoraChallenge

final class MockPasswordDelegate: PasswordDelegate {
    
    var isLoginButtonActive: Bool?
    var signInSuccessCalled = false
    var signInFailCalled = false
    
    func updateLoginButtonState(isActive: Bool) {
        isLoginButtonActive = isActive
    }
    
    func signInSuccess() {
        signInSuccessCalled = true
    }
    
    func signInFail(error: String)  {
        signInFailCalled = true
    }
}
