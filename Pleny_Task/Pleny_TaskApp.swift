//
//  Pleny_TaskApp.swift
//  Pleny_Task
//
//  Created by abdrahman on 16/03/2023.
//

import SwiftUI

@main
struct Pleny_TaskApp: App {
    @StateObject var loginVM = LoginViewModel()
    @StateObject var authentication = Authentication()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authentication)
//            if authentication.isValidated{
//                    ContentView()
//                    .navigationBarHidden(false)
//                        .environmentObject(authentication)
//            }else{
//                LoginView(viewModel: LoginViewModel())
//                    .environmentObject(authentication)
//            }
            
        }
    }
}
