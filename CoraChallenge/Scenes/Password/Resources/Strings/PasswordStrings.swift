//  
//  PasswordStrings.swift
//  CoraChallenge
//
//  Created by Guilerme Barciki on 22/06/24.
//

import Foundation

final class PasswordStrings {
    
    enum View: String, LocalizeRepresentable {
        var table: LocalizeTable { return .password }
        
        case loginErrorMessageTitle
        case instructionLabel
        case forgotPasswordButtonTitle
        case signInButtonTitle
    }
  
}

