//
//  InjectDependenciesViewModifier.swift
//  Soundboard
//
//  Created by Pawel Milek on 2/19/24.
//  Copyright © 2024 Pawel Milek. All rights reserved.
//

import SwiftUI

struct InjectDependenciesViewModifier: ViewModifier {
    @StateObject private var router = Router()
    @StateObject private var realmManager = RealmManager(name: "soundboard")
    @StateObject private var viewModel = SoundboardViewModel()

    func body(content: Content) -> some View {
        content
            .environment(\.realmConfiguration, realmManager.realm!.configuration)
            .environmentObject(viewModel)
            .environmentObject(realmManager)
            .environmentObject(router)
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
