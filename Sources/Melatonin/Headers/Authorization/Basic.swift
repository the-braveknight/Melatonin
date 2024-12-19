//
//  Basic.swift
//  Melatonin
//
//  Created by Zaid Rahhawi on 12/19/24.
//

public struct Basic: OAuthorization {
    public let username: String
    public let password: String
    
    public init(username: String, password: String) {
        self.username = username
        self.password = password
    }
    
    public var value: String {
        let authorization = "\(username):\(password)"
        
        if let data = authorization.data(using: .utf8) {
            return "Basic \(data.base64EncodedString())"
        }
        
        return "Basic \(authorization)"
    }
}

public extension OAuthorization where Self == Basic {
    static func basic(username: String, password: String) -> Self {
        Self(username: username, password: password)
    }
}
