//
//  StonogaSoundboardApp.swift
//  StonogaSoundboard
//
//  Created by Pawel Milek on 10/25/23.
//

import SwiftUI

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
            .onAppear {
                viewModel.load()
                debugPrintRealmFileURL()
            }
        }
    }

    private func debugPrintRealmFileURL() {
        let realmURLAbsoluteString = RealmManager.shared.fileURL?.absoluteString ?? "Invalid Reference"
        debugPrint("Realm file URL: \(realmURLAbsoluteString)")
    }
}
