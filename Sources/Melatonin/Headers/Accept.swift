//
//  Accept.swift
//  
//
//  Created by Zaid Rahhawi on 2/25/23.
//

import Foundation

public struct Accept: HeaderKey, HTTPHeader {
    public static let field: String = "Accept"
    public typealias Value = MIMEType
    
    public let mimeType: Value
    
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

public struct MIMEType: ExpressibleByStringLiteral, HeaderValue {
    public var value: String
    
    public init(value: String) {
        self.value = value
    }
    
    public var headerValue: String {
        value
    }
    
    public init(stringLiteral value: String) {
        self.init(value: value)
    }
}

extension MIMEType {
    static let json: Self = "application/json"
    static let xml: Self = "application/xml"
    static let urlencoded: Self = "application/x-www-form-urlencoded"
    static let text: Self = "text/plain"
    static let html: Self = "text/html"
    static let css: Self = "text/css"
    static let javascript: Self = "text/javascript"
    static let gif: Self = "image/gif"
    static let png: Self = "image/png"
    static let jpeg: Self = "image/jpeg"
    static let bmp: Self = "image/bmp"
    static let webp: Self = "image/webp"
    static let midi: Self = "audio/midi"
    static let mpeg: Self = "audio/mpeg"
    static let wav: Self = "audio/wav"
    static let pdf: Self = "application/pdf"
}

public extension HeaderValues {
    var accept: Accept.Type {
        Accept.self
    }
}
