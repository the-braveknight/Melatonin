//
//  HTTPMethodModifier.swift
//
//
//  Created by Zaid Rahhawi on 8/13/22.
//

import Foundation

public struct HTTPMethodModifier: HTTPCallModifier {
    public let method: HTTPMethod
    
    public init(method: HTTPMethod) {
        self.method = method
    }
    
    public func build(_ request: inout URLRequest) {
        request.httpMethod = method.value
    }
}

public struct HTTPMethod: ExpressibleByStringLiteral, Sendable {
    let value: String
    
    init(_ value: String) {
        self.value = value
    }
    
    public init(stringLiteral value: String) {
        self.init(value)
    }
}

public extension HTTPMethod {
    static let get: Self = "GET"
    static let post: Self = "POST"
    static let put: Self = "PUT"
    static let patch: Self = "PATCH"
    static let delete: Self = "DELETE"
    static let head: Self = "HEAD"
    static let connect: Self = "CONNECT"
    static let trace: Self = "TRACE"
    static let options: Self = "OPTIONS"
}

public extension HTTPCall {
    func method(_ method: HTTPMethod) -> ModifiedHTTPCall<Self, HTTPMethodModifier> {
        modifier(HTTPMethodModifier(method: method))
    }
}
