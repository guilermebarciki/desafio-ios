//
//  TransactionDetailWorker.swift
//  CoraChallenge
//
//  Created by Guilerme Barciki on 23/06/24.
//


protocol FetchDetailsWorkerProtocol {
    func fetchDetail(id: String) async -> Result<ItemDetails, NetworkError>
}

final class FetchDetailsWorker: FetchDetailsWorkerProtocol {
    private let bankService: BankServiceProtocol
    private var tokenStorage: TokenStorageProtocol

    init(bankService: BankServiceProtocol, tokenStorage: TokenStorageProtocol) {
        self.bankService = bankService
        self.tokenStorage = tokenStorage
    }

    func fetchDetail(id: String) async -> Result<ItemDetails, NetworkError> {
        guard let currentToken = await tokenStorage.getToken() else { return .failure(.unauthorized) }
        return await bankService.fetchDetails(id: id, token: currentToken)
    }
}
