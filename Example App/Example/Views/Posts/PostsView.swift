//
//  PostsView.swift
//  NetworkingIdeas
//
//  Created by Zaid Rahhawi on 4/7/24.
//

import SwiftUI
import SwiftData
import Melatonin

struct PostsView: View {
    // MARK: - SwiftData
    @Query(sort: \Post.id, order: .reverse) private var posts: [Post]
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
            ForEach(posts) { post in
                PostRow(post: post)
                    .task {
                        if post.id == posts.last?.id {
                            await loadMore()
                        }
                    }
            }
        }
        .navigationTitle("Posts")
        .task {
            await loadPosts()
        }
        .refreshable {
            await loadPosts()
        }
    }
    
    private func loadPosts() async {
        guard !isLoading else { return }
        
        isLoading = true
        defer { isLoading = false }
        
        do {
            let response = try await service.load(.posts())
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
            let response = try await service.load(.posts(page: nextPage))
            try handle(response: response)
        } catch {
            handle(error)
        }
    }
    
    private func handle(response: PostsEndpoint.Response) throws {
        // MARK: - Update Data
        response.records.forEach { modelContext.insert($0) }
        
        if modelContext.hasChanges {
            try modelContext.save()
        }
        
        // MARK: - Update Pagination
        // Dynamically determine the current page based on persisted records.
        let currentPage = (posts.count / response.pagination.recordsPerPage) + 1
        self.pagination = Pagination(totalCount: response.pagination.totalCount, totalPages: response.pagination.totalPages, recordsPerPage: response.pagination.recordsPerPage, currentPage: currentPage)
    }
}

#Preview {
    NavigationStack {
        PostsView()
    }.modelContainer(for: Post.self, inMemory: true)
}

