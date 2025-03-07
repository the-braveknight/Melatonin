//
//  AnyHTTPBodyModifier.swift
//  Melatonin
//
//  Created by Zaid Rahhawi on 3/6/25.
//

import Foundation

public struct AnyHTTPBodyModifier: HTTPCallModifier {
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
    func body(data: Data?) -> ModifiedHTTPCall<Self, AnyHTTPBodyModifier> {
        modifier(AnyHTTPBodyModifier(data: data))
    }
    
    func body<Body: Encodable>(body: Body, encoder: JSONEncoder = JSONEncoder()) -> ModifiedHTTPCall<Self, AnyHTTPBodyModifier> {
        modifier(AnyHTTPBodyModifier(body: body, encoder: encoder))
    }
}
