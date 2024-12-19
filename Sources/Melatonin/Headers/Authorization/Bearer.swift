//
//  Bearer.swift
//  Melatonin
//
//  Created by Zaid Rahhawi on 12/19/24.
//

public struct Bearer: OAuthorization {
    public let token: String
    
    public var value: String {
        "Bearer \(token)"
    }
    
    public init(token: String) {
        self.token = token
    }
}

public extension OAuthorization where Self == Bearer {
    static func bearer(token: String) -> Self {
        Self(token: token)
    }
}
