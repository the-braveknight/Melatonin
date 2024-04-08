//
//  PostsView.swift
//  NetworkingIdeas
//
//  Created by Zaid Rahhawi on 4/7/24.
//

import SwiftUI

struct PostRow: View {
    let post: Post
    
    var body: some View {
        Text(post.title)
            .font(.headline)
    }
}

struct PostsView: View {
    var body: some View {
        GoRESTPaginatedView { page, query in
            PostsEndpoint(page: page, recordsPerPage: 10, title: query)
        } row: { post in
            PostRow(post: post)
        }
        .navigationTitle("Posts")
    }
}

#Preview {
    NavigationStack {
        PostsView()
    }
}

