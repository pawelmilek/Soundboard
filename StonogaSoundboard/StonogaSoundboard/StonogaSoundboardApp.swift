//
//  StonogaSoundboardApp.swift
//  StonogaSoundboard
//
//  Created by Pawel Milek on 10/25/23.
//

import SwiftUI

@main
struct StonogaSoundboardApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                SoundboardListView()
                    .navigationTitle("Soundboard")
                    .environment(\.realmConfiguration, RealmProvider.shared.realm.configuration)
            }
            .onAppear {
                debugPrintRealmFileURL()
            }
        }
    }

    private func debugPrintRealmFileURL() {
        let realmURLAbsoluteString = RealmProvider.shared.fileURL?.absoluteString ?? "Invalid Reference"
        debugPrint("Realm file URL: \(realmURLAbsoluteString)")
    }
}
