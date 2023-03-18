//
//  PostCell.swift
//  Pleny_Task
//
//  Created by Abdelrahman Salah on 17/03/2023.
//

import SwiftUI

struct PostCell: View{
    let post: Post
    var body: some View{
        VStack {
            Divider()
            HStack {
                Image("profile").cornerRadius(10)
                VStack(alignment: .leading) {
                    Text("Ahmed Saad").font(.system(size: 17)).foregroundColor(Color(hex: 0x1D2939))
                    Text("2 sec ago").font(.system(size: 13)).foregroundColor(Color(hex: 0x475467))
                }
                Spacer()
                Image("Vector")
            }
            Text(post.body)
            Image("postImage")
        }
    }
}
