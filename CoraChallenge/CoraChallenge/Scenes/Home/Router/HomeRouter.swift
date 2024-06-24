//
//  HomeRouter.swift
//  CoraChallenge
//
//  Created by Guilerme Barciki on 22/06/24.
//

import Foundation
import UIKit


class HomeRouter {
    
    
    // MARK: - Properties
    
    internal var navigationController: UINavigationController
    
    
    // MARK: - Init
    
    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
}

// MARK: - External navigation

extension HomeRouter {
    
    func navigateSignIn() {
        SignInRouter(with: navigationController).navigate()
    }
    
}
