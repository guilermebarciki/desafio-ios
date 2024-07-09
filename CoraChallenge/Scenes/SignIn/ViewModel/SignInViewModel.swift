//
//  SignInViewModel.swift
//  CoraChallenge
//
//  Created by Guilerme Barciki on 22/06/24.
//

import Foundation

protocol SignInDelegate: AnyObject {
    func updateNavigationButtonState(isActive: Bool)
}

typealias SignInNavigationData = Any

class SignInViewModel {
    
    
    // MARK: - Properties
    
    private var cpf: String?
    weak var delegate: SignInDelegate?
    
    
    // MARK: - Init
    
    init(delegate: SignInDelegate?) {
        self.delegate = delegate
    }
    
}

// MARK: - Public Methods

extension SignInViewModel {
    
    func validateCPF(_ value: String?) {
        guard let cpf = value?.stringWithNumbersOnly(),
              cpf.isValidCPF() else {
            invalidateCPF()
            return
        }
        storeValidCPF(cpf)
    }
    
    func getCPF() -> String? {
        return cpf
    }
    
    private func storeValidCPF(_ cpf: String) {
        self.cpf = cpf
        delegate?.updateNavigationButtonState(isActive: true)
    }
    
    private func invalidateCPF() {
        self.cpf = nil
        delegate?.updateNavigationButtonState(isActive: false)
    }
    
    
}

