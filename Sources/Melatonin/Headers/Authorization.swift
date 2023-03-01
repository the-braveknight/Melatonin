//
//  Authorization.swift
//  
//
//  Created by Zaid Rahhawi on 2/25/23.
//

import Foundation

public struct Auth: HeaderKey, HTTPHeader {
    public static let field: String = "Authorization"
    public typealias Value = Authorization
    
    let authorization: Value
    
    init(_ authorization: Value) {
        self.authorization = authorization
    }
    
    public var field: String {
        Self.field
    }
    
    public var value: String {
        authorization.headerValue
    }
}

public enum Authorization : HeaderValue {
    case bearer(token: String)
    case basic(String)
    
    public var headerValue: String {
        switch self {
        case .bearer(let token):
            return "Bearer \(token)"
        case .basic(let string):
            return "Basic \(string)"
        }
    }
}

public extension HeaderValues {
    var auth: Auth.Type {
        Auth.self
    }
}
