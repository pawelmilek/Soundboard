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
    @StateObject private var realmManager = RealmManager(name: "soundboard")
    @StateObject private var viewModel = SoundboardSearchView.ViewModel()

    var body: some Scene {
        WindowGroup {
            SoundboardSearchView(viewModel: viewModel)
                .environmentObject(viewModel)
                .environmentObject(realmManager)
                .environment(\.realmConfiguration, realmManager.realm!.configuration)
                .task {
                    configureTip()
                    debugPrintRealmFileURL()
                }
        }
    }

    private func configureTip() {
        try? Tips.configure([
            .datastoreLocation(.applicationDefault),
            .displayFrequency(.immediate)
        ])
    }

    private func debugPrintRealmFileURL() {
        realmManager.debugPrintRealmFileURL()
    }
}
