//
//  GoRESTEndpoint.swift
//  NetworkingIdeas
//
//  Created by Zaid Rahhawi on 4/8/24.
//

import Foundation
import Melatonin

public struct GoRESTCall: HTTPCall {
    public func build() -> URLRequest {
        URLRequest(url: .gorest)
    }
}

extension URL {
    static let gorest = URL(string: "https://gorest.co.in")!
}
