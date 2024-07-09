//
//  MockTransactionDetailsWorker.swift
//  CoraChallengeTests
//
//  Created by Guilerme Barciki on 09/07/24.
//

import Foundation
@testable import CoraChallenge

class MockTransactionDetailsWorker: TransactionDetailsWorkerProtocol {
    var fetchDetailResult: Result<ItemDetails, NetworkError>?
    
    func fetchDetail(id: String) async -> Result<ItemDetails, NetworkError> {
        return fetchDetailResult ?? .failure(.unauthorized)
    }
}
