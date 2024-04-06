//
//  HTTPHeader.swift
//
//
//  Created by Zaid Rahhawi on 8/13/22.
//

import Foundation

public protocol HTTPHeader: URLRequestComponent {
    var field: String { get }
    var value: String { get }
}

extension HTTPHeader {
    public func build(_ request: inout URLRequest) {
        request.addValue(value, forHTTPHeaderField: field)
    }
}

public protocol HeaderKey {
    associatedtype Value: HeaderValue
    static var field: String { get }
}

public protocol HeaderValue {
    var headerValue: String { get }
}

public struct HeaderValues {
    private init() {}
}

extension String : HeaderValue {
    public var headerValue: String { self }
}

@propertyWrapper
public struct Header<Value: HeaderValue> : HTTPHeader {
    public let field: String
    public var wrappedValue: Value
    
    public var value: String {
        wrappedValue.headerValue
    }
    
    public init<Key : HeaderKey>(wrappedValue: Value, key: Key.Type) where Value == Key.Value {
        self.field = Key.field
        self.wrappedValue = wrappedValue
    }
    
    public init<Key : HeaderKey>(wrappedValue: Value, _ keyPath: KeyPath<HeaderValues, Key.Type>) where Value == Key.Value {
        self.field = Key.field
        self.wrappedValue = wrappedValue
    }
    
    public init(wrappedValue: Value, field: String) {
        self.field = field
        self.wrappedValue = wrappedValue
    }
    
    public init<Key : HeaderKey>(key: Key.Type, value: Value) where Value == Key.Value {
        self.init(wrappedValue: value, key: Key.self)
    }
    
    public init<Key : HeaderKey>(_ keyPath: KeyPath<HeaderValues, Key.Type>, value: Key.Value) where Value == Key.Value {
        self.init(wrappedValue: value, keyPath)
    }
    
    public init(field: String, value: Value) {
        self.init(wrappedValue: value, field: field)
    }
}

public typealias HeaderGroup = ArrayBuilder<HTTPHeader>
