//
//  Query.swift
//  
//
//  Created by Zaid Rahhawi on 2/25/23.
//

import Foundation

public protocol URLQuery {
    var name: String { get }
    var value: String? { get }
}

extension URLQuery {
    public var urlQueryItem: URLQueryItem {
        URLQueryItem(name: name, value: value)
    }
}

public protocol QueryValue {
    var queryValue: String? { get }
}

extension Int : QueryValue {
    public var queryValue: String? {
        String(self)
    }
}

extension String : QueryValue {
    public var queryValue: String? {
        self
    }
}

extension Bool : QueryValue {
    public var queryValue: String? {
        String(self)
    }
}

extension Optional : QueryValue where Wrapped : QueryValue {
    public var queryValue: String? {
        self?.queryValue
    }
}

@propertyWrapper
public struct Query<Value: QueryValue> : URLQuery {
    public let name: String
    public var wrappedValue: Value
    
    public var value: String? {
        wrappedValue.queryValue
    }

    public init(wrappedValue: Value, name: String) {
        self.name = name
        self.wrappedValue = wrappedValue
    }
    
    public init<V : QueryValue>(name: String, value: V?) where Value == V? {
        self.init(wrappedValue: value, name: name)
    }
    
    public init(name: String) where Value == String? {
        self.init(name: name, value: String?.none)
    }
}

public typealias QueryGroup = ArrayBuilder<URLQuery>
