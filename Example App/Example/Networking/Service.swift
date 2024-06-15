//
//  Service.swift
//  NetworkingIdeas
//
//  Created by Zaid Rahhawi on 4/8/24.
//

import SwiftUI
import Melatonin

actor Service {
    private let session: URLSession = {
        let urlCache = URLCache(memoryCapacity: 20 * 1024 * 1024, diskCapacity: 100 * 1024 * 1024, diskPath: "ClientCache")
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        configuration.urlCache = urlCache
        let session = URLSession(configuration: configuration)
        return session
    }()
    
    func load<E: Endpoint>(_ endpoint: E) async throws -> E.Response {
        try await session.load(endpoint)
    }
}

private struct ServiceKey: EnvironmentKey {
    static let defaultValue = Service()
}

extension EnvironmentValues {
    var service: Service {
        get { self[ServiceKey.self] }
        set { self[ServiceKey.self] = newValue }
    }
}
