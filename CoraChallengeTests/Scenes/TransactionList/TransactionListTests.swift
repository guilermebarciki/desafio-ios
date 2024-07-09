//
//  TransactionListTests.swift
//  CoraChallengeTests
//
//  Created by Guilerme Barciki on 09/07/24.
//

import XCTest
@testable import CoraChallenge

final class TransactionListTests: XCTestCase {
    
    var sut: TransactionListViewModel!
    var mockDelegate: MockTransactionListDelegate!
    var mockWorker: MockTransactionListWorker!
    var asyncSchedulerFactorySpy: AsyncSchedulerFactorySpy!
    
    let filterAllIndex = 0
    let filterInputIndex = 1
    let filterOutputIndex = 2
    
    override func setUp() {
        super.setUp()
        mockDelegate = MockTransactionListDelegate()
        mockWorker = MockTransactionListWorker()
        asyncSchedulerFactorySpy = AsyncSchedulerFactorySpy()
        sut = TransactionListViewModel(delegate: mockDelegate, worker: mockWorker, asyncSchedulerFactory: asyncSchedulerFactorySpy)
    }
    
    override func tearDown() {
        sut = nil
        mockDelegate = nil
        mockWorker = nil
        asyncSchedulerFactorySpy = nil
        super.tearDown()
    }
    
    func testFetchTransactionList_Success() async {
        // Given
        let transactions = [ListResult(items: [], date: "2024-07-07")]
        mockWorker.fetchListResult = .success(transactions)
        
        // When
        sut.fetchTransactionList()
        await asyncSchedulerFactorySpy.executeLast()
        
        // Then
        XCTAssertTrue(mockDelegate.startLoadingCalled)
        XCTAssertTrue(mockDelegate.stopLoadingCalled)
        XCTAssertTrue(mockDelegate.updateViewCalled)
        XCTAssertFalse(mockDelegate.fetchListFailCalled)
        XCTAssertEqual(sut.getDaysCount(), transactions.count)
    }
    
    func testFetchTransactionList_Failure() async {
        // Given
        let error = NetworkError.unauthorized
        mockWorker.fetchListResult = .failure(error)
        
        // When
        sut.fetchTransactionList()
        await asyncSchedulerFactorySpy.executeLast()
        
        // Then
        XCTAssertTrue(mockDelegate.startLoadingCalled)
        XCTAssertTrue(mockDelegate.stopLoadingCalled)
        XCTAssertFalse(mockDelegate.updateViewCalled)
        XCTAssertTrue(mockDelegate.fetchListFailCalled)
        XCTAssertEqual(mockDelegate.fetchListFailError, error.localizedDescription)
    }
    
    func testFilterTransaction_All() async {
        // Given
        let transactions = [
            ListResult(
                items: [TransactionItem(
                    id: "1",
                    description: "Desc1",
                    label: "Label1",
                    entry: .credit,
                    amount: 100,
                    name: "Name1",
                    dateEvent: "2024-07-07",
                    status: "Completed"
                )],
                date: "2024-07-07"
            )
        ]
        mockWorker.fetchListResult = .success(transactions)
        
        // When
        sut.fetchTransactionList()
        await asyncSchedulerFactorySpy.executeLast()
        sut.filterTransaction(at: filterAllIndex)
        
        // Then
        XCTAssertEqual(sut.getDaysCount(), transactions.count)
        XCTAssertTrue(mockDelegate.updateViewCalled)
    }
    
    func testFilterTransaction_Input() async {
        // Given
        let transactions = [
            ListResult(
                items: [
                    TransactionItem(
                        id: "1",
                        description: "Desc1",
                        label: "Label1",
                        entry: .credit,
                        amount: 100,
                        name: "Name1",
                        dateEvent: "2024-07-07",
                        status: "Completed"
                    ),
                    TransactionItem(
                        id: "2",
                        description: "Desc2",
                        label: "Label2",
                        entry: .debit,
                        amount: 200,
                        name: "Name2",
                        dateEvent: "2024-07-08",
                        status: "Completed"
                    )
                ],
                date: "2024-07-07"
            )
        ]
        mockWorker.fetchListResult = .success(transactions)
        
        // When
        sut.fetchTransactionList()
        await asyncSchedulerFactorySpy.executeLast()
        sut.filterTransaction(at: filterInputIndex)
        
        // Then
        XCTAssertEqual(sut.getDaysCount(), 1) // Only 1 credit entry
        XCTAssertTrue(mockDelegate.updateViewCalled)
    }
    
