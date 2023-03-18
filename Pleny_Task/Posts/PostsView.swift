//
//  PostsView.swift
//  Pleny_Task
//
//  Created by Abdelrahman Salah on 17/03/2023.
//

import SwiftUI

struct PostsView: View{
    init(){
            let appearance = UINavigationBarAppearance()
                appearance.shadowColor = .lightGray
                UINavigationBar.appearance().standardAppearance = appearance
                UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
    let posts: [Post] = [
        Post(id: 1, title: "His mother had always taught him", body: "His mother had always taught him not to ever think of himself as better than others. He'd tried to live by this motto. He never looked down on those who were less fortunate or who had less money than him. But the stupidity of the group of people he was talking to made him change his mind.", userID: 1, tags: [], reactions: 5),
        Post(id: 2, title: "His mother had always taught him", body: "He was an expert but not in a discipline that anyone could fully appreciate. He knew how to hold the cone just right so that the soft server ice-cream fell into it at the precise angle to form a perfect cone each and every time. It had taken years to perfect and he could now do it without even putting any thought behind it.", userID: 2, tags: [], reactions: 13),
        Post(id: 3, title: "His mother had always taught him", body: "Dave watched as the forest burned up on the hill, only a few miles from her house. The car had been hastily packed and Marta was inside trying to round up the last of the pets. Dave went through his mental list of the most important papers and documents that they couldn't leave behind. He scolded himself for not having prepared these better in advance and hoped that he had remembered everything that was needed. He continued to wait for Marta to appear with the pets, but she still was nowhere to be seen.", userID: 3, tags: [], reactions: 8),
        Post(id: 4, title: "His mother had always taught him", body: "All he wanted was a candy bar. It didn't seem like a difficult request to comprehend, but the clerk remained frozen and didn't seem to want to honor the request. It might have had something to do with the gun pointed at his face.", userID: 4, tags: [], reactions: 3),
        Post(id: 5, title: "His mother had always taught him", body: "Hopes and dreams were dashed that day. It should have been expected, but it still came as a shock. The warning signs had been ignored in favor of the possibility, however remote, that it could actually happen. That possibility had grown from hope to an undeniable belief it must be destiny. That was until it wasn't and the hopes and dreams came crashing down.", userID: 5, tags: [], reactions: 9),
        Post(id: 6, title: "His mother had always taught him", body: "Dave wasn't exactly sure how he had ended up in this predicament. He ran through all the events that had lead to this current situation and it still didn't make sense. He wanted to spend some time to try and make sense of it all, but he had higher priorities at the moment. The first was how to get out of his current situation of being naked in a tree with snow falling all around and no way for him to get down.", userID: 6, tags: [], reactions: 31)
    ]
    let columns = [
            GridItem(.flexible())
        ]
    @StateObject var vm = PostsViewModel()
    var body: some View{
        NavigationView {
            ZStack {
                if vm.isLoading{
                    ProgressView()
                }else{
                    ScrollView {
                        LazyVGrid(columns: columns) {
//                            ForEach(posts, id: \.id) { post in
//                                PostCell(post: post)
//                            }
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
            
        }
    }
}

struct Animal: Hashable {
    var uniqueID : Int
    var name: String
}
