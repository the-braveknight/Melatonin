//
//  URLSession++.swift
//
//
//  Created by Zaid Rahhawi on 12/18/21.
//

import Foundation

public extension URLSession {
    @discardableResult
    func load<E: Endpoint>(_ endpoint: E, completionHandler: @escaping (Result<E.Response, Error>) -> Void) -> URLSessionDataTask {
        let task = dataTask(with: endpoint.request) { data, response, error in
            do {
                if let data = data, let response = response {
                    let response = try endpoint.parse(data: data, urlResponse: response)
                    completionHandler(.success(response))
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
    func publisher<E : Endpoint>(for endpoint: E) -> some Publisher<E.Response, Error> {
        return dataTaskPublisher(for: endpoint.request)
            .tryMap(endpoint.parse)
    }
}
#endif

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public extension URLSession {
    func load<E : Endpoint>(_ endpoint: E) async throws -> E.Response {
        let (data, urlResponse) = try await data(for: endpoint.request)
        let response = try endpoint.parse(data: data, urlResponse: urlResponse)
        return response
    }
}
