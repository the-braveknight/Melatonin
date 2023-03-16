//
//  ContentType.swift
//  
//
//  Created by Zaid Rahhawi on 2/25/23.
//

import Foundation

public struct ContentType: HeaderKey, HTTPHeader {
    public static let field: String = "Content-Type"
    public typealias Value = MIMEType
    
    let mimeType: Value
    
    public init(_ mimeType: Value) {
        self.mimeType = mimeType
    }
    
    public var field: String {
        Self.field
    }
    
    public var value: String {
        mimeType.headerValue
    }
}

public extension HeaderValues {
    var contentType: ContentType.Type {
        ContentType.self
    }
}
