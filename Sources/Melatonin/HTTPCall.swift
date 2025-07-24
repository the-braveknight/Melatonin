//
//  HTTPCall.swift
//  Melatonin
//
//  Created by Zaid Rahhawi on 12/19/24.
//

import Foundation

public protocol HTTPCall: Sendable {
    func build() -> URLRequest
}

