//  
//  TransactionDetailViewModel.swift
//  CoraChallenge
//
//  Created by Guilerme Barciki on 23/06/24.
//

import Foundation

protocol TransactionDetailDelegate: AnyObject {}

typealias TransactionDetailNavigationData = Any

class TransactionDetailViewModel {
    
    
    // MARK: - Properties
    
    weak var delegate: TransactionDetailDelegate?
    
    
    // MARK: - Init
    
    init(delegate: TransactionDetailDelegate?) {
        self.delegate = delegate
    }
    
}


// MARK: - Navigation

extension TransactionDetailViewModel {
    
    func prepareForNavigation(with navigationData: TransactionDetailNavigationData) {}
    
}
    

// MARK: - Fetch Methods

extension TransactionDetailViewModel {}
