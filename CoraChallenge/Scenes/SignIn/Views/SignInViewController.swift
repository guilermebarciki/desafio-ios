//  
//  SignInViewController.swift
//  CoraChallenge
//
//  Created by Guilerme Barciki on 22/06/24.
//

import UIKit

final class SignInViewController: UIViewController, CoraNavigationStyling {
    
    
    // MARK: - Properties
    
    private lazy var viewModel = SignInViewModel(delegate: self)
    
    private lazy var router: SignInRouter? = {
        guard let navigationController = navigationController else { return nil }
        return SignInRouter(with: navigationController)
    }()
    
    
    // MARK: - View's life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInterface()
        setupConstraints()
        applyNavigationStyle()
    }
    
}


// MARK: - Setup Methods

extension SignInViewController {
    
    private func setupInterface() {
        view.backgroundColor = .green
        title = "OJVSFOVJFDOIGJDF"
    }
    
    private func setupConstraints() {}
    
}


// MARK: - Private methods
    
extension SignInViewController {}


// MARK: - Public methods
    
extension SignInViewController {}


// MARK: - Actions
    
extension SignInViewController {}


// MARK: - SignInDelegate

extension SignInViewController: SignInDelegate {}
