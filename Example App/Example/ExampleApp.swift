//
//  ExampleApp.swift
//  Example
//
//  Created by Zaid Rahhawi on 4/8/24.
//

import SwiftUI
import SwiftData

@main
struct ExampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [User.self, Post.self, Todo.self])
    }
}
