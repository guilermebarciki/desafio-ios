//
//  File.swift
//  CoraChallengeTests
//
//  Created by Guilerme Barciki on 09/07/24.
//

import Foundation
@testable import CoraChallenge

class MockTransactionListWorker: TransactionListWorkerProtocol {
    var fetchListResult: Result<[ListResult], NetworkError>?
    
    func fetchList() async -> Result<[ListResult], NetworkError> {
        return fetchListResult ?? .failure(.unauthorized)
    }
}

class MockTransactionListDelegate: TransactionListDelegate {
    var updateViewCalled = false
    var startLoadingCalled = false
    var stopLoadingCalled = false
    var fetchListFailCalled = false
    var fetchListFailError: String?
    
    func updateView() {
        updateViewCalled = true
    }
    
    func startLoading() {
        startLoadingCalled = true
    }
    
    func stopLoading() {
        stopLoadingCalled = true
    }
    
    func fetchListFail(error: String) {
        fetchListFailCalled = true
        fetchListFailError = error
    }
}
