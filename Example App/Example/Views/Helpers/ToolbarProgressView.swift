//
//  ToolbarProgressView.swift
//  Example
//
//  Created by Zaid Rahhawi on 12/24/24.
//

import SwiftUI

struct ToolbarProgressView: ToolbarContent {
    let isShown: Bool
    
    var body: some ToolbarContent {
        if isShown {
            ToolbarItem(placement: .topBarTrailing) {
                ProgressView()
            }
        }
    }
}
