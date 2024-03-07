//
//  TipConfigurationViewModifier.swift
//  Soundboard
//
//  Created by Pawel Milek on 1/24/24.
//  Copyright © 2024 Pawel Milek. All rights reserved.
//

import SwiftUI
import TipKit

struct TipConfigurationViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .task {
                configureTip()
            }
    }

    private func configureTip() {
//        try? Tips.resetDatastore()
        try? Tips.configure([
            .datastoreLocation(.applicationDefault),
            .displayFrequency(.immediate)
        ])
    }
}

extension View {
    func soundboardTipConfiguration() -> some View {
        modifier(TipConfigurationViewModifier())
    }
}
