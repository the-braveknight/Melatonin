//
//  Posts API.swift
//  NetworkingIdeas
//
//  Created by Zaid Rahhawi on 4/7/24.
//

import Foundation
import Melatonin

struct PostsEndpoint: GoRESTPaginatedEndpoint {
    typealias Record = Post
    
    let path: String = "/public/v2/posts"
        
    @Query(name: "user_id") var user: User.ID? = nil
    @Query(name: "page") var page: Int = 1
    @Query(name: "per_page") var recordsPerPage: Int = 10
    @Query(name: "title") var title: String? = nil
}

extension Endpoint where Self == PostsEndpoint {
    static func posts(forUserWithID userID: User.ID? = nil, page: Int = 1, recordsPerPage: Int = 20, matching title: String? = nil) -> Self {
        Self(user: userID, page: page, recordsPerPage: recordsPerPage, title: title)
    }
}

