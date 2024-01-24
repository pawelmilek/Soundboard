//
//  SoundboardView.swift
//  Soundboard
//
//  Created by Pawel Milek on 10/25/23.
//

import SwiftUI
import RealmSwift

struct SoundboardView: View {
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var realmManager: RealmManager
    @EnvironmentObject private var viewModel: SoundboardViewModel

    var body: some View {
        SoundboardSearchResults()
            .environmentObject(viewModel)
            .navigationTitle(viewModel.navigationTitle)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: navigateToInfo) {
                        Image(systemName: viewModel.infoToolbarSymbol)
                    }
                }
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
            .searchable(
                text: $viewModel.searchText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: viewModel.searchPrompt
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

    private func navigateToInfo() {
        router.navigate(to: .info)
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
    NavigationStack {
        SoundboardView()
            .environmentObject(RealmManager(name: "stonoga.soundboard"))
            .environmentObject(SoundboardViewModel())
    }
}
