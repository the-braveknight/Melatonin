//
//  ContentView.swift
//  Example
//
//  Created by Zaid Rahhawi on 4/8/24.
//

import SwiftUI

struct ContentView: View {
    private enum Tab: String {
        case users, posts, todos
    }
    
    @State private var currentTab: Tab = .users
    
    var body: some View {
        TabView(selection: $currentTab) {
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
}
