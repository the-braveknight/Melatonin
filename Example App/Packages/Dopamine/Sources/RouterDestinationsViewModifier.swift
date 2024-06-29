//
//  RouterDestinationsViewModifier.swift
//  Router
//
//  Created by Zaid Rahhawi on 29/06/2024.
//

import SwiftUI

public struct RouterDestinationsViewModifier<R: Router>: ViewModifier {
    public let router: R
    
    public init(router: R) {
        self.router = router
    }
    
    public func body(content: Content) -> some View {
        content.navigationDestination(for: R.Route.self) { route in
            router.makeView(for: route, mode: .navigation)
        }
    }
}

public extension View {
    func withRouterDestinations<R: Router>(_ router: R) -> some View {
        modifier(RouterDestinationsViewModifier(router: router))
    }
}
