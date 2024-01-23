//
//  SoundboardView.swift
//  Soundboard
//
//  Created by Pawel Milek on 10/25/23.
//

import SwiftUI
import RealmSwift

enum SoundboardSortOrder: String, Identifiable, CaseIterable, CustomStringConvertible {
    case title
    case playback

    var id: Self { self }
    var description: String {
        switch self {
        case .title:
            "Title"
        case .playback:
            "Playback"
        }
    }

    var keyPath: String  {
        switch self {
        case .title:
            "title"

        case .playback:
            "playbackCount"
        }
    }

    var ascending: Bool {
        switch self {
        case .title:
            true

        case .playback:
            false
        }
    }
}

struct SoundboardView: View {
    @EnvironmentObject var realmManager: RealmManager
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        NavigationStack {
            SoundboardList()
                .environmentObject(viewModel)
                .navigationTitle("Soundboard")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack {
                            Menu("Sort By", systemImage: viewModel.sortToolbarSymbol) {
                                Picker("Select sort order", selection: $viewModel.selectedSortOrder) {
                                    ForEach(SoundboardSortOrder.allCases) { item in
                                        Text(item.description)
                                            .tag(item)
                                    }
                                }
                            }
                            favoritesToolbarButton
                        }
                    }
                }
        }
        .searchable(
            text: $viewModel.searchText,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "Search for a sound"
        ) {
            ForEach(viewModel.searchResult) { item in
                Text(item.title)
                    .searchResultStyle()
                    .searchCompletion(item.title)
            }
        }
        .textInputAutocapitalization(.never)
        .onAppear {
            viewModel.onViewDidAppear(realmManager)
        }
    }
}

private extension SoundboardView {

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
    SoundboardView(viewModel: SoundboardView.ViewModel())
        .environmentObject(RealmManager(name: "stonoga.soundboard"))
}
