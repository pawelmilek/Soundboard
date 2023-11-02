//
//  StonogaSoundboardApp.swift
//  StonogaSoundboard
//
//  Created by Pawel Milek on 10/25/23.
//

import SwiftUI
import TipKit

@main
struct StonogaSoundboardApp: App {
    @StateObject private var viewModel = SoundboardListView.ViewModel()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                SoundboardListView()
                    .navigationTitle("Soundboard")
                    .environmentObject(viewModel)
                    .environment(\.realmConfiguration, RealmManager.shared.realm.configuration)
            }
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
        RealmManager.shared.debugPrintRealmFileURL()
    }
}
