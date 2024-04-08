//
//  UserAgent.swift
//
//
//  Created by Zaid Rahhawi on 4/9/24.
//

import Foundation

public struct UserAgent: HeaderKey, HTTPHeader {
    public static let field: String = "User-Agent"
    public typealias Value = String
    
    public let agent: String
    
    public init(_ agent: String) {
        self.agent = agent
    }
    
    public var field: String {
        Self.field
    }
    
    public var value: String {
        agent.headerValue
    }
}

public extension HeaderValues {
    var userAgent: UserAgent.Type {
        UserAgent.self
    }
}
