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
    @Query(sort: \Post.id, order: .reverse, animation: .default) private var posts: [Post]
    @Environment(\.modelContext) private var modelContext: ModelContext
    
    // MARK: - Environment Variables
    @Environment(\.service) private var service: Service
    @Environment(\.handleError) private var handle
    
    // MARK: - Pagination
    @State private var pagination: Pagination? = nil
    @State private var isLoading: Bool = false
    
    // MARK: - Navigation Path
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        List {
            ForEach(posts) { post in
                PostRow(post: post)
                    .task {
                        if post.id == posts.last?.id {
                            await loadMorePosts()
                        }
                    }
            }
        }
        .navigationTitle("Posts")
        .task {
            await loadInitialPosts()
        }
        .refreshable {
            await loadInitialPosts()
        }
    }
    
    private func loadInitialPosts() async {
        await loadPosts(page: 1)
    }
    
    private func loadMorePosts() async {
        guard let nextPage = pagination?.nextPage else { return }
        await loadPosts(page: nextPage)
    }
    
    private func loadPosts(page: Int) async {
        guard !isLoading else { return }
        
        isLoading = true
        defer { isLoading = false }
        
        do {
            let response = try await service.load(.posts(page: page))
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

