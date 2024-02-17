//
//  SoundboardSearchResults.swift
//  Soundboard
//
//  Created by Pawel Milek on 11/22/23.
//  Copyright © 2024 Pawel Milek. All rights reserved.
//

import SwiftUI

struct SoundboardSearchResults: View {
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var viewModel: SoundboardViewModel
    @Environment(\.isSearching) private var isSearching: Bool
    @State private var columnVisibility = NavigationSplitViewVisibility.doubleColumn

    private var isPhone: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }

    var body: some View {
    NavigationSplitView(columnVisibility: $columnVisibility) {
            Group {
                if isPhone {
                    SoundboardList()
                } else {
                    SoundboardSidebarView(selectedSound: $router.selectedSound)
                }
            }
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
        } detail: {
            if let selectedSound = router.selectedSound {
                SoundDetailView(
                    item: selectedSound,
                    shareContent: viewModel.shareSound(selectedSound.fileName)
                ) {
                    viewModel.play(selectedSound.fileName)
                }
            } else if isSearching && viewModel.showContentUnavailableView {
                ContentUnavailableView(
                    viewModel.contentUnavailableTitle,
                    systemImage: viewModel.contentUnavailableSymbol,
                    description: Text(viewModel.contentUnavailableDescription)
                )
            } else {
                ContentUnavailableView(
                    "Use sidebar navigation",
                    systemImage: "sidebar.left"
                )
            }
        }
        .navigationSplitViewStyle(.balanced)
        .animation(.default, value: viewModel.searchResult)
        .listStyle(.plain)
        .overlay {
            ContentUnavailableView(
                viewModel.contentUnavailableTitle,
                systemImage: viewModel.contentUnavailableSymbol,
                description: Text(viewModel.contentUnavailableDescription)
            )
            .opacity(isPhone && isSearching && viewModel.showContentUnavailableView ? 1 : 0)
        }
        .sheet(item: $router.selectRoute) { _ in
            NavigationStack {
                InformationView()
            }
        }
    }

    private func navigateToInfo() {
        router.navigate(to: .info)
    }
}

private extension SoundboardSearchResults {

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
    SoundboardSearchResults()
        .injectDependencies()
}
