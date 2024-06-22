//  
//  SignInViewModel.swift
//  CoraChallenge
//
//  Created by Guilerme Barciki on 22/06/24.
//

import Foundation

protocol SignInDelegate: AnyObject {
    func updateButtonState(isActive: Bool)
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


// MARK: - Navigation

extension SignInViewModel {
    
    
}
    

// MARK: - Public Methods

extension SignInViewModel {
   
    func validateCPF(_ value: String?) {
            guard let cpf = value?.trimmingCharacters(in: .whitespacesAndNewlines).stringWithNumbersOnly(),
                  !cpf.isEmpty,
                  cpf.isValidCPF() else {
                invalidateCPF()
                return
            }
            storeValidCPF(cpf)
        }
        
        private func storeValidCPF(_ cpf: String) {
            self.cpf = cpf
            delegate?.updateButtonState(isActive: true)
        }
        
        private func invalidateCPF() {
            self.cpf = nil
            delegate?.updateButtonState(isActive: false)
        }
    
    
}

