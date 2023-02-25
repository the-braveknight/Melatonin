//
//  File.swift
//  
//
//  Created by Zaid Rahhawi on 2/25/23.
//

import Foundation

public struct ContentType: HeaderKey {
    public static let field: String = "Content-Type"
    public typealias Value = MIMEType
}

public extension HeaderValues {
    var contentType: ContentType.Type {
        ContentType.self
    }
}
