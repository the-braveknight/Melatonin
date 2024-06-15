//
//  TodosView.swift
//  NetworkingIdeas
//
//  Created by Zaid Rahhawi on 4/8/24.
//

import SwiftUI

struct TodoRow: View {
    @Bindable var todo: Todo
    
    var body: some View {
        HStack {
            Toggle("", isOn: $todo.isCompleted)
                .toggleStyle(.checkmark)
                .font(.title2)
                .foregroundStyle(.blue)
            
            Text(todo.title)
                .lineLimit(2)
        }
        .font(.headline)
    }
}

struct TodosView: View {    
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
