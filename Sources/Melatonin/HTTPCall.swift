//
//  HTTPCall.swift
//  Melatonin
//
//  Created by Zaid Rahhawi on 12/19/24.
//

import Foundation

public protocol HTTPCall {
    func build() -> URLRequest
}

