//
//  SoundboardView.swift
//  Soundboard
//
//  Created by Pawel Milek on 10/25/23.
//

import SwiftUI
import RealmSwift

struct SoundboardView: View {
    @Environment(\.requestReview) private var requestReview
    @EnvironmentObject private var viewModel: SoundboardViewModel

    var body: some View {
        SoundboardSearchResults()
            .searchable(
                text: $viewModel.searchText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: viewModel.searchPrompt
            )
            .searchSuggestions {
                if viewModel.searchText.isEmpty {
                    SoundSearchSuggestions()
                }
            }
            .textInputAutocapitalization(.never)
            .onReceive(viewModel.$shouldRequestReview) { shouldRequestReview in
                if shouldRequestReview {
                    requestReview()
                }
            }
    }
}

#Preview {
    NavigationStack {
        SoundboardView()
            .injectDependencies()
    }
}
