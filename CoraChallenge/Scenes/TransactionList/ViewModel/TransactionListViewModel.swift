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
    func fetchListFail(error: String)
}

class TransactionListViewModel {
    
    
    // MARK: - Properties
    
    private let worker: TransactionListWorkerProtocol
    weak var delegate: TransactionListDelegate?
    
    private var transactions: [ListResult] = []
    private var filteredTransactions: [ListResult] = []
    private let asyncSchedulerFactory: AsyncSchedulerFactory
    
    // MARK: - Init
    
    init(
        delegate: TransactionListDelegate?,
        worker: TransactionListWorkerProtocol = TransactionListWorker(),
        asyncSchedulerFactory: AsyncSchedulerFactory = TaskAsyncSchedulerFactory()
    ) {
        self.delegate = delegate
        self.worker = worker
        self.asyncSchedulerFactory = asyncSchedulerFactory
    }
    
}


// MARK: - Fetch Methods

extension TransactionListViewModel {
    
    func fetchTransactionList() {
        defer { delegate?.stopLoading() }
        
        asyncSchedulerFactory.create { [weak self] in
            guard let self else { return }
            
            delegate?.startLoading()
            let result = await worker.fetchList()
            
            switch result {
            case .success(let transactions):
                self.transactions = transactions
                self.filteredTransactions = transactions
                
                delegate?.updateView()
            case .failure(let error):
                delegate?.fetchListFail(error: error.localizedDescription)
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
        return (transactionItem.id, transactionItem.entry)
    }
    
}
