//
//  Todos API.swift
//  NetworkingIdeas
//
//  Created by Zaid Rahhawi on 4/8/24.
//

import Foundation
import Melatonin

struct GetTodos: Endpoint {
    var page: Int = 1
    var recordsPerPage: Int = 10
    var title: String? = nil
    
    var call: some HTTPCall {
        GoRESTCall()
            .path("/public/v2/todos")
            .queries {
                Query(name: "page", value: String(page))
                Query(name: "per_page", value: String(recordsPerPage))
                Query(name: "title", value: title)
            }
    }
}
