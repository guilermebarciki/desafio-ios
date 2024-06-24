//
//  TransactionFilterType.swift
//  CoraChallenge
//
//  Created by Guilerme Barciki on 24/06/24.
//

import Foundation

enum TransactionSegment: Int, CaseIterable {
    case all
    case input
    case output
    case future
    
    
    var title: String {
        switch self {
        case .all:
            return "Tudo"
        case .input:
            return "Entrada"
        case .output:
            return "Saída"
        case .future:
            return "Futuro"
        }
    }
}
