//
//  TransactionListWorker.swift
//  CoraChallenge
//
//  Created by Guilerme Barciki on 23/06/24.
//

import Foundation

import Foundation

protocol TransactionListWorkerProtocol {
    func fetchList() async -> Result<[ListResult], NetworkError>
}

final class TransactionListWorker: TransactionListWorkerProtocol {
    private let bankService: BankServiceProtocol
    private var tokenStorage: TokenStorageProtocol

    init(bankService: BankServiceProtocol = BankService(), tokenStorage: TokenStorageProtocol = TokenStorage()) {
        self.bankService = bankService
        self.tokenStorage = tokenStorage
    }

    func fetchList() async -> Result<[ListResult], NetworkError> {
        guard let currentToken = tokenStorage.getToken() else { return .failure(.unauthorized) }
        return await bankService.fetchList(token: currentToken)
    }
}
