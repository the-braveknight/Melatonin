//
//  MIMEType.swift
//  Melatonin
//
//  Created by Zaid Rahhawi on 12/19/24.
//

public struct MIMEType: ExpressibleByStringLiteral {
    public let type: `Type`
    public let subType: SubType
    public let parameters: [Parameter]
    
    public var value: String {
        let value = "\(type.value)/\(subType.value)"
        
        if parameters.isEmpty {
            return value
        } else {
            return "\(value);\(parameters.map(\.description).joined(separator: ";"))"
        }
    }
    
    public init(type: Type, subType: SubType, parameters: [Parameter] = []) {
        self.type = type
        self.subType = subType
        self.parameters = parameters
    }
    
    public init(type: `Type`, subType: SubType, parameters: Parameter...) {
        self.init(type: type, subType: subType, parameters: parameters)
    }
    
    public init(stringLiteral value: StringLiteralType) {
        let components = value.split(separator: ";", maxSplits: 1).map { $0.trimmingCharacters(in: .whitespaces) }
        
        guard let typeSubtype = components.first else {
            preconditionFailure("Invalid MIME type format.")
        }
        
        let typeSubtypeParts = typeSubtype.split(separator: "/", maxSplits: 1)
        
        guard typeSubtypeParts.indices.contains(0) && typeSubtypeParts.indices.contains(1) else {
            preconditionFailure("Invalid MIME type format.")
        }
        
        self.type = Type(value: String(typeSubtypeParts[0]))
        self.subType = SubType(value: String(typeSubtypeParts[1]))
        
        // Parameters parsing
        if components.indices.contains(1) {
            let parametersString = components[1]
            self.parameters = parametersString.split(separator: ";").map { Parameter(stringLiteral: String($0)) }
        } else {
            self.parameters = []
        }
    }
}

extension MIMEType {
    public struct `Type`: ExpressibleByStringLiteral {
        public let value: String
        
        public init(value: String) {
            self.value = value
        }
        
        public init(stringLiteral value: StringLiteralType) {
            self.init(value: value)
        }
    }
    
    public struct SubType: ExpressibleByStringLiteral {
        public let value: String
        
        public init(value: String) {
            self.value = value
        }
        
        public init(stringLiteral value: StringLiteralType) {
            self.init(value: value)
        }
    }
    
    public struct Parameter: ExpressibleByStringLiteral, CustomStringConvertible {
        public let key: String
        public let value: String
        
        public var description: String {
            "\(key)=\(value)"
        }
        
        public init(key: String, value: String) {
            self.key = key
            self.value = value
        }
        
        public init(stringLiteral value: StringLiteralType) {
            let components = value.split(separator: "=", maxSplits: 1).map { $0.trimmingCharacters(in: .whitespaces) }
            guard components.indices.contains(0) && components.indices.contains(1) else {
                preconditionFailure("Invalid parameter format. Expected 'key=value'.")
            }
            self.key = components[0]
            self.value = components[1]
        }
    }
}

// MARK: - Predefined Types and SubTypes
public extension MIMEType.`Type` {
    static let application: Self = "application"
    static let text: Self = "text"
    static let image: Self = "image"
    static let audio: Self = "audio"
    static let video: Self = "video"
}

public extension MIMEType.SubType {
    static let json: Self = "json"
    static let html: Self = "html"
    static let plain: Self = "plain"
    static let xml: Self = "xml"
    static let css: Self = "css"
    static let javascript: Self = "javascript"
    static let png: Self = "png"
    static let jpeg: Self = "jpeg"
    static let gif: Self = "gif"
    static let webp: Self = "webp"
    static let pdf: Self = "pdf"
    static let mpeg: Self = "mpeg"
    static let wav: Self = "wav"
    static let avi: Self = "avi"
    static let problemJson: Self = "problem+json"
}

public extension MIMEType.Parameter {
    static func charset(_ value: String) -> Self {
        Self(key: "charset", value: value)
    }
    
    static func boundary(_ value: String) -> Self {
        Self(key: "boundary", value: value)
    }
}

public extension MIMEType {
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
    static let problemJson: Self = "application/problem+json"
}
