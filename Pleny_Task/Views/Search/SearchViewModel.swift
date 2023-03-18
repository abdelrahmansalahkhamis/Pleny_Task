//
//  SearchViewModel.swift
//  Pleny_Task
//
//  Created by Abdelrahman Salah on 18/03/2023.
//

import Foundation


class SearchViewModel: ObservableObject{
    @Published var posts: [Post] = []
    @Published var viewState: ViewState?
    @Published var hasError: Bool = false
    @Published private(set) var error: NetworkManager.NetworkingError?
    private var page = 1
    private var totalPages: Int?
    var isLoading: Bool{
        viewState == .loading
    }
    var isFetching: Bool{
        viewState == .fetching
    }
    
    @MainActor
    func search(text: String) async{
        guard page != totalPages else{return}
        viewState = .fetching
        
        defer{viewState = .finished}
        page = page + 1
        do{
            let response = try await NetworkManager.shared.request(.search(queryString: text), ofType: PostModel.self)
            self.posts = response.posts
            print("posts.count = \(posts.count)")
        }catch{
            self.hasError = true
            if let networkingError = error as? NetworkManager.NetworkingError {
                self.error = networkingError
            } else {
                self.error = .custom(error: error)
            }
        }
    }
}
extension SearchViewModel{
    enum ViewState{
        case fetching
        case loading
        case finished
    }
}


extension SearchViewModel{
    func reset(){
        if viewState == .finished{
            posts.removeAll()
            page = 1
            totalPages = nil
            viewState = nil
        }
    }
}
