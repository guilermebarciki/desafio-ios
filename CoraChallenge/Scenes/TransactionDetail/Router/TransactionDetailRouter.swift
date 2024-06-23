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
    
    func navigate(with navigationData: TransactionDetailNavigationData, customAnimation: Bool = true, navigationType: NavigationType = .push, animated: Bool = true, completion: (() -> Void)? = nil) {
        
        let viewController = TransactionDetailViewController()
        viewController.prepareForNavigation(with: navigationData)
        
        if navigationType == .push {
            navigationController.pushViewController(viewController, animated: animated)
        } else {
            navigationController.present(viewController, animated: animated, completion: completion)
        }
    }
    
}

// MARK: - External navigation

extension TransactionDetailRouter {}
