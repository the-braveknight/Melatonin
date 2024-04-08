//
//  TodosView.swift
//  NetworkingIdeas
//
//  Created by Zaid Rahhawi on 4/8/24.
//

import SwiftUI

struct TodoRow: View {
    let todo: Todo
    
    var body: some View {
        HStack {
            Image(systemName: todo.status == .completed ? "checkmark.circle.fill" : "circle")
            Text(todo.title)
        }
        .font(.headline)
    }
}

struct TodosView: View {
    @State private var status: Todo.Status? = nil
    
    var body: some View {
        GoRESTPaginatedView { page, query in
            TodosEndpoint(page: page, recordsPerPage: 10, title: query)
        } row: { todo in
            TodoRow(todo: todo)
        }
        .navigationTitle("Todos")
    }
}

#Preview {
    NavigationStack {
        TodosView()
    }
}
