//
//  HeadersModifier.swift
//  Melatonin
//
//  Created by Zaid Rahhawi on 12/19/24.
//

import Foundation

public struct HeadersModifier: HTTPCallModifier {
    public let headers: [any HTTPHeader]
    
    public init(headers: [any HTTPHeader]) {
        self.headers = headers
    }
    
    public func build(_ request: inout URLRequest) {
        headers.forEach { header in
            header.build(&request)
        }
    }
}

public typealias HeaderGroup = ArrayBuilder<HTTPHeader>

public extension HTTPCall {
    func headers(@HeaderGroup headers: () -> [any HTTPHeader]) -> ModifiedHTTPCall<Self, HeadersModifier> {
        modifier(HeadersModifier(headers: headers()))
    }
}
