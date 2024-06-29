//
//  Router.swift
//  Example
//
//  Created by Zaid Rahhawi on 27/06/2024.
//

import SwiftUI
import Dopamine

@Observable
@MainActor
class Router: Dopamine.Router, Sendable {
    enum Tab: String, CaseIterable {
        case users, posts, todos
    }
    
    enum Route: Hashable, Identifiable {
        case user(User)
        case post(Post)
        case todo(Todo)
        
        var id: Int { hashValue }
    }
    
    var currentTab: Tab = .users
    var currentSheet: Route?
    var navigationPath: [Tab: NavigationPath] = [:]
        
    var usersPath: NavigationPath {
        get { navigationPath[.users] ?? NavigationPath() }
        set { navigationPath[.users] = newValue }
    }
    
    var postsPath: NavigationPath {
        get { navigationPath[.posts] ?? NavigationPath() }
        set { navigationPath[.posts] = newValue }
    }
    
    var todosPath: NavigationPath {
        get { navigationPath[.todos] ?? NavigationPath() }
        set { navigationPath[.todos] = newValue }
    }
    
    func preferredTab(for route: Route) -> Tab {
        switch route {
        case .user: .users
        case .post: .posts
        case .todo: .todos
        }
    }
    
    func makeView(for route: Route, mode: RoutingMode) -> some View {
        switch route {
        case .user(let user):
            UserRow(user: user)
        case .post(let post):
            PostRow(post: post)
        case .todo(let todo):
            TodoRow(todo: todo)
        }
    }
}
