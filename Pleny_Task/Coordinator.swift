//
//  Coordinator.swift
//  Pleny_Task
//
//  Created by Abdelrahman Salah on 19/03/2023.
//

import SwiftUI

enum Page: String, Identifiable{
    case login
    var id: String{
        return self.rawValue
    }
}

enum FullScreenCover: String, Identifiable{
    case tabView
    case search
    var id: String{
        return self.rawValue
    }
}
@available(iOS 16.0, *)
class Coordinator: ObservableObject{
    @StateObject var authentication = Authentication()
    @Published var path = NavigationPath()
    @Published var fullScreenCover: FullScreenCover?
    @Published var isFullScreenPresented: Bool = false
    func present(fullScreenCover: FullScreenCover){
        self.fullScreenCover = fullScreenCover
    }
    
    func dismissFullScreenCover(){
        self.fullScreenCover = nil
    }
    
    @ViewBuilder
    func build(fullScreenCover: FullScreenCover) -> some View{
        switch fullScreenCover {
        case .search:
            NavigationStack{
                SearchView{
                    self.dismissFullScreenCover()
                    self.isFullScreenPresented = false
                }
            }
            
        case .tabView:
            //NavigationStack{
                ContentView()
            //}.toolbarBackground(.teal)
        }
    }
    
    @ViewBuilder
    func build(page: Page) -> some View{
        switch page {
            //        case .tabView:
            //            ContentView()
        case .login:
            LoginView(viewModel: LoginViewModel())
                .environmentObject(authentication)
        }
    }
}
