//
//  ListService.swift
//  CoraChallenge
//
//  Created by Guilerme Barciki on 23/06/24.
//

import Foundation

protocol BankServiceProtocol {
    func fetchList(token: String) async -> Result<[ListResult], NetworkError>
    func fetchDetails(id: String, token: String) async -> Result<ItemDetails, NetworkError>
}

final class BankService: BankServiceProtocol {
    private let networkService: NetworkServiceProtocol
    private let apiKey: String

    init(networkService: NetworkServiceProtocol = NetworkService(), apiKey: String = Configuration.apiKey) {
        self.networkService = networkService
        self.apiKey = apiKey
    }

    func fetchList(token: String) async -> Result<[ListResult], NetworkError> {
        let headers = ["apikey": apiKey, "token": token]

        let result: Result<ListResponse, NetworkError> = await networkService.request(endpoint: .fetchList, headers: headers, body: nil)

        switch result {
        case .success(let listResponse):
            return .success(listResponse.results)
        case .failure(let error):
            return .failure(error)
        }
    }

    func fetchDetails(id: String, token: String) async -> Result<ItemDetails, NetworkError> {
        let headers = ["apikey": apiKey, "token": token]

        let result: Result<ItemDetails, NetworkError> = await networkService.request(endpoint: .fetchDetails(id: id), headers: headers, body: nil)

        switch result {
        case .success(let itemDetails):
            return .success(itemDetails)
        case .failure(let error):
            return .failure(error)
        }
    }
}

