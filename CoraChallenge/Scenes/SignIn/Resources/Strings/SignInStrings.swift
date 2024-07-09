//  
//  SignInStrings.swift
//  CoraChallenge
//
//  Created by Guilerme Barciki on 22/06/24.
//

import Foundation

final class SignInStrings {
    
    enum View: String, LocalizeRepresentable {
        var table: LocalizeTable { return .signIn }

        case title
        case welcomeLabel
        case cpfLabel
        case navigationButtonTitle

    }

    
}

