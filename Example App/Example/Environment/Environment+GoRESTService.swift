//
//  Environment+GoRESTService.swift
//  Example
//
//  Created by Zaid Rahhawi on 12/20/24.
//

import SwiftUI

extension EnvironmentValues {
    @Entry var service: GoRESTService = HTTPGoRESTService(session: .example)
}
