//
//  SearchViewModel.swift
//  Pleny_Task
//
//  Created by Abdelrahman Salah on 18/03/2023.
//

import Foundation


class SearchViewModel: ObservableObject{
    @Published var searchedPosts: [Post] = []
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
            let response = try await NetworkManager.shared.request(.search(limit: page, queryString: text.trimmed()), ofType: PostModel.self)
            
            // remove data if its new request
            if page == 1{
                searchedPosts.removeAll()
            }
            self.searchedPosts = response.posts
            print("posts.count = \(searchedPosts.count)")
        }catch{
            self.hasError = true
            if let networkingError = error as? NetworkManager.NetworkingError {
                self.error = networkingError
            } else {
                self.error = .custom(error: error)
            }
        }
    }
    
    func hasRechedEnd(of post: Post) -> Bool{
        return searchedPosts.last?.id == post.id
    }
}
extension SearchViewModel{
    enum ViewState{
        case fetching
        case loading
        case finished
    }
}
