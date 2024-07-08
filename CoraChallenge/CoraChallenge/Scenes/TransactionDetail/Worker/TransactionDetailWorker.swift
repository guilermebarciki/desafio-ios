//
//  TransactionDetailWorker.swift
//  CoraChallenge
//
//  Created by Guilerme Barciki on 23/06/24.
//


protocol TransactionDetailsWorkerProtocol {
    func fetchDetail(id: String) async -> Result<ItemDetails, NetworkError>
}

final class TransactionDetailsWorker: TransactionDetailsWorkerProtocol {
    private let bankService: BankServiceProtocol
    private var tokenStorage: TokenStorageProtocol

    init(bankService: BankServiceProtocol = BankService(), tokenStorage: TokenStorageProtocol = TokenStorage.shared) {
        self.bankService = bankService
        self.tokenStorage = tokenStorage
    }

    func fetchDetail(id: String) async -> Result<ItemDetails, NetworkError> {
        guard let currentToken = await tokenStorage.getToken() else { return .failure(.unauthorized) }
        return await bankService.fetchDetails(id: id, token: currentToken)
    }
}
