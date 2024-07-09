//  
//  PasswordStrings.swift
//  CoraChallenge
//
//  Created by Guilerme Barciki on 22/06/24.
//

import Foundation

final class PasswordStrings {
    
    enum View: String, LocalizeRepresentable {
        var table: LocalizeTable { return .home }
        
        case loginErrorMessageTitle
    }
  
}

