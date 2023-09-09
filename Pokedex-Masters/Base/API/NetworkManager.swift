//
//  NetworkManager.swift
//  Pokedex-Masters
//
//  Created by Doni on 9/9/23.
//

import Foundation

protocol NetworkManagerProtocol {
    func request<T: Codable>(session: URLSession, _ endpoint: Endpoint, type: T.Type) async throws -> T
}

class NetworkManager: NetworkManagerProtocol {
    
    static let shared = NetworkManager()
    
    private init () {}
    
    func request<T>(session: URLSession, _ endpoint: Endpoint, type: T.Type ) async throws -> T where T : Decodable, T : Encodable {
        
        guard let url = endpoint.url else {
            throw NetworkError.invalidURL
        }
        
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await session.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...300) ~= httpResponse.statusCode else {
            let statusCode = (response as! HTTPURLResponse).statusCode
            throw NetworkError.invalidStatusCode(statusCode: statusCode)
        }
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            return try jsonDecoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.failedToDecode(error: error)
        }
    }
    
}

extension NetworkManager {
    enum NetworkError: LocalizedError {
        case invalidURL
        case invalidStatusCode(statusCode: Int)
        case failedToDecode(error: Error)
        case custom(error: Error)
    }
}

extension NetworkManager.NetworkError: Equatable {
    static func == (lhs: NetworkManager.NetworkError, rhs: NetworkManager.NetworkError) -> Bool {
        switch(lhs, rhs) {
            case (.invalidURL, .invalidURL):
                return true
            case (.custom(let lhsType), .custom(let rhsType)):
                return lhsType.localizedDescription == rhsType.localizedDescription
            case(.failedToDecode(let lhsType), .failedToDecode(let rhsType)):
                return lhsType.localizedDescription == rhsType.localizedDescription
            case(.invalidStatusCode(let lhsType), .invalidStatusCode(let rhsType)):
                return lhsType == rhsType
            default:
                return false
        }
    }
}

extension NetworkManager.NetworkError {
    var errorDescription: String? {
        switch self {
            case .invalidURL:
                return "URL isn't valid"
            case .invalidStatusCode:
                return "Status code falls into the wrong range"
            case .failedToDecode:
                return "Failed to decode"
            case .custom(let err):
                return "Something went wrong \(err.localizedDescription)"
        }
    }
}
