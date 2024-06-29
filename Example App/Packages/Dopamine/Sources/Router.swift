//
//  Router.swift
//  Router
//
//  Created by Zaid Rahhawi on 29/06/2024.
//

import Observation
import SwiftUI

// MARK - Router Protocol
@MainActor public protocol Router: AnyObject & Observable {
    associatedtype Tab: Hashable & CaseIterable
    associatedtype Route: Hashable & Identifiable
    associatedtype View: SwiftUI.View
    
    /// Currently presented sheet (modal).
    /// For use with view 'withRouterSheets(_:)' view modifier.
    var currentSheet: Route? { get set }
    
    /// Currently selected tab.
    /// For use with TabView(selection:) view modifier.
    var currentTab: Tab { get set }
    
    /// A dictionary that holds a navigation path for each selected tab.
    /// For use with NavigationStack(path:) and 'withRouterDestinations(_:) view modifier.
    var navigationPath: [Tab: NavigationPath] { get set }
    
    /// The preferred tab to be selected for a given route.
    func preferredTab(for route: Route) -> Tab
    
    /// A method that builds a view for each route.
    @ViewBuilder func makeView(for route: Route, mode: RoutingMode) -> View
    
    /// Opens (selects) a tab.
    func open(tab: Tab)
    
    /// Opens (presents or navigates to) a route.
    func open(route: Route, mode: RoutingMode)
}

public extension Router {
    func open(tab: Tab) {
        self.currentTab = tab
    }
    
    func open(route: Route, mode: RoutingMode) {
        switch mode {
        case .sheet:
            self.currentSheet = route
        case .navigation:
            let tab = preferredTab(for: route)
            if self.navigationPath[tab] == nil {
                self.navigationPath[tab] = NavigationPath([route])
            } else {
                self.navigationPath[tab]?.append(route)
            }
            
            open(tab: tab)
        }
    }
}
