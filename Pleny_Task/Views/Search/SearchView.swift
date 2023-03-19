//
//  SearchView.swift
//  Pleny_Task
//
//  Created by Abdelrahman Salah on 18/03/2023.
//

import SwiftUI
struct SearchView: View {
    var dismissSearchView: ()->()
    @State var isEditing: Bool = false
    @State private var searchText = ""
    @StateObject var vm = SearchViewModel()
    
    let columns = [
            GridItem(.flexible())
        ]
    var body: some View {
        VStack {
            HStack(spacing: 5) {
                Image("searchTextField")
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 20, height: 20)
                    .padding()
                TextField("Search ...", text: $searchText)
                    .frame(height: 45)
                    .padding([.leading, .trailing], 3)
                    
                    Button {
                        self.isEditing = false
                        self.searchText = ""
                        self.dismissSearchView()
                    } label: {
                        Image("emptyText")
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 20, height: 20)
                    }.padding()
                
            }
                .overlay(RoundedRectangle(cornerRadius: 5)
                    .stroke(Color(hex: 0xD0D5DD), lineWidth: 1)
                    .foregroundColor(.clear))
            ZStack {
                if vm.isLoading{
                    ProgressView()
                }else{
                    ScrollView {
                        LazyVGrid(columns: columns) {
                            ForEach(vm.searchedPosts, id: \.id) { post in
                                PostCell(post: post)
                                    .task {
                                        if vm.hasRechedEnd(of: post) && !vm.isFetching{
                                            await vm.search(text: searchText)
                                        }
                                    }
                            }
                        }.padding(.all)
                            .onChange(of: searchText) { newValue in
                                async{
                                    if !newValue.isEmpty && newValue.count > 3{
                                        await vm.search(text: newValue)
                                    }
                                }
                            }
                    }.overlay(alignment: .bottom, content: {
                        if vm.isFetching{
                            ProgressView()
                        }
                    })
                }
            }
            Spacer()
        }.padding()
            .navigationBarBackButtonHidden(true)

    }
}
