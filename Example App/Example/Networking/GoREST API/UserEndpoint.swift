//
//  UserEndpoint.swift
//  Example
//
//  Created by Zaid Rahhawi on 4/8/24.
//

import Foundation
import Melatonin

struct UserEndpoint: GoRESTEndpoint {
    typealias Response = User
    
    let path: String
    
    init(id: User.ID) {
        self.path = "/public/v2/users/\(id)"
    }
}

extension Endpoint where Self == UserEndpoint {
    static func user(withID userID: User.ID) -> Self {
        Self(id: userID)
    }
}
