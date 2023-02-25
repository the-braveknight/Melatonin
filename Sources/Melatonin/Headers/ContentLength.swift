//
//  ContentLength.swift
//  
//
//  Created by Zaid Rahhawi on 2/25/23.
//

import Foundation

public struct ContentLength : HeaderKey {
    public static let field: String = "Content-Length"
    public typealias Value = Int
}

extension Int : HeaderValue {
    public var value: String {
        String(self)
    }
}

public extension HeaderValues {
    var contentLength: ContentLength.Type {
        ContentLength.self
    }
}
