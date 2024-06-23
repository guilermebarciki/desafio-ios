//
//  TransactionListRouter.swift
//  CoraChallenge
//
//  Created by Guilerme Barciki on 23/06/24.
//

import UIKit

class TransactionListRouter {
    
    
    // MARK: - Properties
    
    private var navigationController: UINavigationController
    
    
    // MARK: - Init
    
    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
}


// MARK: - Self Navigation

extension TransactionListRouter {
    
    func navigate(animated: Bool = true) {
        let viewController = TransactionListViewController()
        
        navigationController.pushViewController(viewController, animated: animated)
    }
    
}

// MARK: - External navigation

extension TransactionListRouter {
    
    func navigateToTransactionDetail(with navigationData: TransactionDetailNavigationData) {
        TransactionDetailRouter(with: navigationController).navigate(with: navigationData)
    }
    
}
