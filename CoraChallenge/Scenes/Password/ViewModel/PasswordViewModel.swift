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
    private var cpf: String?
    
    weak var delegate: PasswordDelegate?
    private let authService: AuthServiceProtocol
    
    
    // MARK: - Init
    
    init(delegate: PasswordDelegate?, authService: AuthServiceProtocol = AuthService()) {
        self.delegate = delegate
        self.authService = authService
    }
    
}


// MARK: - Navigation

extension PasswordViewModel {
    
    func prepareForNavigation(with navigationData: PasswordNavigationData) {
        self.cpf = navigationData
    }
    
}


// MARK: - Fetch Methods

extension PasswordViewModel {
    
    func validatePassword(_ value: String) {
        password = value
        delegate?.updateLoginButtonState(isActive: value.count >= 6)
    }
    
    func signIn() {
        Task {
            guard let password,
                  let cpf else { return }
            
            let result = await authService.login(cpf: cpf, password: password)
            
            switch result {
            case .success(let token):
                CoraSession.current.setToken(with: token)
                delegate?.signInSuccess()
            case .failure(let error):
                delegate?.signInFail(with: "Falha de Login", and: error.localizedDescription)
            }
        }
    }
    
}
