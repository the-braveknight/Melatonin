//
//  MockGoRESTService.swift
//  Example
//
//  Created by Zaid Rahhawi on 12/24/24.
//

import Foundation

struct MockGoRESTService: GoRESTService {
    func loadPosts(page: Int) async throws -> PaginatedResponse<Post> {
        try await Task.sleep(for: .milliseconds(500))
        return paginatedResponse(items: Post.examples, page: page, recordsPerPage: 10)
    }
    
    func loadTodos(page: Int) async throws -> PaginatedResponse<Todo> {
        try await Task.sleep(for: .milliseconds(500))
        return paginatedResponse(items: Todo.examples, page: page, recordsPerPage: 10)
    }
    
    func loadUsers(page: Int) async throws -> PaginatedResponse<User> {
        try await Task.sleep(for: .milliseconds(500))
        return paginatedResponse(items: User.examples, page: page, recordsPerPage: 10)
    }
    
    private func paginatedResponse<Item>(items: [Item], page: Int, recordsPerPage: Int) -> PaginatedResponse<Item> {
        let totalCount = items.count
        let totalPages = Int(ceil(Double(totalCount) / Double(recordsPerPage)))
        let pageItems = items[(page - 1) * recordsPerPage ..< page * recordsPerPage]
        return PaginatedResponse(items: Array(pageItems), pagination: PaginationMetadata(totalCount: totalCount, totalPages: totalPages, recordsPerPage: recordsPerPage, currentPage: page))
    }
}

private extension User {
    static let examples: [User] = [
        User(id: 1, name: "Zaid Rahhawi", email: "zaid@example.com", gender: .male, status: .active),
        User(id: 2, name: "John Doe", email: "john@example.com", gender: .male, status: .active),
        User(id: 3, name: "Jane Doe", email: "jane@example.com", gender: .female, status: .active),
        User(id: 4, name: "Samantha Doe", email: "samantha@example.com", gender: .female, status: .active),
        User(id: 5, name: "Max Mustermann", email: "max@mustermann.com", gender: .male, status: .active),
        User(id: 6, name: "Rob Stanely", email: "rob@mustermann.com", gender: .male, status: .active),
        User(id: 7, name: "Julia Mustermann", email: "julia@mustermann.com", gender: .female, status: .active),
        User(id: 8, name: "Martha Mustermann", email: "martha@mustermann.com", gender: .female, status: .active),
        User(id: 9, name: "Tim Mustermann", email: "tim@mustermann.com", gender: .male, status: .active),
        User(id: 10, name: "Sara Mustermann", email: "sara@mustermann.com", gender: .female, status: .active),
    ]
}

private extension Post {
    static let examples: [Post] = (1 ... 100)
        .map { Post(id: $0, user: Int.random(in: 1 ... 10), title: "Post Title \($0)", body: "This is a post body for post \($0)") }
}

private extension Todo {
    static let examples: [Todo] = (1 ... 100)
        .map { Todo(id: $0, user: Int.random(in: 1 ... 10), title: "Todo Title \($0)", dueDate: .distantFuture, status: Bool.random() ? .completed : .pending) }
}
