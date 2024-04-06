//
//  HTTPBody.swift
//
//
//  Created by Zaid Rahhawi on 4/6/24.
//

import Foundation

public protocol HTTPBody: URLRequestComponent {
    var data: Data? { get }
}

extension HTTPBody {
    public func build(_ request: inout URLRequest) {
        request.httpBody = data
    }
}

extension Never: HTTPBody {
    public var data: Data? { nil }
}

extension HTTPBody where Self: Encodable {
    public var data: Data? {
        do {
            let encoder = JSONEncoder()
            return try encoder.encode(self)
        } catch {
            fatalError("Could not encode: \(self) with error: \(error).")
        }
    }
}
