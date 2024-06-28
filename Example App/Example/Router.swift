//
//  Router.swift
//  Example
//
//  Created by Zaid Rahhawi on 27/06/2024.
//

import SwiftUI

@Observable
@MainActor
final class Router: Sendable {
    var currentTab: Tab = .users
}

enum Tab: String {
    case users, posts, todos
}
