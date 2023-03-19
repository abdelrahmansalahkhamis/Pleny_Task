////
//  ContentView.swift
//  Pleny_Task
//
//  Created by abdrahman on 16/03/2023.
//

import SwiftUI
import CoreData

@available(iOS 16.0, *)
struct ContentView: View {
    @State private var showingSheet = false
    @EnvironmentObject var vm: LoginViewModel
    @EnvironmentObject var coordinator: Coordinator
    @AppStorage("loginStatus") private var loginStatus = false
    var body: some View {
        TabView {
            PostsView()
                .environmentObject(coordinator)
                .tabItem {
                    Image("tab1")
                }
            Tab2()
                .tabItem {
                    Image("tab2")
                }
            Tab3()
                .tabItem {
                    Image("tab3")
                }
            Tab4()
                .tabItem {
                    Image("tab4")
                }
            Tab5()
                .tabItem {
                    Image("tab5")
                }
        }
    }
}
