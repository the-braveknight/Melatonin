//
//  Scheme.swift
//  
//
//  Created by Zaid Rahhawi on 8/13/22.
//

import Foundation

public struct Scheme: ExpressibleByStringLiteral {
    public var rawValue: String
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
    
    public init(stringLiteral value: String) {
        self.init(rawValue: value)
    }
}

public extension Scheme {
    static let http: Self = "http"
    static let https: Self = "https"
    static let ws: Self = "ws"
    static let wss: Self = "wss"
}
