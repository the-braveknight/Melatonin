//
//  CheckmarkToggleStyle.swift
//  Example
//
//  Created by Zaid Rahhawi on 16/06/2024.
//

import SwiftUI

struct CheckmarkToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
        }
        .buttonStyle(.plain)
    }
}

extension ToggleStyle where Self == CheckmarkToggleStyle {
    static var checkmark: Self {
        CheckmarkToggleStyle()
    }
}
