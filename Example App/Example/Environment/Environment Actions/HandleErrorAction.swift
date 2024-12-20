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

extension EnvironmentValues {
    @Entry var handleError = HandleErrorAction(action: log)
}

private func log(_ error: Error) {
    print(error)
}
