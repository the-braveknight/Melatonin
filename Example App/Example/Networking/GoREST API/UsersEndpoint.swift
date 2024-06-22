//
//  Users API.swift
//  NetworkingIdeas
//
//  Created by Zaid Rahhawi on 4/7/24.
//

import Foundation
import Melatonin

struct UsersEndpoint: GoRESTPaginatedEndpoint {
    typealias Record = User
    
    let path: String = "/public/v2/users"
    
    @Query(name: "page") var page: Int = 1
    @Query(name: "per_page") var recordsPerPage: Int = 10
    @Query(name: "name") var name: String? = nil
}

extension Endpoint where Self == UsersEndpoint {
    static func users(page: Int = 1, recrodsPerPage: Int = 10, matching name: String? = nil) -> Self {
        Self(page: page, recordsPerPage: recrodsPerPage, name: name)
    }
}
