//
//  TransactionItemFill.swift
//  CoraChallenge
//
//  Created by Guilerme Barciki on 23/06/24.
//

import UIKit

struct TransactionItemFill {
    
    var icon: UIImage
    var tintColor: UIColor
    var formattedValue: String?
    var description: String
    var name: String
    var time: String
    
    static func getFrom(transaction: TransactionItem) -> TransactionItemFill {
        return TransactionItemFill(
            icon: getIcon(from: transaction.entry),
            tintColor: getTintColor(from: transaction.entry),
            formattedValue: getFormattedCurrency(from: transaction.amount),
            description: transaction.label,
            name: transaction.name,
            time: getTime(from: transaction.dateEvent)
        )
    }
    
    private static func getIcon(from entry: Entry) -> UIImage {
        switch entry {
        case .debit:
            return GlobalImages.Icons.debit.getImage()
        case .credit:
            return GlobalImages.Icons.credit.getImage()
        case .none:
            return UIImage()
        }
    }
    
    private static func getTintColor(from entry: Entry) -> UIColor {
        switch entry {
        case .debit, .none:
            return Colors.Neutral.black.color
        case .credit:
            return Colors.Highlight.blue.color
        }
    }
    
    private static func getTime(from date: String) -> String {
        let formatter = ISO8601DateFormatter()
        if let date = formatter.date(from: date) {
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "HH:mm"
            return timeFormatter.string(from: date)
        }
        return ""
    }
    
    private static func getFormattedCurrency(from amount: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "BRL"
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter.string(from: NSNumber(value: Double(amount) / 100.0)) ?? ""
    }
}
