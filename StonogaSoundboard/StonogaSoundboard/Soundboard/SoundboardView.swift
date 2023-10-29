//
//  ContentView.swift
//  StonogaSoundboard
//
//  Created by Pawel Milek on 10/25/23.
//

import SwiftUI
import Combine

struct SoundboardView: View {
    @EnvironmentObject var viewModel: SoundboardView.ViewModel

    var body: some View {
        Group {
            if viewModel.searchResults.isEmpty {
                ContentUnavailableView(
                    viewModel.contentUnavailableTitle,
                    systemImage: viewModel.contentUnavailableSymbol,
                    description: Text(viewModel.contentUnavailableDescription)
                )
            } else {
                List(viewModel.searchResults) { sound in
                    SoundRowView(viewModel: SoundRowView.ViewModel(model: sound))
                        .listRowSeparator(.hidden)
                }
                .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/, value: viewModel.showFavoritesOnly)
                .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/, value: viewModel.showSortOnly)
                .listStyle(.plain)
            }
        }
        .searchable(text: $viewModel.searchText)
        .toolbar {
            ToolbarItem {
                Button {
                    viewModel.toggleSortAscending()
                } label: {
                    Image(systemName: viewModel.sortToolbarSymbol)
                        .foregroundColor(viewModel.toolbarItemSortColor)
                }
            }
            ToolbarItem {
                Button {
                    viewModel.toggleFavorites()
                } label: {
                    Image(systemName: viewModel.favoriteToolbarSymbol)
                        .foregroundColor(viewModel.toolbarItemFavoritesColor)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        SoundboardView()
        .navigationTitle("Soundboard")
        .environmentObject(SoundboardView.ViewModel())
    }
}
