//
//  TransactionDetailViewModel.swift
//  CoraChallenge
//
//  Created by Guilerme Barciki on 23/06/24.
//

import Foundation

protocol TransactionDetailDelegate: AnyObject {
    func updateView(with: TransactionDetailFill)
}

typealias TransactionDetailNavigationData = (id: String, entry: Entry)

class TransactionDetailViewModel {
    
    
    // MARK: - Properties
    
    weak var delegate: TransactionDetailDelegate?
    private let worker: TransactionDetailsWorkerProtocol
    
    private var entry: Entry = .none
    private var transactionId: String = ""
    
    
    // MARK: - Init
    
    init(delegate: TransactionDetailDelegate?, worker: TransactionDetailsWorkerProtocol = TransactionDetailsWorker()) {
        self.delegate = delegate
        self.worker = worker
    }
    
}


// MARK: - Navigation

extension TransactionDetailViewModel {
    
    func prepareForNavigation(with navigationData: TransactionDetailNavigationData) {
        self.transactionId = navigationData.id
        self.entry = navigationData.entry
    }
    
}


// MARK: - Fetch Methods

extension TransactionDetailViewModel {
    
    func fetchTransactionDetail() {
        Task {
            let result = await worker.fetchDetail(id: self.transactionId)
            
            switch result {
            case .success(let details):
                delegate?.updateView(with: TransactionDetailFill.getFrom(transactionDetail: details, entry: entry))
            case .failure(let failure):
                return
            }
        }
    }
    
}