    func testFilterTransaction_Output() async {
        // Given
        let transactions = [
            ListResult(
                items: [
                    TransactionItem(
                        id: "1",
                        description: "Desc1",
                        label: "Label1",
                        entry: .credit,
                        amount: 100,
                        name: "Name1",
                        dateEvent: "2024-07-07",
                        status: "Completed"
                    ),
                    TransactionItem(
                        id: "2",
                        description: "Desc2",
                        label: "Label2",
                        entry: .debit,
                        amount: 200,
                        name: "Name2",
                        dateEvent: "2024-07-08",
                        status: "Completed"
                    )
                ],
                date: "2024-07-07"
            )
        ]
        mockWorker.fetchListResult = .success(transactions)
        
        // When
        sut.fetchTransactionList()
        await asyncSchedulerFactorySpy.executeLast()
        sut.filterTransaction(at: filterOutputIndex)
        
        // Then
        XCTAssertEqual(sut.getDaysCount(), 1) // Only 1 debit entry
        XCTAssertTrue(mockDelegate.updateViewCalled)
    }
    
    func testGetTransactionDetailNavigationData() async {
        // Given
        let transactionItem = TransactionItem(
            id: "1",
            description: "Desc1",
            label: "Label1",
            entry: .credit,
            amount: 100,
            name: "Name1",
            dateEvent: "2024-07-07",
            status: "Completed"
        )
        let transactions = [ListResult(items: [transactionItem], date: "2024-07-07")]
        mockWorker.fetchListResult = .success(transactions)
        
        // When
        sut.fetchTransactionList()
        await asyncSchedulerFactorySpy.executeLast()
        let navigationData = sut.getTransactionDetailNavigationData(at: IndexPath(row: 0, section: 0))
        
        // Then
        XCTAssertEqual(navigationData?.0, transactionItem.id)
        XCTAssertEqual(navigationData?.1, transactionItem.entry)
    }
    
    func testGetTransactionsCount() async {
        // Given
        let transactions = [
            ListResult(
                items: [TransactionItem(
                    id: "1",
                    description: "Desc1",
                    label: "Label1",
                    entry: .credit,
                    amount: 100,
                    name: "Name1",
                    dateEvent: "2024-07-07",
                    status: "Completed"
                )],
                date: "2024-07-07"
            )
        ]
        mockWorker.fetchListResult = .success(transactions)
        
        // When
        sut.fetchTransactionList()
        await asyncSchedulerFactorySpy.executeLast()
        
        // Then
        XCTAssertEqual(sut.getTransactionsCount(at: 0), transactions.first?.items.count)
    }
    
    func testGetTransactionDateFill() async {
        // Given
        let date = "2024-07-07"
        let transactions = [
            ListResult(
                items: [TransactionItem(
                    id: "1",
                    description: "Desc1",
                    label: "Label1",
                    entry: .credit,
                    amount: 100,
                    name: "Name1",
                    dateEvent: date,
                    status: "Completed"
                )],
                date: date
            )
        ]
        mockWorker.fetchListResult = .success(transactions)
        
        // When
        sut.fetchTransactionList()
        await asyncSchedulerFactorySpy.executeLast()
        let dateFill = sut.getTransactionDateFill(for: 0)
        
        // Then
        XCTAssertNotNil(dateFill)
        XCTAssertEqual(dateFill?.formattedDate, DateHeaderFill.getFrom(date: date)?.formattedDate)
    }
    
    func testGetTransactionFill() async {
        // Given
        let transactionItem = TransactionItem(
            id: "1",
            description: "Desc1",
            label: "Label1",
            entry: .credit,
            amount: 100,
            name: "Name1",
            dateEvent: "2024-07-07",
            status: "Completed"
        )
        let transactions = [ListResult(items: [transactionItem], date: "2024-07-07")]
        mockWorker.fetchListResult = .success(transactions)
        
        // When
        sut.fetchTransactionList()
        await asyncSchedulerFactorySpy.executeLast()
        let transactionFill = sut.getTransactionFill(indexPath: IndexPath(row: 0, section: 0))
        
        // Then
        XCTAssertNotNil(transactionFill)
        XCTAssertEqual(transactionFill?.description, transactionItem.label)
        XCTAssertEqual(transactionFill?.name, transactionItem.name)
    }
}
