//
//  ToggleTodoIntent.swift
//  Example
//
//  Created by Zaid Rahhawi on 27/06/2024.
//

import AppIntents
import SwiftData
import SwiftUI

struct ToggleTodoIntent: AppIntent {
    static let title: LocalizedStringResource = "Toggle Todo"
    static let openAppWhenRun: Bool = true
    
    @Parameter(title: "Todo") var todo: TodoEntity
    
    @Dependency private var modelContainer: ModelContainer
    @Dependency private var router: Router
    
    static var parameterSummary: some ParameterSummary {
        Summary("Todo \(\.$todo)")
    }
    
    @MainActor
    func perform() async throws -> some IntentResult {
        let id = todo.id
        let predicate = #Predicate<Todo> { $0.id == id }
        let fetchDescriptor = FetchDescriptor(predicate: predicate)
        let query = try modelContainer.mainContext.fetch(fetchDescriptor)
        
        if let todo = query.first {
            todo.isCompleted.toggle()
            try modelContainer.mainContext.save()
        }
        
        router.currentTab = .todos
        
        return .result()
    }
}
