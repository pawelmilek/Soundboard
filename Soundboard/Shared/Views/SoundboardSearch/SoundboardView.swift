//
//  SoundboardView.swift
//  Soundboard
//
//  Created by Pawel Milek on 10/25/23.
//

import SwiftUI

struct SoundboardView: View {
    @EnvironmentObject var realmManager: RealmManager
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        NavigationStack {
            SoundboardList()
                .environmentObject(viewModel)
                .navigationTitle("Soundboard")
                .toolbar {
                    favoritesToolbarButton
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
            viewModel.setupObserver(realmManager.realm)
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
