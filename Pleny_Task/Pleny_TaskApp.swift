//
//  Pleny_TaskApp.swift
//  Pleny_Task
//
//  Created by abdrahman on 16/03/2023.
//

import SwiftUI

@main
struct Pleny_TaskApp: App {
    @StateObject var authentication = Authentication()

    var body: some Scene {
        WindowGroup {
            if #available(iOS 16.0, *) {
                CoordinatorView()
                    .environmentObject(authentication)
            } else {
                // Fallback on earlier versions
            }
            
        }
    }
}
