//
//  InjectDependenciesViewModifier.swift
//  Soundboard
//
//  Created by Pawel Milek on 2/19/24.
//  Copyright © 2024 Pawel Milek. All rights reserved.
//

import SwiftUI

struct InjectDependenciesViewModifier: ViewModifier {
    @StateObject private var realmManager = RealmManager(name: "soundboard")

    func body(content: Content) -> some View {
        content
            .environment(\.realmConfiguration, realmManager.realm!.configuration)
            .environmentObject(realmManager)
            .environmentObject(SoundboardViewModel(
                player: SoundPlayer(),
                shareContentProvider: ShareContentProvider(),
                realm: realmManager.realm
            ))
            .environmentObject(Router())
            .task {
                realmManager.debugPrintRealmFileURL()
            }
    }
}

extension View {
    func injectDependencies() -> some View {
        modifier(InjectDependenciesViewModifier())
    }
}
