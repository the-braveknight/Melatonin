//
//  HTTPService.swift
//  Melatonin
//
//  Created by Zaid Rahhawi on 12/19/24.
//

import Foundation

public protocol HTTPService: Actor {
    var session: URLSession { get }
    func load<Call: HTTPCall>(_ call: Call) async throws -> (Data, HTTPURLResponse)
}

public extension HTTPService {
    func load<Call: HTTPCall>(_ call: Call) async throws -> (Data, HTTPURLResponse) {
        let request = call.build()
        let (data, response) = try await session.data(for: request)
        guard let response = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        return (data, response)
    }
}
