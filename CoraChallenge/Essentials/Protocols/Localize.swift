//
//  Localize.swift
//  CoraChallenge
//
//  Created by Guilerme Barciki on 21/06/24.
//

import Foundation

// MARK: - Representable Protocols

protocol LocalizeRepresentable: RawRepresentable {
    var localized: String { get }
    var table: LocalizeTable { get }
}


// MARK: - Representable Protocols Extensions

extension LocalizeRepresentable where RawValue == String {
    var localized: String {
        return Bundle.main.localizedString(forKey: rawValue, value: nil, table: table.rawValue)
    }
}


// MARK: - Feature Tables

enum LocalizeTable: String {
    
    case home = "Home"
    case signIn = "SignIn"
    case password = "Password"
    case transactionList = "TransactionList"
    
}


