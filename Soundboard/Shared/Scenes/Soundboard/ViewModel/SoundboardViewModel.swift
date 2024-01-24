//
//  SoundboardViewModel.swift
//  Soundboard
//
//  Created by Pawel Milek on 10/25/23.
//

import SwiftUI
import RealmSwift
import Combine

@MainActor
final class SoundboardViewModel: NSObject, ObservableObject {
    @Published var items: Results<SoundModel>?
    @Published var showFavoritesOnly = false
    @Published var searchText = ""
    @Published var selectedSortOrder = SoundboardSortOrder.title

    var showContentUnavailableView: Bool {
        searchResult.isEmpty
    }

    var searchResult: [SoundModel] {
        return if searchText.isEmpty {
            itemsArray
        } else {
            itemsArray
                .filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
    }

    private var itemsArray: [SoundModel] {
        if let items, !items.isEmpty {
            return Array(items).filter { !showFavoritesOnly || $0.isFavorite }
        } else {
            return []
        }
    }

    var navigationTitle: String {
        "Soundboard"
    }

    var contentUnavailableTitle: String {
        return if searchText.isEmpty {
            "No Favorites available"
        } else {
            "No sounds found for \(searchText)"
        }
    }

    var contentUnavailableSymbol: String {
        "music.note.list"
    }

    var contentUnavailableDescription: String {
        return if searchText.isEmpty {
            "Add sounds to favorite"
        } else {
            "Try to search for a different phrase"
        }
    }

    var searchPrompt: String {
        "Search for a sound"
    }

    var infoToolbarSymbol: String {
        "info.circle"
    }

    var sortToolbarSymbol: String {
        "arrow.up.arrow.down"
    }

    var favoriteToolbarSymbol: String {
        showFavoritesOnly ? "heart.fill" : "heart"
    }

    var toolbarItemFavoritesColor: Color {
        .accentColor
    }

    let favoritesTip = FavoritesSoundTip()
    private var realmManager: RealmManager?
    private var cancallables = Set<AnyCancellable>()
    private var itemsToken: NotificationToken?
    private let player: PlayerProtocol
    private let shareContentProvider: ShareContentProvider

    init(
        player: PlayerProtocol = SoundPlayer(),
        shareContentProvider: ShareContentProvider = ShareContentProvider()
    ) {
        self.player = player
        self.shareContentProvider = shareContentProvider
        super.init()

        $selectedSortOrder
            .sink { [weak self] selectedSortOrder in
                self?.updateSortOrder(selectedSortOrder)
            }
            .store(in: &cancallables)
    }

    func onViewDidAppear(_ realmManager: RealmManager) {
        self.realmManager = realmManager
        setupObserver()
    }

    private func setupObserver() {
        let observedItems = realmManager?.realm?.objects(SoundModel.self)
        itemsToken = observedItems?.observe { [weak self] _ in
            guard let self else { return }
            items = observedItems?.sorted(
                byKeyPath: selectedSortOrder.keyPath,
                ascending: selectedSortOrder.ascending
            )
        }
    }

    private func updateSortOrder(_ selectedSortOrder: SoundboardSortOrder) {
        items = realmManager?.realm?.objects(SoundModel.self).sorted(
            byKeyPath: selectedSortOrder.keyPath,
            ascending: selectedSortOrder.ascending
        )
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
