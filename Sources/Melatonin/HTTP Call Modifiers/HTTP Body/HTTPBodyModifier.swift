//
//  HTTPBodyModifier.swift
//
//
//  Created by Zaid Rahhawi on 4/6/24.
//

import Foundation

public protocol HTTPBodyModifier: HTTPCallModifier {
    var data: Data? { get }
}

extension HTTPBodyModifier {
    public func build(_ request: inout URLRequest) {
        request.httpBody = data
    }
}
