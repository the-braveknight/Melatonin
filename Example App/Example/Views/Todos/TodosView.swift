//
//  TodosView.swift
//  NetworkingIdeas
//
//  Created by Zaid Rahhawi on 4/8/24.
//

import SwiftUI
import SwiftData
import Melatonin

struct TodosView: View {
    // MARK: - SwiftData
    @Query(sort: \Todo.id, order: .reverse) private var todos: [Todo]
    @Environment(\.modelContext) private var modelContext: ModelContext
    
    // MARK: - Service
    @Environment(\.service) private var service: Service
    @State private var isLoading: Bool = false
    
    // MARK: - Pagination
    @State private var pagination: Pagination? = nil
    
    // MARK: - Environment Variables
    @Environment(\.handleError) var handle
    
    var body: some View {
        List {
            ForEach(todos) { todo in
                TodoRow(todo: todo)
                    .task {
                        if todo.id == todos.last?.id {
                            await loadMore()
                        }
                    }
            }
        }
        .navigationTitle("Todos")
        .task {
            await loadTodos()
        }
        .refreshable {
            await loadTodos()
        }
    }
    
    private func loadTodos() async {
        guard !isLoading else { return }
        
        isLoading = true
        defer { isLoading = false }
        
        do {
            let response = try await service.load(.todos())
            try handle(response: response)
        } catch {
            handle(error)
        }
    }
    
    private func loadMore() async {
        guard !isLoading else { return }
        
        guard let nextPage = pagination?.nextPage else { return }
        
        isLoading = true
        defer { isLoading = false }
        
        do {
            let response = try await service.load(.todos(page: nextPage))
            try handle(response: response)
        } catch {
            handle(error)
        }
    }
    
    private func handle(response: TodosEndpoint.Response) throws {
        // MARK: - Update Data
        response.records.forEach { modelContext.insert($0) }
        
        if modelContext.hasChanges {
            try modelContext.save()
        }
        
        // MARK: - Update Pagination
        // Dynamically determine the current page based on persisted records.
        let currentPage = (todos.count / response.pagination.recordsPerPage) + 1
        self.pagination = Pagination(totalCount: response.pagination.totalCount, totalPages: response.pagination.totalPages, recordsPerPage: response.pagination.recordsPerPage, currentPage: currentPage)
    }
}

#Preview {
    NavigationStack {
        TodosView()
    }.modelContainer(for: Todo.self, inMemory: true)
}
