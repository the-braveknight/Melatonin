//
//  HTTPHeader.swift
//
//
//  Created by Zaid Rahhawi on 8/13/22.
//

import Foundation

public protocol HTTPHeader: HTTPCallModifier {
    var field: String { get }
    var value: String { get }
}

extension HTTPHeader {
    public func build(_ request: inout URLRequest) {
        request.addValue(value, forHTTPHeaderField: field)
    }
}
