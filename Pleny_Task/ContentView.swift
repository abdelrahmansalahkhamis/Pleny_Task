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
    var body: some View {
        NavigationView {
            Button(action: {
                self.showingSheet = true
            }, label: {
                Text("Show Login")
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
            
        }.sheet(isPresented: $showingSheet) {
            //LoginView(viewModel: LoginViewModel())
            PostsView()
        }
    }
}
