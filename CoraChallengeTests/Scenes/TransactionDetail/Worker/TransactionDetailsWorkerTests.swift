//
//  TransactionDetailsWorkerTests.swift
//  CoraChallengeTests
//
//  Created by Guilerme Barciki on 09/07/24.
//

import XCTest

import XCTest
@testable import CoraChallenge

final class TransactionDetailsWorkerTests: XCTestCase {
    
    var sut: TransactionDetailsWorker!
    var mockBankService: MockBankService!
    var mockTokenStorage: MockTokenStorage!
    
    override func setUp() {
        super.setUp()
        mockBankService = MockBankService()
        mockTokenStorage = MockTokenStorage()
        sut = TransactionDetailsWorker(bankService: mockBankService, tokenStorage: mockTokenStorage)
    }
    
    override func tearDown() {
        sut = nil
        mockBankService = nil
        mockTokenStorage = nil
        super.tearDown()
    }
    
    func testFetchDetail_Success() async {
        // Given
        let expectedDetail = ItemDetails(
            description: "Test",
            label: "Test Label",
            amount: 1000,
            counterPartyName: "Test Name",
            id: "123",
            dateEvent: "2024-07-07",
            recipient: BankDetails(
                bankName: "Bank",
                bankNumber: "123",
                documentNumber: "123456789",
                documentType: "CPF",
                accountNumberDigit: "0",
                agencyNumberDigit: "0",
                agencyNumber: "0001",
                name: "Recipient",
                accountNumber: "123456"
            ),
            sender: BankDetails(
                bankName: "Bank",
                bankNumber: "123",
                documentNumber: "123456789",
                documentType: "CPF",
                accountNumberDigit: "0",
                agencyNumberDigit: "0",
                agencyNumber: "0001",
                name: "Sender",
                accountNumber: "123456"
            ),
            status: "Completed"
        )
        mockBankService.fetchDetailsResult = .success(expectedDetail)
        mockTokenStorage.savedToken = "valid_token"
        
        // When
        let result = await sut.fetchDetail(id: "123")
        
        // Then
        switch result {
        case .success(let detail):
            XCTAssertEqual(detail.description, expectedDetail.description)
        case .failure:
            XCTFail("Expected success but got failure")
        }
    }
    
    func testFetchDetail_Failure_InvalidToken() async {
        // Given
        mockTokenStorage.savedToken = nil
        
        // When
        let result = await sut.fetchDetail(id: "123")
        
        // Then
        switch result {
        case .success:
            XCTFail("Expected failure but got success")
        case .failure(let error):
            XCTAssertEqual(error, .unauthorized)
        }
    }
    
    func testFetchDetail_Failure_BankServiceError() async {
        // Given
        let expectedError = NetworkError.requestFailed
        mockBankService.fetchDetailsResult = .failure(expectedError)
        mockTokenStorage.savedToken = "valid_token"
        
        // When
        let result = await sut.fetchDetail(id: "123")
        
        // Then
        switch result {
        case .success:
            XCTFail("Expected failure but got success")
        case .failure(let error):
            XCTAssertEqual(error, expectedError)
        }
    }
}
