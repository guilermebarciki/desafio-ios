////
////  APIService.swift
////  CoraChallenge
////
////  Created by Guilerme Barciki on 23/06/24.
////
//
//import Foundation
//
//final class AppService {
//    private let authService: AuthServiceProtocol
//    private let listService: BankServiceProtocol
//    private var token: String?
//
//    init(authService: AuthServiceProtocol, listService: BankServiceProtocol) {
//        self.authService = authService
//        self.listService = listService
//    }
//
//    func login(cpf: String, password: String) async -> Bool {
//        let result = await authService.login(cpf: cpf, password: password)
//        switch result {
//        case .success(let token):
//            self.token = token
//            return true
//        case .failure:
//            return false
//        }
//    }
//
//    func refreshToken() async -> Bool {
//        guard let currentToken = token else { return false }
//        let result = await authService.refreshToken(oldToken: currentToken)
//        switch result {
//        case .success(let newToken):
//            self.token = newToken
//            return true
//        case .failure:
//            return false
//        }
//    }
//
//    func fetchList() async -> Result<[ListResult], NetworkError> {
//        guard let currentToken = token else { return .failure(.unauthorized) }
//        return await listService.fetchList(token: currentToken)
//    }
//
//    func fetchDetails(id: String) async -> Result<ItemDetails, NetworkError> {
//        guard let currentToken = token else { return .failure(.unauthorized) }
//        return await listService.fetchDetails(id: id, token: currentToken)
//    }
//}
//
