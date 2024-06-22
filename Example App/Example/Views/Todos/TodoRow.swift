//
//  TodoRow.swift
//  Example
//
//  Created by Zaid Rahhawi on 22/06/2024.
//

import SwiftUI
import SwiftData

struct TodoRow: View {
    @Bindable var todo: Todo
    @Environment(\.modelContext) private var modelContext: ModelContext
    
    var body: some View {
        HStack {
            Toggle("", isOn: $todo.isCompleted)
                .toggleStyle(.checkmark)
                .font(.title2)
                .foregroundStyle(.blue)
                .onChange(of: todo.isCompleted) { oldValue, newValue in
                    try? modelContext.save()
                }
            
            Text(todo.title)
                .lineLimit(2)
        }
        .font(.headline)
    }
}
