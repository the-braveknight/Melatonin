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
    @Query(sort: \User.id, order: .reverse, animation: .default) private var users: [User]
    @Environment(\.modelContext) private var modelContext: ModelContext
    
    // MARK: - Environment Variables
    @Environment(\.service) private var service: Service
    @Environment(\.handleError) private var handle
    
    // MARK: - Pagination
    @State private var pagination: Pagination? = nil
    @State private var isLoading: Bool = false
    
    var body: some View {
        List {
            ForEach(users) { user in
                UserRow(user: user)
                    .task {
                        if user.id == users.last?.id {
                            await loadMoreUsers()
                        }
                    }
            }
        }
        .navigationTitle("Users")
        .task {
            await loadInitialUsers()
        }
        .refreshable {
            await loadInitialUsers()
        }
    }
    
    private func loadInitialUsers() async {
        await loadUsers(page: 1)
    }
    
    private func loadMoreUsers() async {
        guard let nextPage = pagination?.nextPage else { return }
        await loadUsers(page: nextPage)
    }
    
    private func loadUsers(page: Int) async {
        guard !isLoading else { return }
        
        isLoading = true
        defer { isLoading = false }
        
        do {
            let response = try await service.load(.users(page: page))
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
