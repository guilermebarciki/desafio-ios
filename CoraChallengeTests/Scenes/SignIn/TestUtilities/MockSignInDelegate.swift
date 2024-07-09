//
//  MockSignInDelegate.swift
//  CoraChallengeTests
//
//  Created by Guilerme Barciki on 07/07/24.
//

import Foundation
@testable import CoraChallenge

class MockSignInDelegate: SignInDelegate {
    var isNavigationButtonActive: Bool = false
    
    func updateNavigationButtonState(isActive: Bool) {
        isNavigationButtonActive = isActive
    }
}
