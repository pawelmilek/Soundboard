//
//  SoundboardView.swift
//  Soundboard
//
//  Created by Pawel Milek on 10/25/23.
//

import SwiftUI
import RealmSwift

struct SoundboardView: View {
    @EnvironmentObject var realmManager: RealmManager
    @ObservedObject var viewModel: SoundboardViewModel

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
        .soundboardRequestReview()
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
    SoundboardView(viewModel: SoundboardViewModel())
        .environmentObject(RealmManager(name: "stonoga.soundboard"))
}
