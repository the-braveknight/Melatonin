//
//  URLSession++.swift
//
//
//  Created by Zaid Rahhawi on 12/18/21.
//

import Foundation

public extension URLSession {
    @discardableResult
    func load<E: Endpoint>(_ endpoint: E, completionHandler: @escaping (Result<(E.Result, URLResponse), Error>) -> Void) -> URLSessionDataTask {
        let task = dataTask(with: endpoint.request) { data, response, error in
            do {
                if let data = data, let response = response {
                    let result = try endpoint.parse(data: data)
                    completionHandler(.success((result, response)))
                } else if let error = error {
                    throw error
                } else {
                    throw URLError(.resourceUnavailable)
                }
            } catch {
                completionHandler(.failure(error))
            }
        }
        
        task.resume()
        
        return task
    }
}

#if canImport(Combine)
import Combine

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public extension URLSession {
    func publisher<E : Endpoint>(for endpoint: E) -> some Publisher<(E.Result, URLResponse), Error> {
        return dataTaskPublisher(for: endpoint.request)
            .tryMap { data, response in
                let result = try endpoint.parse(data: data)
                return (result, response)
            }
    }
}
#endif

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public extension URLSession {
    func load<E : Endpoint>(_ endpoint: E) async throws -> (E.Result, URLResponse) {
        let (data, response) = try await data(for: endpoint.request)
        let result = try endpoint.parse(data: data)
        return (result, response)
    }
}
