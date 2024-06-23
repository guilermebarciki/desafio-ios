//  
//  PasswordViewModel.swift
//  CoraChallenge
//
//  Created by Guilerme Barciki on 22/06/24.
//

import Foundation

protocol PasswordDelegate: AnyObject {}

typealias PasswordNavigationData = String

class PasswordViewModel {
    
    
    // MARK: - Properties
    
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

extension PasswordViewModel {}
