//
//  ContentLength.swift
//  
//
//  Created by Zaid Rahhawi on 2/25/23.
//

import Foundation

public struct ContentLength : HeaderKey, HTTPHeader {
    public static let field: String = "Content-Length"
    public typealias Value = Int
    
    let contentLength: Value
    
    public init(_ contentLength: Value) {
        self.contentLength = contentLength
    }
    
    public var field: String {
        Self.field
    }
    
    public var value: String {
        contentLength.headerValue
    }
}

extension Int : HeaderValue {
    public var headerValue: String {
        String(self)
    }
}

public extension HeaderValues {
    var contentLength: ContentLength.Type {
        ContentLength.self
    }
}
