//
//  SoundboardSearchResults.swift
//  Soundboard
//
//  Created by Pawel Milek on 11/22/23.
//

import SwiftUI

struct SoundboardSearchResults: View {
    @EnvironmentObject private var viewModel: SoundboardViewModel
    @Environment(\.isSearching) private var isSearching: Bool

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
        .animation(.default, value: viewModel.searchResult)
        .listStyle(.plain)
        .overlay {
            if isSearching && viewModel.showContentUnavailableView {
                ContentUnavailableView(
                    viewModel.contentUnavailableTitle,
                    systemImage: viewModel.contentUnavailableSymbol,
                    description: Text(viewModel.contentUnavailableDescription)
                )
            }
        }
    }
}

#Preview {
    SoundboardSearchResults()
        .environmentObject(SoundboardViewModel())
}
