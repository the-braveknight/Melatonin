//
//  HTTPHeader.swift
//  
//
//  Created by Zaid Rahhawi on 8/13/22.
//

import Foundation

public protocol HTTPHeader {
    var field: String { get }
    var value: String { get }
}

public enum Auth : HTTPHeader {
    case bearer(token: String)
    case basic(username: String, password: String)
    
    public var field: String {
        return "Authorization"
    }
    
    public var value: String {
        switch self {
        case .bearer(let token):
            return "Bearer \(token)"
        case .basic(let username, let password):
            return "Basic \(Data("\(username):\(password)".utf8).base64EncodedString()))"
        }
    }
}

extension HTTPHeader where Self == Auth {
    static func auth(_ auth: Auth) -> Self {
        return auth
    }
}

public enum MIMEType : String {
    case json = "application/json"
    case xml = "application/xml"
    case urlencoded = "application/x-www-form-urlencoded"
    case text = "text/plain"
    case html = "text/html"
    case css = "text/css"
    case javascript = "text/javascript"
    case gif = "image/gif"
    case png = "image/png"
    case jpeg = "image/jpeg"
    case bmp = "image/bmp"
    case webp = "image/webp"
    case midi = "audio/midi"
    case mpeg = "audio/mpeg"
    case wav = "audio/wav"
    case pdf = "application/pdf"
}

public struct Header : HTTPHeader {
    public let field: String
    public let value: String
    
    public init(field: String, value: String) {
        self.field = field
        self.value = value
    }
}

public struct Accept : HTTPHeader {
    public var field: String = "Accept"
    public var value: String
    
    public init(_ mimeType: MIMEType) {
        self.value = mimeType.rawValue
    }
}

extension HTTPHeader where Self == Accept {
    static func accept(_ mimeType: MIMEType) -> Self {
        Self(mimeType)
    }
}

public struct ContentType : HTTPHeader {
    public var field: String = "Content-Type"
    public var value: String
    
    public init(_ mimeType: MIMEType) {
        self.value = mimeType.rawValue
    }
}

public struct ContentLength : HTTPHeader {
    public var field: String = "Content-Length"
    public var value: String
    
    public init(_ octets: Int) {
        self.value = "\(octets)"
    }
}

public struct Origin : HTTPHeader {
    public var field: String = "Origin"
    public var value: String
    
    public init(_ origin: String) {
        self.value = origin
    }
}
