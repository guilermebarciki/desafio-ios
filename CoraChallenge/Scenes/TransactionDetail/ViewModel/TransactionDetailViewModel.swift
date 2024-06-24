//
//  TransactionDetailViewModel.swift
//  CoraChallenge
//
//  Created by Guilerme Barciki on 23/06/24.
//

import Foundation

protocol TransactionDetailDelegate: AnyObject {
    func updateView(with: TransactionDetailFill)
}

typealias TransactionDetailNavigationData = (id: String, entry: Entry)

class TransactionDetailViewModel {
    
    
    // MARK: - Properties
    
    weak var delegate: TransactionDetailDelegate?
    private let worker: TransactionDetailsWorkerProtocol
    
    private var entry: Entry = .none
    private var transactionId: String = ""
    
    
    // MARK: - Init
    
    init(delegate: TransactionDetailDelegate?, worker: TransactionDetailsWorkerProtocol = TransactionDetailsWorker()) {
        self.delegate = delegate
        self.worker = worker
    }
    
}


// MARK: - Navigation

extension TransactionDetailViewModel {
    
    func prepareForNavigation(with navigationData: TransactionDetailNavigationData) {
        self.transactionId = navigationData.id
        self.entry = navigationData.entry
    }
    
}


// MARK: - Fetch Methods

extension TransactionDetailViewModel {
    
    func fetchTransactionDetail() {
        Task {
            let result = await worker.fetchDetail(id: self.transactionId)
            
            switch result {
            case .success(let details):
                delegate?.updateView(with: TransactionDetailFill.getFrom(transactionDetail: details, entry: entry))
            case .failure(let failure):
                return
            }
        }
    }
    
}


import UIKit

struct TransactionDetailFill {
    let icon: UIImage
    let title: String
    let valueTitle: String
    let value: String
    let dateTitle: String
    let date: String
    let senderTitle: String
    let sender: String
    let senderDetails: [String]
    let recipientTitle: String
    let recipient: String
    let recipientDetails: [String]
    let descriptionTitle: String
    let descriptionDetails: [String]
    
    static func getFrom(transactionDetail: ItemDetails, entry: Entry) -> TransactionDetailFill {
        let recipientDetails = [
            "CPF \(transactionDetail.recipient.documentNumber)",
            "\(transactionDetail.recipient.bankName)",
            "Agência \(transactionDetail.recipient.agencyNumber) - Conta \(transactionDetail.recipient.accountNumber)-\(transactionDetail.recipient.accountNumberDigit)"
        ]
        
        let senderDetails = [
            "CPF \(transactionDetail.sender.documentNumber)",
            "\(transactionDetail.sender.bankName)",
            "Agência \(transactionDetail.sender.agencyNumber) - Conta \(transactionDetail.sender.accountNumber)-\(transactionDetail.sender.accountNumberDigit)"
        ]
        
        return TransactionDetailFill(
            icon: getIcon(from: entry),
            title: transactionDetail.label,
            valueTitle: "Valor",
            value: getFormattedCurrency(from: transactionDetail.amount),
            dateTitle: "Data",
            date: formatDate(transactionDetail.dateEvent),
            senderTitle: "De",
            sender: transactionDetail.sender.name,
            senderDetails: senderDetails,
            recipientTitle: "Para",
            recipient: transactionDetail.recipient.name,
            recipientDetails: recipientDetails,
            descriptionTitle: "Descrição",
            descriptionDetails: [transactionDetail.description]
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
    
    private static func getFormattedCurrency(from amount: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "BRL"
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter.string(from: NSNumber(value: Double(amount) / 100.0)) ?? ""
    }
    
    private static func formatDate(_ date: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        guard let dateObject = inputFormatter.date(from: date) else {
            return ""
        }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "EEEE - d 'de' MMMM"
        outputFormatter.locale = Locale(identifier: "pt_BR")
        
        return outputFormatter.string(from: dateObject).capitalized
    }
}
