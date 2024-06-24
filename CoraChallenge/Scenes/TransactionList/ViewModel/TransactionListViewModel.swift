//
//  TransactionListViewModel.swift
//  CoraChallenge
//
//  Created by Guilerme Barciki on 23/06/24.
//

import Foundation

protocol TransactionListDelegate: AnyObject {
    
    func updateView()
    
}

typealias TransactionListNavigationData = Any

class TransactionListViewModel {
    
    
    // MARK: - Properties
    
    private var worker: TransactionListWorkerProtocol
    weak var delegate: TransactionListDelegate?
    
    private var transactions: [ListResult] = []
    private var filteredTransactions: [ListResult] {
        transactions
    }
    
    // MARK: - Init
    
    init(delegate: TransactionListDelegate?, worker: TransactionListWorkerProtocol = TransactionListWorker()) {
        self.delegate = delegate
        self.worker = worker
    }
    
}


// MARK: - Navigation

extension TransactionListViewModel {
    
    func prepareForNavigation(with navigationData: TransactionListNavigationData) {}
    
}


// MARK: - Fetch Methods

extension TransactionListViewModel {
    
    func fetchTransactionList() {
        Task {
            let result = await worker.fetchList()
            
            switch result {
            case .success(let transactions):
                self.transactions = transactions
                self.delegate?.updateView()
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
}


// MARK: - Public Methods

extension TransactionListViewModel {
    
    func getDaysCount() -> Int {
        filteredTransactions.count
    }
    
    func getTransactionsCount(at section: Int) -> Int {
        filteredTransactions.safeFind(at: section)?.items.count ?? 0
    }
    
    func getTransactionDateFill(for section: Int) -> DateHeaderFill? {
        guard let date = filteredTransactions.safeFind(at: section)?.date else { return nil }
        return DateHeaderFill.getFrom(date: date)
    }
    
    func getTransactionFill(section: Int, at row: Int) -> TransactionItemFill? {
        guard let sectionItem = filteredTransactions.safeFind(at: section),
              let transactionItem = sectionItem.items.safeFind(at: row)
        else {
            return nil
        }
        return TransactionItemFill.getFrom(transaction: transactionItem)
    }
    
}
