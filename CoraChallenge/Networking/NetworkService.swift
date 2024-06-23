//
//  NetworkService.swift
//  CoraChallenge
//
//  Created by Guilerme Barciki on 23/06/24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case invalidResponse
    case decodingError
    case unauthorized
}

enum Endpoint {
    case login
    case refreshToken
    case fetchList
    case fetchDetails(id: String)

    var urlString: String {
        switch self {
        case .login:
            return "https://api.challenge.stage.cora.com.br/challenge/auth"
        case .refreshToken:
            return "https://api.challenge.stage.cora.com.br/challenge/auth"
        case .fetchList:
            return "https://api.challenge.stage.cora.com.br/challenge/list"
        case .fetchDetails(let id):
            return "https://api.challenge.stage.cora.com.br/challenge/details/\(id)"
        }
    }

    var method: String {
        switch self {
        case .login, .refreshToken:
            return "POST"
        case .fetchList, .fetchDetails:
            return "GET"
        }
    }
}


protocol NetworkServiceProtocol {
    func request<T: Decodable>(endpoint: Endpoint, headers: [String: String]?, body: Data?) async -> Result<T, NetworkError>
}

final class NetworkService: NetworkServiceProtocol {
    func request<T: Decodable>(endpoint: Endpoint, headers: [String: String]?, body: Data?) async -> Result<T, NetworkError> {
        guard let url = URL(string: endpoint.urlString) else {
            return .failure(.invalidURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method
        if let headers = headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        request.httpBody = body

        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                return .failure(.invalidResponse)
            }

            switch httpResponse.statusCode {
            case 200:
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    return .success(decodedData)
                } catch {
                    return .failure(.decodingError)
                }
            case 401:
                return .failure(.unauthorized)
            default:
                return .failure(.requestFailed)
            }
        } catch {
            return .failure(.requestFailed)
        }
    }
}

