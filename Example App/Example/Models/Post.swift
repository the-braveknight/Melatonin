//
//  Post.swift
//  Example
//
//  Created by Zaid Rahhawi on 4/8/24.
//

import Foundation
import SwiftData

@Model
class Post: Decodable, Identifiable {
    @Attribute(.unique) let id: Int
    let user: User.ID
    let title: String
    let body: String
    
    init(id: Int, user: User.ID, title: String, body: String) {
        self.id = id
        self.user = user
        self.title = title
        self.body = body
    }
    
    private enum CodingKeys: String, CodingKey {
        case id, title, body
        case user = "user_id"
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.user = try container.decode(User.ID.self, forKey: .user)
        self.title = try container.decode(String.self, forKey: .title)
        self.body = try container.decode(String.self, forKey: .body)
    }
}
