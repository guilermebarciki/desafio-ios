//  
//  TransactionListViewController.swift
//  CoraChallenge
//
//  Created by Guilerme Barciki on 23/06/24.
//

import UIKit

class TransactionListViewController: UIViewController {
    
    
    // MARK: - Properties
    
    private lazy var viewModel = TransactionListViewModel(delegate: self)
    
    private lazy var router: TransactionListRouter? = {
        guard let navigationController = navigationController else { return nil }
        return TransactionListRouter(with: navigationController)
    }()
    
    
    // MARK: - View's life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInterface()
        setupConstraints()
    }
    
}


// MARK: - Setup Methods

extension TransactionListViewController {
    
    private func setupInterface() {}
    
    private func setupConstraints() {}
    
}


// MARK: - Navigation
    
extension TransactionListViewController {
    
    func prepareForNavigation(with navigationData: TransactionListNavigationData) {
        viewModel.prepareForNavigation(with: navigationData)
    }
 
}


// MARK: - Private methods
    
extension TransactionListViewController {}


// MARK: - Public methods
    
extension TransactionListViewController {}


// MARK: - Actions
    
extension TransactionListViewController {}


// MARK: - TransactionListDelegate

extension TransactionListViewController: TransactionListDelegate {}
