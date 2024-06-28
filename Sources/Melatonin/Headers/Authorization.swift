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
    
    public init(_ authorization: Value) {
        self.authorization = authorization
    }
    
    public var field: String {
        Self.field
    }
    
    public var value: String {
        authorization.headerValue
    }
}

public struct Authorization: HeaderValue {
    public let headerValue: String
    
    public init(_ headerValue: String) {
        self.headerValue = headerValue
    }
    
    public static func bearer(token: String) -> Authorization {
        Authorization("Bearer \(token)")
    }
    
    public static func basic(string: String) -> Authorization {
        Authorization("Basic \(string)")
    }
    
    public static func clientID(accessKey: String) -> Authorization {
        Authorization("Client-ID \(accessKey)")
    }
}

public extension HeaderValues {
    var auth: Auth.Type {
        Auth.self
    }
}
