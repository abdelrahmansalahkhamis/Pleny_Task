//
//  PostsView.swift
//  Pleny_Task
//
//  Created by Abdelrahman Salah on 17/03/2023.
//

import SwiftUI

struct PostsView: View{
    @State private var showingSheet = false
    let columns = [
        GridItem(.flexible())
    ]
    @State var isEditing: Bool = false
    @State private var searchText = ""
    @StateObject var vm = PostsViewModel()
    var body: some View{
        ZStack {
            if vm.isLoading{
                ProgressView()
            }else{
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(vm.posts, id: \.id) { post in
                            PostCell(post: post)
                                .task {
                                    if vm.hasRechedEnd(of: post) && !vm.isFetching{
                                        await vm.fetchNextPostsPage()
                                    }
                                }
                        }
                    }.padding(.all)
                }.overlay(alignment: .bottom, content: {
                    if vm.isFetching{
                        ProgressView()
                    }
                })
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                
                Button {
                    
                    self.showingSheet = true
                } label: {
                    Image("searchIcon")
                }
                
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Image("LOGO")
            }
        }
        .task {
            await vm.fetchPosts()
        }
        .fullScreenCover(isPresented: $showingSheet, content: {
            SearchView{
                self.showingSheet = false
            }
        })
    }
}
