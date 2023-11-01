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
    @StateObject private var viewModel = SoundboardListView.ViewModel()
    @ObservedResults(SoundModel.self) private var items

    var body: some View {
        Group {
            if items.isEmpty {
                ContentUnavailableView(
                    viewModel.contentUnavailableTitle,
                    systemImage: viewModel.contentUnavailableSymbol,
                    description: Text(viewModel.contentUnavailableDescription)
                )
            } else {
                List(items.sorted(byKeyPath: "title")) { sound in
                    SoundRowView(item: sound)
                        .listRowSeparator(.hidden)
                        .environmentObject(viewModel)
                }
                .animation(.default, value: items)
                .listStyle(.plain)
            }
        }
        .searchable(
            text: $viewModel.searchText,
            collection: $items,
            keyPath: \.title,
            placement: .navigationBarDrawer(displayMode: .always)
        ) {
                ForEach(items) { item in
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
            .onChange(of: viewModel.showFavoritesOnly) {
                $items.filter = viewModel.showFavoritesOnly ? NSPredicate(
                    format: "isFavorite == %@",
                    NSNumber(value: viewModel.showFavoritesOnly)
                ) : nil
            }
            .onAppear {
                viewModel.load()
            }
    }
}

#Preview {
    NavigationStack {
        SoundboardListView()
            .navigationTitle("Soundboard")
    }
}
