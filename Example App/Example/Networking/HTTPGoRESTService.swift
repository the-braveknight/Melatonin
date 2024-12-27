//
//  APIService.swift
//  NetworkingIdeas
//
//  Created by Zaid Rahhawi on 4/8/24.
//

import SwiftUI
import Melatonin

actor HTTPGoRESTService: HTTPService, GoRESTService {
    let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func loadPosts(page: Int) async throws -> PaginatedResponse<Post> {
        let endpoint = GetPosts(page: page)
        let call = endpoint.call
        let (data, response) = try await load(call)
        let pagination = try PaginationMetadata(from: response)
        let decoder = JSONDecoder()
        let photos = try decoder.decode([Post].self, from: data)
        return PaginatedResponse(items: photos, pagination: pagination)
    }
    
    func loadTodos(page: Int) async throws -> PaginatedResponse<Todo> {
        let endpoint = GetTodos(page: page)
        let call = endpoint.call
        let (data, response) = try await load(call)
        let pagination = try PaginationMetadata(from: response)
        let decoder = JSONDecoder()
        
        // Assign the custom formatter to the decoder
        decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)
            // Use a custom ISO8601 formatter to handle fractional seconds and time zone offsets
            let iso8601Formatter = ISO8601DateFormatter()
            iso8601Formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
            
            guard let date = iso8601Formatter.date(from: dateString) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "Invalid date format: \(dateString)"
                    )
                )
            }
            return date
        }
        let photos = try decoder.decode([Todo].self, from: data)
        return PaginatedResponse(items: photos, pagination: pagination)
    }
    
    func loadUsers(page: Int) async throws -> PaginatedResponse<User> {
        let endpoint = GetUsers(page: page)
        let call = endpoint.call
        let (data, response) = try await load(call)
        let pagination = try PaginationMetadata(from: response)
        let decoder = JSONDecoder()
        let photos = try decoder.decode([User].self, from: data)
        return PaginatedResponse(items: photos, pagination: pagination)
    }
}
