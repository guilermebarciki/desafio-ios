//  
//  SignInViewModel.swift
//  CoraChallenge
//
//  Created by Guilerme Barciki on 22/06/24.
//

import Foundation

protocol SignInDelegate: AnyObject {}

typealias SignInNavigationData = Any

class SignInViewModel {
    
    
    // MARK: - Properties
    
    weak var delegate: SignInDelegate?
    
    
    // MARK: - Init
    
    init(delegate: SignInDelegate?) {
        self.delegate = delegate
    }
    
}


// MARK: - Navigation

extension SignInViewModel {
    
    
}
    

// MARK: - Fetch Methods

extension SignInViewModel {}
