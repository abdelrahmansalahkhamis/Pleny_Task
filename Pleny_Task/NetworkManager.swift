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


extension NetworkManager {
    enum NetworkingError: LocalizedError {
        case invalidURL
        case custom(error: Error)
        case invalidStatusCode(statusCode: Int)
        case invalidData
        case failedToDecode(error: Error)
    }
}
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
