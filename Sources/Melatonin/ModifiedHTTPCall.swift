//
//  ModifiedHTTPCall.swift
//  Melatonin
//
//  Created by Zaid Rahhawi on 12/19/24.
//

import Foundation

public struct ModifiedHTTPCall<Call: HTTPCall, Modifier: HTTPCallModifier>: HTTPCall {
    public let call: Call
    public let modifier: Modifier
    
    public init(call: Call, modifier: Modifier) {
        self.call = call
        self.modifier = modifier
    }
    
    public func build() -> URLRequest {
        var request = call.build()
        modifier.build(&request)
        return request
    }
}

public extension HTTPCall {
    func modifier<Modifier: HTTPCallModifier>(_ modifier: Modifier) -> ModifiedHTTPCall<Self, Modifier> {
        ModifiedHTTPCall(call: self, modifier: modifier)
    }
}
