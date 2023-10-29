//
//  StonogaSoundboardApp.swift
//  StonogaSoundboard
//
//  Created by Pawel Milek on 10/25/23.
//

import SwiftUI

@main
struct StonogaSoundboardApp: App {
    @StateObject private var viewModel = SoundboardView.ViewModel()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                SoundboardView()
                    .navigationTitle("Soundboard")
            }
        }
        .environmentObject(viewModel)
    }
}
