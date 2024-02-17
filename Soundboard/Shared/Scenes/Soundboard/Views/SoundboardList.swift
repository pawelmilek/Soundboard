//
//  SoundboardList.swift
//  Soundboard
//
//  Created by Pawel Milek on 2/16/24.
//  Copyright © 2024 Pawel Milek. All rights reserved.
//

import SwiftUI

struct SoundboardList: View {
    @EnvironmentObject private var viewModel: SoundboardViewModel

    var body: some View {
        List(viewModel.searchResult) { sound in
            SoundboardRow(
                item: sound,
                shareContent: viewModel.shareSound(sound.fileName),
                onPlayButton: {
                    viewModel.play(sound.fileName)
                }
            )
        }
    }
}

#Preview {
    SoundboardList()
}
