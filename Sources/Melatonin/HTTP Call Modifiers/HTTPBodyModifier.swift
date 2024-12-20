//
//  HTTPBodyModifier.swift
//
//
//  Created by Zaid Rahhawi on 4/6/24.
//

import Foundation

public struct HTTPBodyModifier: HTTPCallModifier {
    public let data: Data?
    
    public init(data: Data?) {
        self.data = data
    }
    
    public init<Body: Encodable>(body: Body, encoder: JSONEncoder = JSONEncoder()) {
        self.data = try? encoder.encode(body)
    }
    
    public func build(_ request: inout URLRequest) {
        request.httpBody = data
    }
}

public extension HTTPCall {
    func body(data: Data?) -> ModifiedHTTPCall<Self, HTTPBodyModifier> {
        modifier(HTTPBodyModifier(data: data))
    }
    
    func body<Body: Encodable>(body: Body, encoder: JSONEncoder = JSONEncoder()) -> ModifiedHTTPCall<Self, HTTPBodyModifier> {
        modifier(HTTPBodyModifier(body: body, encoder: encoder))
    }
}
