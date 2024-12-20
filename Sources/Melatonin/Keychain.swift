//
//  Keychain.swift
//  Melatonin
//
//  Created by Zaid Rahhawi on 12/20/24.
//

@preconcurrency import Foundation
import Security

public actor Keychain {
    let serviceName: String
    let accessGroup: String?
    
    public init(serviceName: String, accessGroup: String?) {
        self.serviceName = serviceName
        self.accessGroup = accessGroup
    }
    
    func data(forKey key: String, accessibility: ItemAccessibility? = nil) throws -> Data? {
        var query = query(forKey: key, accessibility: accessibility)
        query[kSecMatchLimit] = kSecMatchLimitOne
        query[kSecReturnData] = kCFBooleanTrue
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        guard status == errSecSuccess else {
            throw Error(status: status)
        }
        
        return result as? Data
    }
    
    func set(_ data: Data, forKey key: String, accessibility: ItemAccessibility? = nil) throws {
        var queryDictionary = query(forKey: key, accessibility: accessibility)
        queryDictionary[kSecValueData] = data
        
        if accessibility == nil {
            queryDictionary[kSecAttrAccessible] = ItemAccessibility.whenUnlocked.keychainAttrValue
        }
        
        let status = SecItemAdd(queryDictionary as CFDictionary, nil)
        
        switch status {
        case errSecSuccess:
            break
        case errSecDuplicateItem:
            try update(data, forKey: key, accessbility: accessibility)
        default:
            throw Error(status: status)
        }
    }
    
    func removeValue(forKey key: String, accessbility: ItemAccessibility? = nil) throws {
        let queryDictionary = query(forKey: key, accessibility: accessbility)
        let status = SecItemDelete(queryDictionary as CFDictionary)
        guard status == errSecSuccess else {
            throw Error(status: status)
        }
    }
    
    func wipe() throws {
        var queryDictionary: [CFString: Any] = [kSecClass: kSecClassGenericPassword]
        queryDictionary[kSecAttrService] = serviceName
        
        if let accessGroup = accessGroup {
            queryDictionary[kSecAttrAccessGroup] = accessGroup
        }
        
        let status = SecItemDelete(queryDictionary as CFDictionary)
        
        guard status == errSecSuccess else {
            throw Error(status: status)
        }
    }
    
    private func query(forKey key: String, accessibility: ItemAccessibility? = nil) -> [CFString: Any] {
        var query: [CFString: Any] = [kSecClass: kSecClassGenericPassword]
        query[kSecAttrService] = serviceName
        
        if let accessGroup = accessGroup {
            query[kSecAttrAccessGroup] = accessGroup
        }
        
        if let accessibility = accessibility {
            query[kSecAttrAccessible] = accessibility.keychainAttrValue
        }
        
        let encodedKey = key.data(using: .utf8)
        
        query[kSecAttrGeneric] = encodedKey
        query[kSecAttrAccount] = encodedKey
        
        return query
    }
    
    private func update(_ value: Data, forKey key: String, accessbility: ItemAccessibility? = nil) throws {
        let query = query(forKey: key, accessibility: accessbility)
        let updateQuery = [kSecValueData: value]
        
        let status = SecItemUpdate(query as CFDictionary, updateQuery as CFDictionary)
        
        guard status == errSecSuccess else {
            throw Error(status: status)
        }
    }
}

public extension Keychain {
    struct ItemAccessibility: Sendable {
        public let keychainAttrValue: CFString
        
        public init(keychainAttrValue: CFString) {
            self.keychainAttrValue = keychainAttrValue
        }
        
        public static let afterFirstUnlock = Self(keychainAttrValue: kSecAttrAccessibleAfterFirstUnlock)
        public static let afterFirstUnlockThisDeviceOnly = Self(keychainAttrValue: kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly)
        public static let whenPasscodeSetThisDeviceOnly = Self(keychainAttrValue: kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly)
        public static let whenUnlocked = Self(keychainAttrValue: kSecAttrAccessibleWhenUnlocked)
        public static let whenUnlockedThisDeviceOnly = Self(keychainAttrValue: kSecAttrAccessibleWhenUnlockedThisDeviceOnly)
    }
}

extension Keychain {
    public struct Error: Swift.Error {
        let status: OSStatus
    }
}
