//
//  Accept.swift
//  
//
//  Created by Zaid Rahhawi on 2/25/23.
//

import Foundation

public struct Accept: HTTPHeader {
    public let field: String = "Accept"
    public let mimeType: MIMEType
    
    public var value: String {
        mimeType.value
    }
    
    public init(_ mimeType: MIMEType) {
        self.mimeType = mimeType
    }
}

public extension HTTPCall {
    func accept(_ mimeType: MIMEType) -> ModifiedHTTPCall<Self, Accept> {
        modifier(Accept(mimeType))
    }
}
