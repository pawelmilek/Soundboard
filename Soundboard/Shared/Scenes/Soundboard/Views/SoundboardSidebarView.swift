//
//  SoundboardSidebarView.swift
//  Soundboard
//
//  Created by Pawel Milek on 2/16/24.
//  Copyright © 2024 Pawel Milek. All rights reserved.
//

import SwiftUI

struct SoundboardSidebarView: View {
    @EnvironmentObject private var viewModel: SoundboardViewModel
    @Binding var selectedSound: SoundModel?

    var body: some View {
        List(viewModel.searchResult, selection: $selectedSound) { sound in
            SoundboardPadRow(item: sound)
                .tag(sound)
        }
    }
}

#Preview {
    SoundboardSidebarView(selectedSound: .constant(SoundModel.example.first!))
        .environmentObject(
            SoundboardViewModel(
                player: SoundPlayer(),
                shareContentProvider: ShareContentProvider(),
                realm: RealmManager.previewRealm
            )
        )
}
