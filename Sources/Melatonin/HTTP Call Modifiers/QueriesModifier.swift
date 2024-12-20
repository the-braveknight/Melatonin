//
//  QueriesModifier.swift
//
//
//  Created by Zaid Rahhawi on 2/25/23.
//

import Foundation

public struct Query {
    public let name: String
    public let value: String?
    
    public var urlQueryItem: URLQueryItem {
        URLQueryItem(name: name, value: value)
    }

    public init(name: String, value: String?) {
        self.name = name
        self.value = value
    }
}

public struct QueriesModifier: HTTPCallModifier {
    let queries: [Query]
    
    public func build(_ request: inout URLRequest) {
        let urlQueryItems = queries.map(\.urlQueryItem)
        
        if #available(macOS 13, iOS 16, tvOS 16, watchOS 9, *) {
            request.url?.append(queryItems: urlQueryItems)
        } else {
            guard let url = request.url, var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
                return
            }
            
            if components.queryItems == nil {
                components.queryItems = urlQueryItems
            } else {
                components.queryItems?.append(contentsOf: urlQueryItems)
            }
        }
    }
}

public typealias QueryGroup = ArrayBuilder<Query>

public extension HTTPCall {
    func queries(@QueryGroup queries: () -> [Query]) -> ModifiedHTTPCall<Self, QueriesModifier> {
        modifier(QueriesModifier(queries: queries()))
    }
}
