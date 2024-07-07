//
//  HomeStrings.swift
//  CoraChallenge
//
//  Created by Guilerme Barciki on 21/06/24.
//

import Foundation

final class HomeStrings {
    
    enum View: String, LocalizeRepresentable {
        var table: LocalizeTable { return .home }
        
        case title
        case description
        case signinButton
        case signupButton
        
    }
    
}
