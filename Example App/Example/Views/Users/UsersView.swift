//
//  UsersView.swift
//  NetworkingIdeas
//
//  Created by Zaid Rahhawi on 4/7/24.
//

import SwiftUI
import SwiftData
import Melatonin

struct UsersView: View {
    // MARK: - SwiftData
    @Query(sort: \User.id, order: .reverse) private var users: [User]
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
            ForEach(users) { user in
                UserRow(user: user)
                    .task {
                        if user.id == users.last?.id {
                            await loadMore()
                        }
                    }
            }
        }
        .navigationTitle("Users")
        .task {
            await loadUsers()
        }
        .refreshable {
            await loadUsers()
        }
    }
    
    private func loadUsers() async {
        guard !isLoading else { return }
        
        isLoading = true
        defer { isLoading = false }
        
        do {
            let response = try await service.load(.users())
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
            let response = try await service.load(.users(page: nextPage))
            try handle(response: response)
        } catch {
            handle(error)
        }
    }
    
    private func handle(response: UsersEndpoint.Response) throws {
        // MARK: - Update Data
        response.records.forEach { modelContext.insert($0) }
        
        if modelContext.hasChanges {
            try modelContext.save()
        }
        
        // MARK: - Update Pagination
        // Dynamically determine the current page based on persisted records.
        let currentPage = (users.count / response.pagination.recordsPerPage) + 1
        self.pagination = Pagination(totalCount: response.pagination.totalCount, totalPages: response.pagination.totalPages, recordsPerPage: response.pagination.recordsPerPage, currentPage: currentPage)
    }
}

#Preview {
    NavigationStack {
        UsersView()
    }.modelContainer(for: User.self, inMemory: true)
}
