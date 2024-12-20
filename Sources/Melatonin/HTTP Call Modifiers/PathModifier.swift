//
//  PathModifier.swift
//  Melatonin
//
//  Created by Zaid Rahhawi on 12/19/24.
//

import Foundation

public struct PathModifier: HTTPCallModifier {
    public let path: String
    
    public init(path: String) {
        self.path = path
    }
    
    public func build(_ request: inout URLRequest) {
        if #available(macOS 13, iOS 16, tvOS 16, watchOS 9, *) {
            request.url?.append(path: path)
        } else {
            request.url?.appendPathComponent(path)
        }
    }
}

public extension HTTPCall {
    func path(_ path: String) -> ModifiedHTTPCall<Self, PathModifier> {
        modifier(PathModifier(path: path))
    }
}
