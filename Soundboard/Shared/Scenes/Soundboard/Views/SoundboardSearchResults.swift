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
    @State private var selectedSoundId: String?

    var body: some View {
        NavigationSplitView {
            if UIDevice.current.userInterfaceIdiom == .phone {
                SoundboardPhoneList()
            } else {
                SoundboardPadList(selectedSoundId: $selectedSoundId)
            }

        } detail: {
            if let selectedSoundId {
                Text("Selected sound bit \(selectedSoundId)")
            } else {
                ContentUnavailableView("Use sidebar navigation", systemImage: "sidebar.left")
            }

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
