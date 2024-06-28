//
//  ContentView.swift
//  Example
//
//  Created by Zaid Rahhawi on 4/8/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(Router.self) var router: Router
        
    var body: some View {
        @Bindable var router = router
        
        TabView(selection: $router.currentTab) {
            NavigationStack {
                UsersView()
            }
            .tabItem { Label("Users", systemImage: "person.3") }
            .tag(Tab.users)
            
            NavigationStack {
                PostsView()
            }
            .tabItem { Label("Posts", systemImage: "doc.text") }
            .tag(Tab.posts)
            
            NavigationStack {
                TodosView()
            }
            .tabItem { Label("Todos", systemImage: "list.bullet") }
            .tag(Tab.todos)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [User.self, Post.self, Todo.self], inMemory: true)
}
