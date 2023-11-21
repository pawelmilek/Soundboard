//
//  SoundboardList.swift
//  Soundboard
//
//  Created by Pawel Milek on 10/25/23.
//

import SwiftUI
import Combine
import RealmSwift

struct SoundboardList: View {
    @EnvironmentObject var realmManager: RealmManager
    @ObservedObject var viewModel: SoundboardList.ViewModel

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
                    SoundRow(
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

private extension SoundboardList {

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
        SoundboardList(viewModel: SoundboardList.ViewModel())
            .navigationTitle("Soundboard")
            .environmentObject(RealmManager(name: "stonoga.soundboard"))
    }
}
