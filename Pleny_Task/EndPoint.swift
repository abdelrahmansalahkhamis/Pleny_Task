//
//  EndPoint.swift
//  Pleny_Task
//
//  Created by Abdelrahman Salah on 18/03/2023.
//

import Foundation


enum EndPoint{
    case posts(limit: Int, skip: Int)
    case login(credintials: Data?)
    case search(limit: Int, queryString: String)
}

extension EndPoint{
    enum MethodType{
        case GET
        case POST(data: Data?)
    }
}

extension EndPoint{
    var host: String {"dummyjson.com"}

    var path: String{
        switch self {
        case .posts(let limit, let skip):
            return "/posts"
        case .login:
            return "/auth/login"
        case .search(let queryString):
            return "/posts/search"
        }
    }
    
    var methodType: MethodType{
        switch self {
        case .posts:
            return .GET
        case .login(let credintials):
            return .POST(data: credintials)
        case .search:
            return .GET
        }
    }
    
    var queryItems: [String: String]?{
        switch self {
        case .posts(let limit, let skip):
            return [
                "skip": "\(skip)",
                "limit": "\(limit)"
            ]
        case .search(let page, let searchTerm):
            return [
                "q": "\(searchTerm)",
                "page": "\(page)"
            ]
        case .login(let credintials):
            return [:]
        default:
            return nil
        }
    }
    
    var bodyItems: Data? {
        switch self {
        case .login(let credintails):
            return credintails
        default:
            return nil
        }
    }
    
}

extension EndPoint{
    var url: URL?{
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = host
        urlComponent.path = path
        
        let requestQueryItems = queryItems?.compactMap { item in
            URLQueryItem(name: item.key, value: item.value)
        }
//        #if DEBUG
//        requestQueryItems?.append(URLQueryItem(name: "delay", value: "1"))
//        #endif
        
        urlComponent.queryItems = requestQueryItems
        return urlComponent.url
    }
}

extension EndPoint{
    var body: Data?{
        let jsonData = try? JSONSerialization.data(withJSONObject: bodyItems)
        return jsonData
    }
}
