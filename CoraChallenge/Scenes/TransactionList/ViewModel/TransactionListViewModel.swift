//
//  TransactionListViewModel.swift
//  CoraChallenge
//
//  Created by Guilerme Barciki on 23/06/24.
//

import Foundation

protocol TransactionListDelegate: AnyObject {
    
    func updateView()
    func startLoading()
    func stopLoading()
    
}

typealias TransactionListNavigationData = Any

class TransactionListViewModel {
    
    
    // MARK: - Properties
    
    private var worker: TransactionListWorkerProtocol
    weak var delegate: TransactionListDelegate?
    
    private var transactions: [ListResult] = []
    private var filteredTransactions: [ListResult] = []
    
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
        defer { delegate?.stopLoading() }
        delegate?.startLoading()
        Task {
            let result = await worker.fetchList()
            
            switch result {
            case .success(let transactions):
                self.transactions = transactions
                self.filteredTransactions = transactions
                
                delegate?.updateView()
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
    
    func getTransactionFill(indexPath: IndexPath) -> TransactionItemFill? {
        guard let sectionItem = filteredTransactions.safeFind(at: indexPath.section),
              let transactionItem = sectionItem.items.safeFind(at: indexPath.row)
        else {
            return nil
        }
        return TransactionItemFill.getFrom(transaction: transactionItem)
    }
    
    func filterTransaction(at index: Int) {
        guard let segment = TransactionSegment(rawValue: index) else { return }
        switch segment {
        case .all:
            filteredTransactions = transactions
        case .input:
            filteredTransactions = filterTransactions(by: .credit)
        case .output:
            filteredTransactions = filterTransactions(by: .debit)
        case .future:
            filteredTransactions = []
        }
        delegate?.updateView()
    }
    
    private func filterTransactions(by type: Entry) -> [ListResult] {
        return transactions.compactMap { transactionItems in
            let filteredItems = transactionItems.items.filter { $0.entry == type }
            return filteredItems.isEmpty ? nil : ListResult(items: filteredItems, date: transactionItems.date)
        }
    }
    
    func getTransactionDetailNavigationData(at indexPath: IndexPath) -> TransactionDetailNavigationData? {
        guard let sectionItem = filteredTransactions.safeFind(at: indexPath.section),
              let transactionItem = sectionItem.items.safeFind(at: indexPath.row)
        else {
            return nil
        }
        return transactionItem.id
    }
    
}
