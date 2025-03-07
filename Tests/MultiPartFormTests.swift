//
//  MultiPartFormTests.swift
//  Melatonin
//
//  Created by Zaid Rahhawi on 3/6/25.
//

import Testing
@testable import Melatonin
import Foundation

struct MockHTTPCall: HTTPCall {
    func build() -> URLRequest {
        URLRequest(url: URL(string: "http://localhost:8080/api")!)
    }
}

struct MockEndpoint: Endpoint {
    var call: some HTTPCall {
        MockHTTPCall()
            .multiPartForm(boundary: UUID().uuidString) {
                Text("Zaid Rahhawi")
                    .contentDisposition(.formData, .name("fullName"))
                    .contentType(.text)
                
                File(data: Data("MockImageData".utf8))
                    .contentDisposition(.formData, .name("profileImage"), .filename("profile.jpg"))
                    .contentType(.jpeg)
            }
    }
}

@Suite("MultiPartFormTests")
struct MultiPartFormTests {
    @Test func test() async throws {
        let endpoint = MockEndpoint()
        let call = endpoint.call
        let request = call.build()
        
        let data = try #require(request.httpBody)
        let httpBody = try #require(String(data: data, encoding: .utf8))
        let contentType = try #require(request.value(forHTTPHeaderField: "Content-Type")!)
        
        print("Content-Type: ", contentType)
        print(httpBody)
    }
}
