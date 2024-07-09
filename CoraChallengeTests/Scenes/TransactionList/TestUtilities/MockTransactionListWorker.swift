//
//  MockTransactionListWorker.swift
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
