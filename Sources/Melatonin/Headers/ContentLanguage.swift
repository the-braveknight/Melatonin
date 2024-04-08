//
//  ContentLanguage.swift
//
//
//  Created by Zaid Rahhawi on 4/9/24.
//

import Foundation

public struct ContentLanguage: HeaderKey, HTTPHeader {
    public static let field: String = "Content-Language"
    public typealias Value = Language
    
    public let language: Language
    
    public init(_ language: Language) {
        self.language = language
    }
    
    public var field: String {
        Self.field
    }
    
    public var value: String {
        language.headerValue
    }
}

public extension HeaderValues {
    var contentLanguage: ContentLanguage.Type {
        ContentLanguage.self
    }
}
