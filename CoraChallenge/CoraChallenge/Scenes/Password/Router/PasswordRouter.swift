//  
//  PasswordRouter.swift
//  CoraChallenge
//
//  Created by Guilerme Barciki on 22/06/24.
//

import UIKit

class PasswordRouter {
    
    
    // MARK: - Properties
    
    private var navigationController: UINavigationController
    
    
    // MARK: - Init
    
    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
}


// MARK: - Self Navigation

extension PasswordRouter {
    
    func navigate(with navigationData: PasswordNavigationData, animated: Bool = true) {
        let viewController = PasswordViewController()
        viewController.prepareForNavigation(with: navigationData)
        
        navigationController.pushViewController(viewController, animated: animated)
    }
    
}

// MARK: - External navigation

extension PasswordRouter {
    
    func navigateToTransactionList() {
        TransactionListRouter(with: navigationController).navigate()
    }
    
}

