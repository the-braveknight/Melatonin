//
//  Example.swift
//  
//
//  Created by Zaid Rahhawi on 3/1/23.
//

import Foundation

enum Country : String, QueryValue {
    case iraq, usa, saudiArabia, syria
    
    var queryValue: String? {
        rawValue
    }
}

struct MyEndpoint : Endpoint {
    let host: String = "www.google.com"
    let path: String = "/"
    
    struct Response : Codable {}
    
    @Header(\.accept) var accept = .jpeg
    @Query(name: "age") var age = 9
    @Query(name: "Prosperity") var pros = "Sw"
    
    @Query(name: "country") var country: Country = .iraq
    
    @HeaderGroup var headers: [HTTPHeader] {
        Auth(.basic("MyToken"))
        Header(field: "Content-Type", value: "json")
    }
    
    @QueryGroup var queries: [URLQuery] {
        Query(name: "name", value: "Urology")
        Query(name: "isBookmarked", value: true)
    }
}

