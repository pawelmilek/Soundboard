//
//  SoundboardView.swift
//  Soundboard
//
//  Created by Pawel Milek on 10/25/23.
//

import SwiftUI
import RealmSwift
import TipKit

struct SoundboardView: View {
    @Environment(\.requestReview) private var requestReview
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var realmManager: RealmManager
    @EnvironmentObject private var viewModel: SoundboardViewModel

    var body: some View {
        SoundboardSearchResults()
            .environmentObject(viewModel)
            .navigationTitle(viewModel.navigationTitle)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    informationToolbarItem
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        sortToolbarMenu
                        favoritesToolbarItem
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
            .onReceive(viewModel.$shouldRequestReview) { shouldRequestReview in
                if shouldRequestReview {
                    requestReview()
                }
            }
            .onAppear {
                viewModel.onViewDidAppear(realmManager)
            }
    }

    private func navigateToInfo() {
        router.navigate(to: .info)
    }
}

private extension SoundboardView {

    var informationToolbarItem: some View {
        Button(action: navigateToInfo) {
            Image(systemName: viewModel.infoToolbarSymbol)
        }
        .popoverTip(viewModel.informationTip, arrowEdge: .top)
    }

    var sortToolbarMenu: some View {
        Menu("Sort By", systemImage: viewModel.sortToolbarSymbol) {
            Picker("Select sort order", selection: $viewModel.selectedSortOrder) {
                ForEach(SoundboardSortOrder.allCases) { item in
                    Text(item.description)
                        .tag(item)
                }
            }
        }
    }

    var favoritesToolbarItem: some View {
        Button {
            viewModel.toggleFavorites()
        } label: {
            Image(systemName: viewModel.favoriteToolbarSymbol)
                .foregroundColor(viewModel.toolbarItemFavoritesColor)
        }
    }

}

#Preview {
    NavigationStack {
        SoundboardView()
            .environmentObject(Router())
            .environmentObject(RealmManager(name: "stonoga.soundboard"))
            .environmentObject(SoundboardViewModel())
    }
}
