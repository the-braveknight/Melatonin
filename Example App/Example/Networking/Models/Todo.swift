//
//  Todo.swift
//  Example
//
//  Created by Zaid Rahhawi on 4/8/24.
//

import Foundation

struct Todo: Decodable, Identifiable {
    let id: Int
    let userID: User.ID
    let title: String
    let dueDate: Date
    let status: Status
    
    enum Status: String, Decodable {
        case pending, completed
    }
    
    private enum CodingKeys: String, CodingKey {
        case id, title, status
        case userID = "user_id"
        case dueDate = "due_on"
    }
}
