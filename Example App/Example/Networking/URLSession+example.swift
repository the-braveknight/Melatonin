//
//  URLSession+example.swift
//  Example
//
//  Created by Zaid Rahhawi on 12/20/24.
//

import Foundation

extension URLSession {
    static let example: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .useProtocolCachePolicy
        configuration.urlCache = URLCache(memoryCapacity: 20 * 1024 * 1024, diskCapacity: 100 * 1024 * 1024, diskPath: "ClientCache")
        return URLSession(configuration: configuration)
    }()
}
