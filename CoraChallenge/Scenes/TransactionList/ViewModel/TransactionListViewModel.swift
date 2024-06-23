//  
//  TransactionListViewModel.swift
//  CoraChallenge
//
//  Created by Guilerme Barciki on 23/06/24.
//

import Foundation

protocol TransactionListDelegate: AnyObject {}

typealias TransactionListNavigationData = Any

class TransactionListViewModel {
    
    
    // MARK: - Properties
    
    private var worker: TransactionListWorkerProtocol
    weak var delegate: TransactionListDelegate?
    
    
    
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
            case .success(let success):
                print(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
}


// MARK: - Public Methods

extension TransactionListViewModel { }
