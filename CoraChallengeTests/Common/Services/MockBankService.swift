//
//  MockBankService.swift
//  CoraChallengeTests
//
//  Created by Guilerme Barciki on 09/07/24.
//

import Foundation
@testable import CoraChallenge

class MockBankService: BankServiceProtocol {
    var fetchListResult: Result<[ListResult], NetworkError>?
    var fetchDetailsResult: Result<ItemDetails, NetworkError>?
    
    func fetchList(token: String) async -> Result<[ListResult], NetworkError> {
        return fetchListResult ?? .failure(.unauthorized)
    }
    
    func fetchDetails(id: String, token: String) async -> Result<ItemDetails, NetworkError> {
        return fetchDetailsResult ?? .failure(.unauthorized)
    }
    
}
