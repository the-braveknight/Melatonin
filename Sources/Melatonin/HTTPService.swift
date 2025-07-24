//
//  HTTPService.swift
//  Melatonin
//
//  Created by Zaid Rahhawi on 12/19/24.
//

import Foundation

public protocol HTTPService: Sendable {
    var session: URLSession { get }
    var headers: [any HTTPHeader] { get }
    func load<Call: HTTPCall>(_ call: Call) async throws -> (Data, HTTPURLResponse)
}

public extension HTTPService {
    var headers: [any HTTPHeader] {
        return []
    }
}

public extension HTTPService {
    func load<Call: HTTPCall>(_ call: Call) async throws -> (Data, HTTPURLResponse) {
        let call = call.modifier(HeadersModifier(headers: headers))
        let request = call.build()
        let (data, response) = try await session.data(for: request)
        guard let response = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        return (data, response)
    }
}
