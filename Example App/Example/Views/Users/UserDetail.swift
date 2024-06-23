//
//  UserDetail.swift
//  Example
//
//  Created by Zaid Rahhawi on 23/06/2024.
//

import SwiftUI
import SwiftData

struct UserDetail: View {
    var user: User
    
    @Query private var posts: [Post]
    @Query private var todos: [Todo]
    
    init(user: User) {
        self.user = user
        let userID = user.id
        
        let postPredicate = #Predicate<Post> { $0.user == userID }
        self._posts = Query(filter: postPredicate)
        
        let todoPredicate = #Predicate<Todo> { $0.user == userID }
        self._todos = Query(filter: todoPredicate)
    }
    
    var body: some View {
        List {
            if !posts.isEmpty {
                Section("Posts") {
                    ForEach(posts) { post in
                        PostRow(post: post)
                    }
                }
            }
            
            if !todos.isEmpty {
                Section("Todos") {
                    ForEach(todos) { todo in
                        TodoRow(todo: todo)
                    }
                }
            }
        }
        .navigationTitle(user.name)
        .overlay {
            if posts.isEmpty && todos.isEmpty {
                ContentUnavailableView {
                    Label("No Posts", systemImage: "doc.richtext")
                } description: {
                    Text("No Posts were found for \(user.name).")
                }
            }
        }
    }
}
