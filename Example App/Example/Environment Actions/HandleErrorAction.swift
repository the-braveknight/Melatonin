//
//  HandleErrorAction.swift
//  Example
//
//  Created by Zaid Rahhawi on 22/06/2024.
//

import SwiftUI

struct HandleErrorAction {
    let action: (Error) -> Void
    
    func callAsFunction(_ error: Error) {
        action(error)
    }
}

struct HandleErrorActionKey: EnvironmentKey {
    static let defaultValue: HandleErrorAction = HandleErrorAction(action: log)
}

extension EnvironmentValues {
    var handleError: HandleErrorAction {
        get { self[HandleErrorActionKey.self] }
        set { self[HandleErrorActionKey.self] = newValue }
    }
}

private func log(_ error: Error) {
    print(error)
}
