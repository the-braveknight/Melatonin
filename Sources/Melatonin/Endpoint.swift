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
    associatedtype Response
    associatedtype Body: HTTPBody = Never
    
    var scheme: Scheme { get }
    var host: String { get }
    var port: Int? { get }
    var path: String { get }
    var method: HTTPMethod { get }
    @QueryGroup var queries: [URLQuery] { get }
    @HeaderGroup var headers: [HTTPHeader] { get }
    var body: Body? { get }
    func prepare(request: inout URLRequest)
    func parse(data: Data, urlResponse: URLResponse) throws -> Response
}

extension Endpoint {
    var allQueries: [URLQuery] {
        let mirror = Mirror(reflecting: self)
        let mirroredQueries = mirror.children.compactMap { $0.value as? URLQuery }
        return queries + mirroredQueries
    }
    
    var allHeaders: [HTTPHeader] {
        let mirror = Mirror(reflecting: self)
        let mirroredHeaders = mirror.children.compactMap { $0.value as? HTTPHeader }
        return headers + mirroredHeaders
    }
}

// MARK: - Default Implementation
public extension Endpoint {
    var scheme: Scheme { .https }
    var port: Int? { nil }
    var method : HTTPMethod { .get }
    var queries: [URLQuery] { [] }
    var headers: [HTTPHeader] { [] }
    var body: Body? { nil }
    func prepare(request: inout URLRequest) {}
}

// - MARK: Additional Properties
public extension Endpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = scheme.rawValue
        components.host = host
        components.path = path
        components.port = port
        components.queryItems = allQueries.map(\.urlQueryItem)

        guard let url = components.url else {
            fatalError("Invalid URL components: \(components)")
        }
        
        return url
    }
    
    var request: URLRequest {
        var request = URLRequest(url: url)
        
        allHeaders.forEach { $0.build(&request) }
        method.build(&request)
        body?.build(&request)
        prepare(request: &request)
        
        return request
    }
}

public extension Endpoint where Response: Decodable {
    func parse(data: Data, urlResponse: URLResponse) throws -> Response {
        let decoder = JSONDecoder()
        return try decoder.decode(Response.self, from: data)
    }
}

public extension Endpoint where Response == URLResponse {
    func parse(data: Data, urlResponse: URLResponse) throws -> Response {
        return urlResponse
    }
}

public extension Endpoint where Response == Data {
    func parse(data: Data, urlResponse: URLResponse) throws -> Response {
        return data
    }
}

public extension Endpoint where Response == (Data, URLResponse) {
    func parse(data: Data, urlResponse: URLResponse) throws -> Response {
        return (data, urlResponse)
    }
}
