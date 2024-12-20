//
//  Endpoint.swift
//  
//
//  Created by Zaid Rahhawi on 12/29/22.
//

import Foundation

// MARK: - Endpoint Protocol
/// Endpoint protocol
public protocol Endpoint {
    associatedtype Call: HTTPCall
    var call: Call { get }
}

