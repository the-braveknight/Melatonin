//
//  Todo.swift
//  Example
//
//  Created by Zaid Rahhawi on 4/8/24.
//

import Foundation
import SwiftData

@Model
class Todo: Decodable, Identifiable {
    @Attribute(.unique) let id: Int
    let user: User.ID
    let title: String
    let dueDate: Date
    var status: Status
    
    enum Status: String, Codable {
        case pending, completed
    }
    
    init(id: Int, userID: User.ID, title: String, dueDate: Date, status: Status) {
        self.id = id
        self.user = userID
        self.title = title
        self.dueDate = dueDate
        self.status = status
    }
    
    private enum CodingKeys: String, CodingKey {
        case id, title, status
        case user = "user_id"
        case dueDate = "due_on"
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.user = try container.decode(User.ID.self, forKey: .user)
        self.title = try container.decode(String.self, forKey: .title)
        self.dueDate = try container.decode(Date.self, forKey: .dueDate)
        self.status = try container.decode(Status.self, forKey: .status)
    }
}

extension Todo {
    var isCompleted: Bool {
        get { status == .completed }
        set { status = status == .completed ? .pending : .completed }
    }
}
