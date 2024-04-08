//
//  Service.swift
//  NetworkingIdeas
//
//  Created by Zaid Rahhawi on 4/8/24.
//

import Foundation
import Melatonin

actor Service {
    let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    init() {
        self.init(session: .shared)
    }
    
    func load<E: Endpoint>(_ endpoint: E) async throws -> E.Response {
        try await session.load(endpoint)
    }
}
