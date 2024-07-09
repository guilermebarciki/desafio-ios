//
//  TransactionDetailViewModel.swift
//  CoraChallenge
//
//  Created by Guilerme Barciki on 23/06/24.
//

import Foundation

protocol TransactionDetailDelegate: AnyObject {
    func updateView(with: TransactionDetailFill)
    func fetchDetailFail(error: String)
}

typealias TransactionDetailNavigationData = (id: String, entry: Entry)

class TransactionDetailViewModel {
    
    
    // MARK: - Properties
    
    weak var delegate: TransactionDetailDelegate?
    private let worker: TransactionDetailsWorkerProtocol
    
    private(set) var entry: Entry = .none
    private(set) var transactionId: String = ""
    private let asyncSchedulerFactory: AsyncSchedulerFactory
    
    
    // MARK: - Init
    
    init(
        delegate: TransactionDetailDelegate?,
        worker: TransactionDetailsWorkerProtocol = TransactionDetailsWorker(),
        asyncSchedulerFactory: AsyncSchedulerFactory = TaskAsyncSchedulerFactory()
    ) {
        self.delegate = delegate
        self.worker = worker
        self.asyncSchedulerFactory = asyncSchedulerFactory
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
        asyncSchedulerFactory.create { [weak self] in
            guard let self else { return }
            
            let result = await worker.fetchDetail(id: self.transactionId)
            
            switch result {
            case .success(let details):
                delegate?.updateView(with: TransactionDetailFill.getFrom(transactionDetail: details, entry: entry))
            case .failure(let error):
                delegate?.fetchDetailFail(error: error.localizedDescription)
            }
        }
    }
    
}
