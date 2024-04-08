//
//  AcceptLanguage.swift
//
//
//  Created by Zaid Rahhawi on 4/9/24.
//

import Foundation

public struct AcceptLanguage: HeaderKey, HTTPHeader {
    public static let field: String = "Accept-Language"
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

public struct Language: HeaderValue, ExpressibleByStringLiteral {
    public let headerValue: String
    
    public init(headerValue: String) {
        self.headerValue = headerValue
    }
    
    public init(stringLiteral value: String) {
        self.init(headerValue: value)
    }
}

public extension Language {
    static let enUS: Self = "en-US"
    static let enGB: Self = "en-GB"
    static let enCA: Self = "en-CA"
    static let frCA: Self = "fr-CA"
}

public extension HeaderValues {
    var acceptLanguage: AcceptLanguage.Type {
        AcceptLanguage.self
    }
}
