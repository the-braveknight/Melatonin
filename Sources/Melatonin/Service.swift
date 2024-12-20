//
//  Service.swift
//  Melatonin
//
//  Created by Zaid Rahhawi on 12/19/24.
//

import Foundation

public protocol Service: Actor {
    var session: URLSession { get }
    func load<E: Endpoint>(_ endpoint: E) async throws -> (Data, HTTPURLResponse)
}

public extension Service {
    func load<E: Endpoint>(_ endpoint: E) async throws -> (Data, HTTPURLResponse) {
        let request = endpoint.call.build()
        let (data, response) = try await session.data(for: request)
        guard let response = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        return (data, response)
    }
}
