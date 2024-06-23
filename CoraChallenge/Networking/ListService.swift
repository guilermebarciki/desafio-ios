//
//  ListService.swift
//  CoraChallenge
//
//  Created by Guilerme Barciki on 23/06/24.
//

import Foundation

protocol BankListServiceProtocol {
    func fetchList(token: String) async -> Result<[ListItem], NetworkError>
    func fetchDetails(id: String, token: String) async -> Result<ItemDetails, NetworkError>
}

final class ListService: BankListServiceProtocol {
    private let networkService: NetworkServiceProtocol
    private let apiKey: String

    init(networkService: NetworkServiceProtocol = NetworkService(), apiKey: String = "c603c3e487c4def90aa3816b5525d8d4") {
        self.networkService = networkService
        self.apiKey = apiKey
    }

    func fetchList(token: String) async -> Result<[ListItem], NetworkError> {
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

struct ListResponse: Decodable {
    let results: [ListItem]
}

struct ListItem: Decodable {
    let id: String
    let description: String
    let label: String
    let entry: String
    let amount: Int
    let name: String
    let dateEvent: String
    let status: String
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

