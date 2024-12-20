//
//  UserAgent.swift
//
//
//  Created by Zaid Rahhawi on 4/9/24.
//

import Foundation

public struct UserAgent: HTTPHeader {
    public let field: String = "User-Agent"
    public let agent: String
    
    public var value: String {
        agent
    }
    
    public init(_ agent: String) {
        self.agent = agent
    }
}

public extension HTTPCall {
    func userAgent(_ agent: String) -> ModifiedHTTPCall<Self, UserAgent> {
        modifier(UserAgent(agent))
    }
}
