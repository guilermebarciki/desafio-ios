//
//  SignInRouter.swift
//  CoraChallenge
//
//  Created by Guilerme Barciki on 22/06/24.
//

import UIKit

class SignInRouter {
    
    
    // MARK: - Properties
    
    private var navigationController: UINavigationController
    
    
    // MARK: - Init
    
    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
}


// MARK: - Self Navigation

extension SignInRouter {
    
    func navigate(animated: Bool = true) {
        let viewController = SignInViewController()
        navigationController.pushViewController(viewController, animated: animated)
    }
    
}

// MARK: - External navigation

extension SignInRouter {
    
    func navigateToPassword(with navigationData: PasswordNavigationData) {
        PasswordRouter(with: navigationController).navigate(with: navigationData)
    }
    
}
