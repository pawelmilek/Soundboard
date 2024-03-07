//
//  SoundboardViewModel.swift
//  Soundboard
//
//  Created by Pawel Milek on 10/25/23.
//
// swiftlint:disable switch_case_alignment

import SwiftUI
import RealmSwift
import Combine

@MainActor
final class SoundboardViewModel: NSObject, ObservableObject {
    @AppStorage("lastVersionPromptedForReview") private var lastVersionPromptedForReview = ""
    @AppStorage("soundboardSortOrder") private var soundboardSortOrder: SoundboardSortOrder = .title

    @Published var items: Results<SoundModel>?
    @Published var searchText = ""
    @Published var searchResult = [SoundModel]()
    @Published var selectedSortOrder = SoundboardSortOrder.title
    @Published var showFavoritesOnly = false
    @Published var shouldRequestReview = false
    @Published var showContentUnavailableView = false
    @Published var contentUnavailable: (title: String, description: String) = ("", "")
    @Published var favoriteToolbarSymbol = "heart"

    let navigationTitle = "Soundboard"
    let contentUnavailableSymbol = "music.note.list"
    let toolbarItemFavoritesColor = Color.accentColor
    let searchPrompt = "Search for a sound"
    let infoToolbarSymbol = "info.circle"
    let composerToolbarSymbol = "music.quarternote.3"
    let sortToolbarSymbol = "arrow.up.arrow.down"
    let informationTip = InformationTip()

    private var cancallables = Set<AnyCancellable>()
    private var itemsToken: NotificationToken?
    private var favoritesToken: NotificationToken?
    private let player: PlayerProtocol
    private let shareContentProvider: ShareContentProvider
    private let realm: Realm?

    init(
        player: PlayerProtocol,
        shareContentProvider: ShareContentProvider,
        realm: Realm?
    ) {
        self.player = player
        self.shareContentProvider = shareContentProvider
        self.realm = realm
        super.init()
        selectedSortOrder = soundboardSortOrder
        setupSubscribers()
        setupNotificationTokenObserver()
    }

    private func setupSubscribers() {
        Publishers.CombineLatest4($items, $searchText, $selectedSortOrder, $showFavoritesOnly)
            .sink { [weak self] items, searchText, selectedSortOrder, showFavoritesOnly in
                guard let self, let items else { return }

                let sounds = Array(items)
                    .filter { !showFavoritesOnly || $0.isFavorite }
                    .sorted { lhs, rhs in
                        return  switch selectedSortOrder {
                        case .title: lhs.title < rhs.title
                        case .playback: lhs.playbackCount > rhs.playbackCount
                        }
                    }

                if searchText.isEmpty {
                    searchResult = sounds
                } else {
                    searchResult = sounds.filter {
                        $0.title.lowercased().contains(searchText.lowercased())
                    }
                }

                soundboardSortOrder = selectedSortOrder
                favoriteToolbarSymbol = showFavoritesOnly ? "heart.fill" : "heart"
                setContentUnavailableViewText(isSearchTextEmpty: searchText.isEmpty)
            }
            .store(in: &cancallables)

        $searchResult
            .sink { [weak self] searchResult in
                self?.showContentUnavailableView = searchResult.isEmpty
            }
            .store(in: &cancallables)
    }

    private func setupNotificationTokenObserver() {
        let observedItems = realm?.objects(SoundModel.self)
        itemsToken = observedItems?.observe { [weak self] _ in
            guard let self else { return }
            items = observedItems?.sorted(
                byKeyPath: selectedSortOrder.keyPath,
                ascending: selectedSortOrder.ascending
            )
        }

        favoritesToken = observedItems?.observe(keyPaths: [\SoundModel.isFavorite]) { [weak self] changes in
            guard let self else { return }
            switch changes {
            case .update(_, _, _, modifications: let modifications):
                if !modifications.isEmpty {
                    checkIfValidForReview()
                }
            default:
                break
            }
        }
    }

    private func checkIfValidForReview() {
        let favoriteSoundsCount = items?.filter(\.isFavorite).count ?? 0
        if RequestReviewRequirementsVerification.isRequestValid(
            favoriteCount: favoriteSoundsCount,
            lastVersionPromptedForReview: lastVersionPromptedForReview
        ) {
            lastVersionPromptedForReview = RequestReviewRequirementsVerification.appVersion
            presentReview()
        }
    }

    private func presentReview() {
        Task {
            try await Task.sleep(for: .seconds(0.3))
            shouldRequestReview = true
        }
    }

    private func setContentUnavailableViewText(isSearchTextEmpty: Bool) {
        if isSearchTextEmpty {
            contentUnavailable.title = "No Favorites available"
            contentUnavailable.description = "Add sounds to favorite"
        } else {
            contentUnavailable.title = "No sounds found for \(searchText)"
            contentUnavailable.description = "Try to search for a different phrase"
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
