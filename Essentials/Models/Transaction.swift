//
//  Transaction.swift
//  CoraChallenge
//
//  Created by Guilerme Barciki on 24/06/24.
//

import Foundation

struct TransactionItem: Decodable {
    let id: String
    let description: String
    let label: String
    let entry: Entry
    let amount: Int
    let name: String
    let dateEvent: String
    let status: String
}

enum Entry: String, Decodable {
    case debit = "DEBIT"
    case credit = "CREDIT"
    case none

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        self = Entry(rawValue: value) ?? .none
    }
}

struct ListResult: Decodable {
    let items: [TransactionItem]
    let date: String
}

struct ListResponse: Decodable {
    let results: [ListResult]
    let itemsTotal: Int
}

struct ItemDetails: Decodable {
    let description: String
    let label: String
    let amount: Int
    let counterPartyName: String
    let id: String
    let dateEvent: String
    let recipient: BankDetails
    let sender: BankDetails
    let status: String
}

struct BankDetails: Decodable {
    let bankName: String
    let bankNumber: String
    let documentNumber: String
    let documentType: String
    let accountNumberDigit: String
    let agencyNumberDigit: String
    let agencyNumber: String
    let name: String
    let accountNumber: String
}

