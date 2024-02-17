//
//  SoundboardApp.swift
//  Soundboard
//
//  Created by Pawel Milek on 11/3/23.
//

import SwiftUI
import TipKit

@main
struct SoundboardApp: App {
    var body: some Scene {
        WindowGroup {
            SoundboardNavigationStack()
                .injectDependencies()
                .soundboardTipConfiguration()
        }
    }
}
