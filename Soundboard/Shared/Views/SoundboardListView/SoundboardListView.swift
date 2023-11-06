//
//  SoundboardListView.swift
//  Soundboard
//
//  Created by Pawel Milek on 10/25/23.
//

import SwiftUI
import Combine
import RealmSwift

struct SoundboardListView: View {
    @EnvironmentObject var realmManager: RealmManager
    @ObservedObject var viewModel: SoundboardListView.ViewModel

    var body: some View {
        Group {
            if viewModel.showContentUnavailableView {
                ContentUnavailableView(
                    viewModel.contentUnavailableTitle,
                    systemImage: viewModel.contentUnavailableSymbol,
                    description: Text(viewModel.contentUnavailableDescription)
                )
            } else {
                List(viewModel.searchResult) { sound in
                    SoundRowView(
                        item: sound,
                        shareContent: viewModel.shareSound(sound.fileName),
                        onPlayButton: {
                            viewModel.play(sound.fileName)
                        }
                    )
                }
                .animation(.default, value: viewModel.searchResult)
                .listStyle(.plain)
            }
        }
        .animation(.default, value: viewModel.searchResult)
        .listStyle(.plain)
        .searchable(
            text: $viewModel.searchText,
            placement: .navigationBarDrawer(displayMode: .always)
        ) {
            ForEach(viewModel.searchResult) { item in
                Text(item.title)
                    .searchResultStyle()
                    .searchCompletion(item.title)
            }
        }
        .textInputAutocapitalization(.never)
        .toolbar {
            favoritesToolbarButton
        }
        .onAppear {
            viewModel.setupObserver(realmManager.realm)
        }
    }
}

private extension SoundboardListView {

    var favoritesToolbarButton: some View {
        Button {
            viewModel.toggleFavorites()
        } label: {
            Image(systemName: viewModel.favoriteToolbarSymbol)
                .foregroundColor(viewModel.toolbarItemFavoritesColor)
        }
        .popoverTip(viewModel.favoritesTip, arrowEdge: .top)
    }

}

#Preview {
    NavigationStack {
        SoundboardListView(viewModel: SoundboardListView.ViewModel())
            .navigationTitle("Soundboard")
            .environmentObject(RealmManager(name: "stonoga.soundboard"))
    }
}
