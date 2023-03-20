//
//  CoordinatorView.swift
//  Pleny_Task
//
//  Created by Abdelrahman Salah on 19/03/2023.
//

import SwiftUI


@available(iOS 16.0, *)
struct CoordinatorView: View{
    @StateObject  var coordinator = Coordinator()
    @StateObject var authentication = Authentication()
    var body: some View{
        NavigationStack(path: $coordinator.path) {
            coordinator.build(page: .login)
                .fullScreenCover(item: $coordinator.fullScreenCover) { fullScreenCover in
                    coordinator.build(fullScreenCover: fullScreenCover)
                }
            
        }
        .environmentObject(coordinator)
    }
}
