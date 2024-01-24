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
    @StateObject private var router = Router()
    @StateObject private var realmManager = RealmManager(name: "soundboard")
    @StateObject private var viewModel = SoundboardViewModel()

    var body: some Scene {
        WindowGroup {
            SoundboardNavigationStack()
                .environment(\.realmConfiguration, realmManager.realm!.configuration)
                .environmentObject(viewModel)
                .environmentObject(realmManager)
                .environmentObject(router)
                .soundboardTipConfiguration()
                .task {
                    realmManager.debugPrintRealmFileURL()
                }
        }
    }
}
