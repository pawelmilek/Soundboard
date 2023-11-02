//
//  SoundboardListView.swift
//  StonogaSoundboard
//
//  Created by Pawel Milek on 10/25/23.
//

import SwiftUI
import Combine
import RealmSwift

struct SoundboardListView: View {
    @EnvironmentObject var viewModel: SoundboardListView.ViewModel

    var body: some View {
        Group {
            if viewModel.searchResult.isEmpty {
                ContentUnavailableView(
                    viewModel.contentUnavailableTitle,
                    systemImage: viewModel.contentUnavailableSymbol,
                    description: Text(viewModel.contentUnavailableDescription)
                )
            } else {
                List(viewModel.searchResult.sorted { $0.title < $1.title }) { sound in
                    SoundRowView(item: sound)
                        .listRowSeparator(.hidden)
                        .environmentObject(viewModel)
                }
                .animation(.default, value: viewModel.searchResult)
                .listStyle(.plain)
            }

        }
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
        SoundboardListView()
            .navigationTitle("Soundboard")
            .environmentObject(SoundboardListView.ViewModel())
    }
}
