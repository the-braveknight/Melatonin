//
//  Todos API.swift
//  NetworkingIdeas
//
//  Created by Zaid Rahhawi on 4/8/24.
//

import Foundation
import Melatonin

struct TodosEndpoint: GoRESTPaginatedEndpoint {
    typealias Record = Todo
    let path: String = "/public/v2/todos"
    
    @Query(name: "page") var page: Int = 1
    @Query(name: "per_page") var recordsPerPage: Int = 10
    @Query(name: "title") var title: String? = nil
}

extension Endpoint where Self == TodosEndpoint {
    static func todos(page: Int = 1, recordsPerPage: Int = 10, matching: String? = nil) -> Self {
        Self(page: page, recordsPerPage: recordsPerPage)
    }
}
