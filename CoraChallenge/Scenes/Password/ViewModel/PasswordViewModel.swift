//  
//  PasswordViewModel.swift
//  CoraChallenge
//
//  Created by Guilerme Barciki on 22/06/24.
//

import Foundation

protocol PasswordDelegate: AnyObject {
    func updateLoginButtonState(isActive: Bool)
    func signInSuccess()
    func signInFail(with title: String, and message: String)
}

typealias PasswordNavigationData = String

class PasswordViewModel {
    
    
    // MARK: - Properties
    
    private var password: String?
    
    weak var delegate: PasswordDelegate?
    
    
    // MARK: - Init
    
    init(delegate: PasswordDelegate?) {
        self.delegate = delegate
    }
    
}


// MARK: - Navigation

extension PasswordViewModel {
    
    func prepareForNavigation(with navigationData: PasswordNavigationData) {}
    
}
    

// MARK: - Fetch Methods

extension PasswordViewModel {
    
    func validatePassword(_ value: String) {
        password = value
        delegate?.updateLoginButtonState(isActive: value.count >= 6)
    }
    
    func signIn() {
//        delegate?.signInSuccess()
        delegate?.signInFail(with: "Falha de Login", and: "Algo deu errado.")
    }
    
}
