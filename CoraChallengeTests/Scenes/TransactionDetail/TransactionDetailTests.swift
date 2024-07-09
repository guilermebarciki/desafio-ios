//
//  TransactionDetailTests.swift
//  CoraChallengeTests
//
//  Created by Guilerme Barciki on 09/07/24.
//

import XCTest
@testable import CoraChallenge

final class TransactionDetailViewModelTests: XCTestCase {
    
    var sut: TransactionDetailViewModel!
    var mockDelegate: MockTransactionDetailDelegate!
    var mockWorker: MockTransactionDetailsWorker!
    var asyncSchedulerFactorySpy: AsyncSchedulerFactorySpy!
    
    override func setUp() {
        super.setUp()
        mockDelegate = MockTransactionDetailDelegate()
        mockWorker = MockTransactionDetailsWorker()
        asyncSchedulerFactorySpy = AsyncSchedulerFactorySpy()
        sut = TransactionDetailViewModel(delegate: mockDelegate, worker: mockWorker, asyncSchedulerFactory: asyncSchedulerFactorySpy)
    }
    
    override func tearDown() {
        sut = nil
        mockDelegate = nil
        mockWorker = nil
        asyncSchedulerFactorySpy = nil
        super.tearDown()
    }
    
    func testPrepareForNavigation_SetsTransactionIdAndEntry() {
        // Given
        let navigationData: TransactionDetailNavigationData = (id: "123", entry: .credit)
        
        // When
        sut.prepareForNavigation(with: navigationData)
        
        // Then
        XCTAssertEqual(sut.transactionId, navigationData.id)
        XCTAssertEqual(sut.entry, navigationData.entry)
    }
    
    func testFetchTransactionDetail_Success() async {
        // Given
        let transactionId = "123"
        let entry: Entry = .credit
        let itemDetails = ItemDetails(
            description: "Test",
            label: "Test Label",
            amount: 1000,
            counterPartyName: "Test Name",
            id: transactionId,
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
        
        mockWorker.fetchDetailResult = .success(itemDetails)
        sut.prepareForNavigation(with: (id: transactionId, entry: entry))
        
        // When
        sut.fetchTransactionDetail()
        await asyncSchedulerFactorySpy.executeLast()
        
        // Then
        XCTAssertTrue(mockDelegate.updateViewCalled)
        XCTAssertFalse(mockDelegate.fetchDetailFailCalled)
        XCTAssertNotNil(mockDelegate.transactionDetailFill)
    }
    
    func testFetchTransactionDetail_Failure() async {
        // Given
        let transactionId = "123"
        let entry: Entry = .credit
        let error = NetworkError.unauthorized
        
        mockWorker.fetchDetailResult = .failure(error)
        sut.prepareForNavigation(with: (id: transactionId, entry: entry))
        
        // When
        sut.fetchTransactionDetail()
        await asyncSchedulerFactorySpy.executeLast()
        
        // Then
        XCTAssertFalse(mockDelegate.updateViewCalled)
        XCTAssertTrue(mockDelegate.fetchDetailFailCalled)
        XCTAssertEqual(mockDelegate.fetchDetailFailError, error.localizedDescription)
    }
}
