//  
//  TransactionListStrings.swift
//  CoraChallenge
//
//  Created by Guilerme Barciki on 23/06/24.
//

import Foundation

final class TransactionListStrings {
    
    enum View: String, LocalizeRepresentable {
        var table: LocalizeTable { return .transactionList}

        case title
    }
    
}

