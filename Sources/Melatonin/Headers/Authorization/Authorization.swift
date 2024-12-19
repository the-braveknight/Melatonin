//
//  Authorization.swift
//  
//
//  Created by Zaid Rahhawi on 2/25/23.
//

import Foundation

public struct Authorization<Auth: OAuthorization>: HTTPHeader {
    public let field: String = "Authorization"
    public let auth: Auth
    
    public var value: String {
        auth.value
    }
    
    public init(_ auth: Auth) {
        self.auth = auth
    }
}
