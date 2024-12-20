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

public struct SchemeModifier: HTTPCallModifier {
    public let scheme: Scheme
    
    public init(scheme: Scheme) {
        self.scheme = scheme
    }
    
    public func build(_ request: inout URLRequest) {
        guard let url = request.url, var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return
        }
        
        components.scheme = scheme.rawValue
        
        request.url = components.url
    }
}

public extension Scheme {
    static let http: Self = "http"
    static let https: Self = "https"
    static let ws: Self = "ws"
    static let wss: Self = "wss"
}

public extension HTTPCall {
    func scheme(_ scheme: Scheme) -> ModifiedHTTPCall<Self, SchemeModifier> {
        modifier(SchemeModifier(scheme: scheme))
    }
}
