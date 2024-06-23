//
//  TransactionDetailRouter.swift
//  CoraChallenge
//
//  Created by Guilerme Barciki on 23/06/24.
//

import UIKit

class TransactionDetailRouter {
    
    
    // MARK: - Properties
    
    private var navigationController: UINavigationController
    
    
    // MARK: - Init
    
    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
}


// MARK: - Self Navigation

extension TransactionDetailRouter {
    
    func navigate(with navigationData: TransactionDetailNavigationData, animated: Bool = true) {
        let viewController = TransactionDetailViewController()
        viewController.prepareForNavigation(with: navigationData)
        
        navigationController.pushViewController(viewController, animated: animated)
        
    }
    
}

// MARK: - External navigation

extension TransactionDetailRouter {}
