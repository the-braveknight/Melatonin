//
//  User.swift
//  Example
//
//  Created by Zaid Rahhawi on 4/8/24.
//

import Foundation

struct User: Decodable, Identifiable {
    let id: Int
    let name: String
    let email: String
    let gender: Gender
    let status: Status
    
    enum Gender: String, Decodable {
        case male, female
    }
    
    enum Status: String, Decodable {
        case active, inactive
    }
}
