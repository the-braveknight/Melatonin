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
    private let service = Service()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [User.self, Post.self, Todo.self])
        .environment(\.service, service)
        .environment(\.handleError, HandleErrorAction(action: handle))
    }
    
    private func handle(error: Error) {
        print("Handling Error from ExampleApp: ", error)
    }
}
