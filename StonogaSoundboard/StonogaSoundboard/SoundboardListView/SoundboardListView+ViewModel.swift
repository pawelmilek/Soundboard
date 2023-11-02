//
//  SoundboardListView+ViewModel.swift
//  StonogaSoundboard
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

        var searchResult: [SoundModel] {
            return if searchText.isEmpty {
                itemsArray
            } else {
                itemsArray.filter { $0.title.lowercased().contains(searchText.lowercased()) }
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

        private var itemsToken: NotificationToken?
        private let repository: Repository
        private var player: PlayerProtocol

        init(
            repository: Repository = SoundRepository(),
            player: PlayerProtocol = SoundPlayer()
        ) {
            self.repository = repository
            self.player = player
            super.init()
            setupObserver()
        }

        private func setupObserver() {
            let realm = RealmManager.shared.realm
            let observedItems = realm.objects(SoundModel.self)
            itemsToken = observedItems.observe { [weak self] _ in
                self?.items = observedItems
            }
        }

        func load() {
            repository.load()
        }

        func toggleFavorites() {
            showFavoritesOnly.toggle()
        }

        func play(_ fileName: String) {
            player.playSound(fileName)
        }
    }
}
