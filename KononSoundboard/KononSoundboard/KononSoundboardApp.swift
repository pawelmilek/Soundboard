//
//  KononSoundboardApp.swift
//  KononSoundboard
//
//  Created by Pawel Milek on 10/29/23.
//

import SwiftUI

@main
struct KononSoundboardApp: App {
//    @StateObject private var viewModel = SoundboardListView.ViewModel()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
                    .navigationTitle("Soundboard")
//                    .environmentObject(viewModel)
//                    .environment(\.realmConfiguration, RealmManager.shared.realm.configuration)
            }
            .onAppear {
    //            viewModel.load()
    //            debugPrintRealmFileURL()
            }
        }
    }

    private func debugPrintRealmFileURL() {
//        RealmManager.shared.debugPrintRealmFileURL()
    }
}
