//
//  ContentLanguage.swift
//
//
//  Created by Zaid Rahhawi on 4/9/24.
//

import Foundation

@available(macOS 13, iOS 16, tvOS 16, watchOS 9, *)
public struct ContentLanguage: HTTPHeader {
    public let field: String = "Content-Language"
    public let languagePreferences: [LanguagePreference]
    
    public var value: String {
        languagePreferences.map(\.description).joined(separator: ",")
    }
    
    public init(_ languagePreferences: [LanguagePreference]) {
        self.languagePreferences = languagePreferences
    }
    
    public init(_ languagePreferences: LanguagePreference...) {
        self.init(languagePreferences)
    }
}

@available(macOS 13, iOS 16, tvOS 16, watchOS 9, *)
public extension HTTPCall {
    func contentLanguage(_ languagePreferences: [LanguagePreference]) -> ModifiedHTTPCall<Self, ContentLanguage> {
        modifier(ContentLanguage(languagePreferences))
    }
}
