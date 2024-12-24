//
//  ContentView.swift
//  Example
//
//  Created by Zaid Rahhawi on 4/8/24.
//

import SwiftUI
import Dopamine

struct ContentView: View {
    @Environment(Router.self) var router: Router
    
    var body: some View {
        @Bindable var router = router
        
        TabView(selection: $router.currentTab) {
            NavigationStack(path: $router.usersPath) {
                UsersView()
                    .withRouterDestinations(router)
            }
            .tabItem { Label("Users", systemImage: "person.3") }
            .tag(Router.Tab.users)
            
            NavigationStack(path: $router.postsPath) {
                PostsView()
                    .withRouterDestinations(router)
            }
            .tabItem { Label("Posts", systemImage: "doc.text") }
            .tag(Router.Tab.posts)
            
            NavigationStack(path: $router.todosPath) {
                TodosView()
                    .withRouterDestinations(router)
            }
            .tabItem { Label("Todos", systemImage: "list.bullet") }
            .tag(Router.Tab.todos)
        }
        .withRouterSheets(router)
    }
}

#Preview {
    ContentView()
        .environment(Router())
        .modelContainer(for: [User.self, Post.self, Todo.self], inMemory: true)
        .environment(\.service, MockGoRESTService())
}
