//
//  EndPoint.swift
//  Pleny_Task
//
//  Created by Abdelrahman Salah on 18/03/2023.
//

import Foundation


enum EndPoint{
    case posts(page: Int)
    case login(credintials: Data?)
    case search(queryString: String)
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
        case .posts(let page):
            return "/posts"
        case .login:
            return "auth/login"
        case .search(let queryString):
            return "/posts/search"
        }
    }
    
    var methodType: MethodType{
        switch self {
        case .posts(let page):
            return .GET
        case .login(let credintials):
            return .POST(data: credintials)
        case .search:
            return .GET
        }
    }
    
    var queryItems: [String: String]?{
        switch self {
        case .posts(let page):
            return ["page": "\(page)"]
        case .search(let searchTerm):
            return ["q": "\(searchTerm)"]
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
        
        var requestQueryItems = queryItems?.compactMap { item in
            URLQueryItem(name: item.key, value: item.value)
        }
//        #if DEBUG
//        requestQueryItems?.append(URLQueryItem(name: "delay", value: "1"))
//        #endif
        
        urlComponent.queryItems = requestQueryItems
        return urlComponent.url
    }
}

