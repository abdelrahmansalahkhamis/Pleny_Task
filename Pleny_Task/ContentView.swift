////
//  ContentView.swift
//  Pleny_Task
//
//  Created by abdrahman on 16/03/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var showingSheet = false
    @EnvironmentObject var vm: LoginViewModel
    @AppStorage("loginStatus") private var loginStatus = false
    var body: some View {
        NavigationView {
            TabView {
                PostsView()
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
        
//        NavigationView {
//            Button(action: {
//                self.showingSheet = true
//            }, label: {
//                Text("Show Login")
//            })
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//            }
//
//        }.sheet(isPresented: $showingSheet) {
//            //LoginView(viewModel: LoginViewModel())
//            PostsView()
//        }
    }
}
