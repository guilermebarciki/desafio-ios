//  
//  PasswordViewController.swift
//  CoraChallenge
//
//  Created by Guilerme Barciki on 22/06/24.
//

import UIKit

class PasswordViewController: UIViewController, CoraNavigationStylable {
    
    
    // MARK: - Properties
    
    private lazy var viewModel = PasswordViewModel(delegate: self)
    
    private lazy var router: PasswordRouter? = {
        guard let navigationController = navigationController else { return nil }
        return PasswordRouter(with: navigationController)
    }()
    
    
    // MARK: - View's life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInterface()
        setupConstraints()
        applyNavigationStyle()
        dismissKeyboardWhenTappedOutside()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyNavigationStyle()
    }
    
}


// MARK: - Setup Methods

extension PasswordViewController {
    
    private func setupInterface() {
        view.backgroundColor = Colors.Neutral.white.color
        title = SignInStrings.View.title.localized
    }
    
    private func setupConstraints() {}
    
}


// MARK: - Navigation
    
extension PasswordViewController {
    
    func prepareForNavigation(with navigationData: PasswordNavigationData) {
        viewModel.prepareForNavigation(with: navigationData)
    }
 
}


// MARK: - Private methods
    
extension PasswordViewController {}


// MARK: - Public methods
    
extension PasswordViewController {}


// MARK: - Actions
    
extension PasswordViewController {}


// MARK: - PasswordDelegate

extension PasswordViewController: PasswordDelegate {}
