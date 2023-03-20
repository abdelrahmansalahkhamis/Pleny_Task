//
//  PostsViewModel.swift
//  Pleny_Task
//
//  Created by Abdelrahman Salah on 17/03/2023.
//

import Foundation

class PostsViewModel: ObservableObject{
    @Published var posts: [Post] = []
    @Published var viewState: ViewState?
    @Published var hasError: Bool = false
    @Published private(set) var error: NetworkManager.NetworkingError?
    private var page = 1
    private var totalPages: Int?
    private var skipPageIndex: Int = 0
    private var limitPerPage: Int = 10
    var isLoading: Bool{
        viewState == .loading
    }
    var isFetching: Bool{
        viewState == .fetching
    }
    @MainActor
    func fetchPosts() async{
        reset()
        viewState = .loading
        
        defer{viewState = .finished}
        
        do{
            let response = try await NetworkManager.shared.request(.posts(limit: limitPerPage, skip: skipPageIndex), ofType: PostModel.self)
            self.posts = response.posts
            
            // limit per page parameter is set to 10, so if total posts are 150 then pages will be 15
            self.totalPages = response.total / limitPerPage
        }catch{
            self.hasError = true
            if let networkingError = error as? NetworkManager.NetworkingError {
                self.error = networkingError
            } else {
                self.error = .custom(error: error)
            }
        }
    }
    
    // for pagination
    @MainActor
    func fetchNextPostsPage() async{
        guard page != totalPages else{return}
        viewState = .fetching
        
        defer{viewState = .finished}
        // must increment the skipPageIndex variable in order not to fetch the same page elements again
        skipPageIndex = page * limitPerPage
        page = page + 1
        
        do{
            let response = try await NetworkManager.shared.request(.posts(limit: limitPerPage, skip: skipPageIndex), ofType: PostModel.self)
            self.posts += response.posts
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
    
    func hasRechedEnd(of post: Post) -> Bool{
        return posts.last?.id == post.id
    }
}

extension PostsViewModel{
    enum ViewState{
        case fetching
        case loading
        case finished
    }
}


extension PostsViewModel{
    func reset(){
        if viewState == .finished{
            posts.removeAll()
            page = 1
            totalPages = nil
            viewState = nil
        }
    }
}
