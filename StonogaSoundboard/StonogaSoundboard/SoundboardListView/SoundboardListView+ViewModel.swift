//
//  SoundboardListView+ViewModel.swift
//  StonogaSoundboard
//
//  Created by Pawel Milek on 10/25/23.
//

import Foundation
import SwiftUI
import Combine
import RealmSwift
import AVFAudio

extension SoundboardListView {
    @MainActor
    final class ViewModel: NSObject, ObservableObject, AVAudioPlayerDelegate {
        @Published var showFavoritesOnly = false
        @Published var searchText = ""

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

        private var cancellables = Set<AnyCancellable>()
        private let repository: Repository
        var player: PlayerProtocol

        init(
            repository: Repository = SoundRepository(),
            player: PlayerProtocol = SoundPlayer()
        ) {
            self.repository = repository
            self.player = player
            super.init()
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
