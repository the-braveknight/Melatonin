//
//  HTTPMethod.swift
//  
//
//  Created by Zaid Rahhawi on 8/13/22.
//

import Foundation

public struct HTTPMethod: URLRequestComponent, ExpressibleByStringLiteral {
    let method: String
    
    init(method: String) {
        self.method = method
    }
    
    public init(stringLiteral value: String) {
        self.init(method: value)
    }
    
    public func build(_ request: inout URLRequest) {
        request.httpMethod = method
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
