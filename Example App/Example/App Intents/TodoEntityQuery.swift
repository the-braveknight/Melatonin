//
//  TodoEntityQuery.swift
//  Example
//
//  Created by Zaid Rahhawi on 27/06/2024.
//

import AppIntents
import SwiftData

struct TodoEntityQuery: EntityQuery {
    @Dependency private var modelContainer: ModelContainer
    
    @MainActor
    func suggestedEntities() async throws -> [TodoEntity] {
        let fetchDescriptor = FetchDescriptor<Todo>()
        return try modelContainer.mainContext.fetch(fetchDescriptor)
            .map { TodoEntity(todo: $0) }
    }
    
    @MainActor
    func entities(for identifiers: [Todo.ID]) async throws -> [TodoEntity] {
        let predicate = #Predicate<Todo> { identifiers.contains($0.id) }
        let fetchDescritor = FetchDescriptor(predicate: predicate)
        return try modelContainer.mainContext.fetch(fetchDescritor)
            .map { TodoEntity(todo: $0) }
    }
}

extension TodoEntityQuery: EnumerableEntityQuery {
    @MainActor
    func allEntities() async throws -> [TodoEntity] {
        let fetchDescriptor = FetchDescriptor<Todo>()
        return try modelContainer.mainContext.fetch(fetchDescriptor)
            .map { TodoEntity(todo: $0) }
    }
}

extension TodoEntityQuery: EntityStringQuery {
    @MainActor
    func entities(matching string: String) async throws -> [TodoEntity] {
        let predicate = #Predicate<Todo> { $0.title.localizedStandardContains(string) }
        let fetchDescriptor = FetchDescriptor(predicate: predicate)
        return try modelContainer.mainContext.fetch(fetchDescriptor)
            .map { TodoEntity(todo: $0) }
    }
}
