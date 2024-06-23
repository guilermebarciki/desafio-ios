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
    
    weak var delegate: TransactionListDelegate?
    
    
    // MARK: - Init
    
    init(delegate: TransactionListDelegate?) {
        self.delegate = delegate
    }
    
}


// MARK: - Navigation

extension TransactionListViewModel {
    
    func prepareForNavigation(with navigationData: TransactionListNavigationData) {}
    
}
    

// MARK: - Fetch Methods

extension TransactionListViewModel {}
