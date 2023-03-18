//
//  NetworkManager.swift
//  Pleny_Task
//
//  Created by Abdelrahman Salah on 18/03/2023.
//

import Foundation

protocol NetworkingManagerProtocol {
    func request<T: Codable>(_ endpoint: EndPoint, ofType: T.Type) async throws -> T
    func request(_ endpoint: EndPoint) async throws
}

class NetworkManager: NetworkingManagerProtocol{
    static let shared = NetworkManager()
    func request<T>(_ endpoint: EndPoint, ofType: T.Type) async throws -> T where T : Decodable, T : Encodable {
        guard let url = endpoint.url else {
            throw NetworkingError.invalidURL
        }
        
        let request = buildRequest(from: url, methodType: endpoint.methodType)
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, (200...300) ~= response.statusCode else {
            let statusCode = (response as! HTTPURLResponse).statusCode
            throw NetworkingError.invalidStatusCode(statusCode: statusCode)
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let res = try decoder.decode(T.self, from: data)
        return res
    }
    
    func request(_ endpoint: EndPoint) async throws {
        guard let url = endpoint.url else {
            throw NetworkingError.invalidURL
        }
        
        let request = buildRequest(from: url, methodType: endpoint.methodType)
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, (200...300) ~= response.statusCode else {
            let statusCode = (response as! HTTPURLResponse).statusCode
            throw NetworkingError.invalidStatusCode(statusCode: statusCode)
        }
    }
    
}



extension NetworkManager.NetworkingError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "URL isn't valid"
        case .custom(let error):
            return "Something went wrong: \(error.localizedDescription)"
        case .invalidStatusCode:
            return "Status code falls into the wrong range"
        case .invalidData:
            return "Response data is invalid"
        case .failedToDecode(let error):
            return "Decode failure occured: \(error)"
        }
    }
}


extension NetworkManager {
    enum NetworkingError: LocalizedError {
        case invalidURL
        case custom(error: Error)
        case invalidStatusCode(statusCode: Int)
        case invalidData
        case failedToDecode(error: Error)
    }
}

//extension NetworkManager.NetworkingError: Equatable {
//    static func == (lhs: NetworkManager.NetworkingError, rhs: NetworkManager.NetworkingError) -> Bool {
//        switch (lhs, rhs) {
//        case (.invalidURL, .invalidURL):
//            return true
//        case (.custom(let lhsType), .custom(let rhsType)):
//            return lhsType.localizedDescription == rhsType.localizedDescription
//        case (.invalidStatusCode(let lhsType), .invalidStatusCode(let rhsType)):
//            return lhsType == rhsType
//        case (.invalidData, .invalidData):
//            return true
//        case (.failedToDecode(let lhsType), .failedToDecode(let rhsType)):
//            return lhsType.localizedDescription == rhsType.localizedDescription
//        default:
//            return false
//        }
//    }
//}

private extension NetworkManager {
    func buildRequest(from url: URL, methodType: EndPoint.MethodType) -> URLRequest {
        
        var request = URLRequest(url: url)
        
        switch methodType {
        case .GET:
            request.httpMethod = "GET"
        case .POST(let data):
            request.httpMethod = "POST"
            request.httpBody = data
        }
        
        return request
    }
}
