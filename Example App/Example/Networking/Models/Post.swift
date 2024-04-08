//
//  Post.swift
//  Example
//
//  Created by Zaid Rahhawi on 4/8/24.
//

import Foundation

struct Post: Decodable, Identifiable {
    let id: Int
    let user: User.ID
    let title: String
    let body: String
    
    private enum CodingKeys: String, CodingKey {
        case id, title, body
        case user = "user_id"
    }
}
