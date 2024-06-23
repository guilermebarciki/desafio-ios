//  
//  TransactionDetailViewController.swift
//  CoraChallenge
//
//  Created by Guilerme Barciki on 23/06/24.
//

import UIKit

class TransactionDetailViewController: UIViewController {
    
    
    // MARK: - Properties
    
    private lazy var viewModel = TransactionDetailViewModel(delegate: self)
    
    private lazy var router: TransactionDetailRouter? = {
        guard let navigationController = navigationController else { return nil }
        return TransactionDetailRouter(with: navigationController)
    }()
    
    
    // MARK: - View's life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInterface()
        setupConstraints()
    }
    
}


// MARK: - Setup Methods

extension TransactionDetailViewController {
    
    private func setupInterface() {}
    
    private func setupConstraints() {}
    
}


// MARK: - Navigation
    
extension TransactionDetailViewController {
    
    func prepareForNavigation(with navigationData: TransactionDetailNavigationData) {
        viewModel.prepareForNavigation(with: navigationData)
    }
 
}


// MARK: - Private methods
    
extension TransactionDetailViewController {}


// MARK: - Public methods
    
extension TransactionDetailViewController {}


// MARK: - Actions
    
extension TransactionDetailViewController {}


// MARK: - TransactionDetailDelegate

extension TransactionDetailViewController: TransactionDetailDelegate {}
