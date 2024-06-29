//
//  RouterSheetsViewModifier.swift
//  Router
//
//  Created by Zaid Rahhawi on 29/06/2024.
//

import SwiftUI

public struct RouterSheetsViewModifier<R: Router>: ViewModifier {
    public let router: R
        
    public init(router: R) {
        self.router = router
    }
    
    public func body(content: Content) -> some View {
        @Bindable var router = router
        
        content
            .sheet(item: $router.currentSheet) { route in
                router.makeView(for: route, mode: .sheet)
            }
    }
}

public extension View {
    func withRouterSheets<R: Router>(_ router: R) -> some View {
        modifier(RouterSheetsViewModifier(router: router))
    }
}
