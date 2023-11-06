//
//  SoundboardListView+ViewModel.swift
//  Soundboard
//
//  Created by Pawel Milek on 10/25/23.
//

import Foundation
import SwiftUI
import RealmSwift

extension SoundboardListView {
    @MainActor
    final class ViewModel: NSObject, ObservableObject {
        @Published var items: Results<SoundModel>?
        @Published var showFavoritesOnly = false
        @Published var searchText = ""

        var showContentUnavailableView: Bool {
            searchResult.isEmpty
        }

        var searchResult: [SoundModel] {
            return if searchText.isEmpty {
                itemsArray
                    .sorted { $0.title < $1.title }
            } else {
                itemsArray
                    .filter { $0.title.lowercased().contains(searchText.lowercased()) }
                    .sorted { $0.title < $1.title }
            }
        }

        private var itemsArray: [SoundModel] {
            if let items, !items.isEmpty {
                return Array(items).filter { !showFavoritesOnly || $0.isFavorite }
            } else {
                return []
            }
        }

        var contentUnavailableTitle: String {
            return if searchText.isEmpty {
                "No Favorites available"
            } else {
                "No sound bites found for \(searchText)"
            }
        }

        var contentUnavailableSymbol: String {
            "music.note.list"
        }

        var contentUnavailableDescription: String {
            return if searchText.isEmpty {
                "Add sound bits to favorit"
            } else {
                "Try to search for a different phrase"
            }
        }

        var favoriteToolbarSymbol: String {
            showFavoritesOnly ? "heart.fill" : "heart"
        }

        var toolbarItemFavoritesColor: Color {
            showFavoritesOnly ? .accentColor : .gray
        }

        let favoritesTip = FavoritesSoundTip()
        private var itemsToken: NotificationToken?
        private let player: PlayerProtocol
        private let shareContentProvider: ShareContentProvider

        init(player: PlayerProtocol = SoundPlayer(),
             shareContentProvider: ShareContentProvider = ShareContentProvider()) {
            self.player = player
            self.shareContentProvider = shareContentProvider
        }

        func setupObserver(_ realm: Realm?) {
            let observedItems = realm?.objects(SoundModel.self)
            itemsToken = observedItems?.observe { [weak self] _ in
                self?.items = observedItems
            }
        }

        func toggleFavorites() {
            showFavoritesOnly.toggle()
        }

        func play(_ fileName: String) {
            player.playSound(fileName)
        }

        func shareSound(_ fileName: String) -> ShareContent {
            guard let itemToShare = items?.first(where: { $0.fileName == fileName }) else {
                return ShareContent.default
            }

            let content = shareContentProvider.content(
                with: itemToShare.title,
                image: "portrait",
                fileName
            )
            return content
        }
    }
}
