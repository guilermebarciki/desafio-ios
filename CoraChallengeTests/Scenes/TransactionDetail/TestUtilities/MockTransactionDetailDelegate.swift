//
//  MockTransactionDetailDelegate.swift
//  CoraChallengeTests
//
//  Created by Guilerme Barciki on 09/07/24.
//

import Foundation
@testable import CoraChallenge

class MockTransactionDetailDelegate: TransactionDetailDelegate {
    var updateViewCalled = false
    var fetchDetailFailCalled = false
    var transactionDetailFill: TransactionDetailFill?
    var fetchDetailFailError: String?
    
    func updateView(with fill: TransactionDetailFill) {
        updateViewCalled = true
        transactionDetailFill = fill
    }
    
    func fetchDetailFail(error: String) {
        fetchDetailFailCalled = true
        fetchDetailFailError = error
    }
}
