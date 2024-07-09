//
//  TransactionListWorkerTests.swift
//  CoraChallengeTests
//
//  Created by Guilerme Barciki on 09/07/24.
//

import XCTest
@testable import CoraChallenge

final class TransactionListWorkerTests: XCTestCase {
    
    var sut: TransactionListWorker!
    var mockBankService: MockBankService!
    var mockTokenStorage: MockTokenStorage!
    
    override func setUp() {
        super.setUp()
        mockBankService = MockBankService()
        mockTokenStorage = MockTokenStorage()
        sut = TransactionListWorker(bankService: mockBankService, tokenStorage: mockTokenStorage)
    }
    
    override func tearDown() {
        sut = nil
        mockBankService = nil
        mockTokenStorage = nil
        super.tearDown()
    }
    
    func testFetchList_Success() async {
        // Given
        let expectedTransactions = [ListResult(items: [], date: "2024-07-07")]
        mockBankService.fetchListResult = .success(expectedTransactions)
        mockTokenStorage.savedToken = "valid_token"
        
        // When
        let result = await sut.fetchList()
        
        // Then
        switch result {
        case .success(let transactions):
            XCTAssertEqual(transactions.first?.date, expectedTransactions.first?.date)
        case .failure:
            XCTFail("Expected success but got failure")
        }
    }
    
    func testFetchList_Failure_InvalidToken() async {
        // Given
        mockTokenStorage.savedToken = nil
        
        // When
        let result = await sut.fetchList()
        
        // Then
        switch result {
        case .success:
            XCTFail("Expected failure but got success")
        case .failure(let error):
            XCTAssertNotNil(error)
        }
    }
    
    func testFetchList_Failure_BankServiceError() async {
        // Given
        let expectedError = NetworkError.unauthorized
        mockBankService.fetchListResult = .failure(expectedError)
        mockTokenStorage.savedToken = "valid_token"
        
        // When
        let result = await sut.fetchList()
        
        // Then
        switch result {
        case .success:
            XCTFail("Expected failure but got success")
        case .failure(let error):
            XCTAssertEqual(error, expectedError)
        }
    }
}
