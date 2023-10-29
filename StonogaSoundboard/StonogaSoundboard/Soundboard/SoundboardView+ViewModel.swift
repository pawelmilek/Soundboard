//
//  SoundboardView+ViewModel.swift
//  StonogaSoundboard
//
//  Created by Pawel Milek on 10/25/23.
//

import Foundation
import SwiftUI
import AVFoundation

extension SoundboardView {
    final class ViewModel: NSObject, ObservableObject, AVAudioPlayerDelegate {
        @Published var isPlaying = false
        @Published var showFavoritesOnly = false
        @Published var showSortOnly = false
        @Published var models: [SoundModel]
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

        var sortToolbarSymbol: String {
            showSortOnly ? "arrowshape.down.fill" : "arrowshape.down"
        }

        var favoriteToolbarSymbol: String {
            showFavoritesOnly ? "heart.fill" : "heart"
        }

        var toolbarItemSortColor: Color {
            showSortOnly ? .accentColor : .gray
        }

        var toolbarItemFavoritesColor: Color {
            showFavoritesOnly ? .accentColor : .gray
        }

        var searchResults: [SoundModel] {
            if searchText.isEmpty {
                return result
            } else {
                let result = result
                    .filter {
                        $0.fileName.replacingOccurrences(of: "-", with: " ")
                            .contains(searchText.lowercased())
                    }
                return result
            }
        }

        private var result: [SoundModel] {
            return if showSortOnly {
                sortedByPlaybackCount
            } else {
                filteredByFavorites
            }
        }

        private var filteredByFavorites: [SoundModel] {
            let result = models
                .filter { !showFavoritesOnly || $0.isFavorite }
                .sorted { $0.fileName < $1.fileName }
            return result
        }

        private var sortedByPlaybackCount: [SoundModel] {
            let result = models
                .sorted { $0.playbackCount > $1.playbackCount }
            return result
        }

        private let repository: Repository
        private var player: PlayerProtocol

        init(
            repository: Repository = SoundRepository(),
            player: PlayerProtocol = SoundPlayer()
        ) {
            self.repository = repository
            self.models = Array(repository.load())
            self.player = player
        }

        func playStop(_ name: String, from: Bool, to: Bool) {
            let index = soundIndex(with: name)
            let isReadyToPaly = models[index].isPlaying
//            stopPlayingAllOtherThen(name)
            if isReadyToPaly && from == false {
                playSound(name)
            } else {
                stopSound(name)
            }
        }

        private func stopPlayingAllOtherThen(_ name: String) {
            let readyToStop = models.filter({ $0.isPlaying == false })
            readyToStop.forEach { item in
                if item.fileName != name {
                    stopSound(item.fileName)
                }
            }
        }

        func playSound(_ name: String) {
            player.delegate = self
            player.playSound(name)
            updatePlaybackCounter(with: name)
        }

        func stopSound(_ name: String) {
            let index = soundIndex(with: name)
            let isReadyToStop = (models[index].isPlaying == false)

            if isReadyToStop {
                player.stopSound()
                debugPrint("Stop: \(models[index].fileName) isPlaying: \(models[index].isPlaying)")
            }
        }

        private func findName(with name: String) -> String {
            let index = soundIndex(with: name)
            let name = models[index].fileName
            return name
        }

        private func updatePlaybackCounter(with name: String) {
            let index = soundIndex(with: name)
            models[index].playbackCount += 1
            save()
        }

        func save() {
            repository.save(Set(models))
        }

        func toggleSortAscending() {
            showSortOnly.toggle()
            showFavoritesOnly = false
        }

        func toggleFavorites() {
            showFavoritesOnly.toggle()
            showSortOnly = false
        }

        func soundIndex(with name: String) -> Int {
            guard let index = models.firstIndex(where: { $0.fileName == name }) else {
                fatalError()
            }

            return index
        }

        func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
            guard let fileName = soundName(from: player.url) else { return }
            forceToUpdatePlayStopSymbol(for: fileName)
        }

        private func soundName(from url: URL?) -> String? {
            guard let fileName = url?.deletingPathExtension().lastPathComponent else { return nil }
            return fileName
        }

        private func forceToUpdatePlayStopSymbol(for name: String) {
            guard let index = models.firstIndex(where: { $0.fileName == name }) else { return }
            models[index].isPlaying = false
        }
    }
}
