//
//  SoundRowView+ViewModel.swift
//  StonogaSoundboard
//
//  Created by Pawel Milek on 10/25/23.
//

import Foundation
import AVFoundation
import SwiftUI

extension SoundRowView {
    @MainActor
    final class ViewModel: ObservableObject {
        @Published private(set) var portraitName = "stonoga"
        @Published private(set) var title = ""
        @Published private(set) var fileName = ""
        @Published private(set) var playbackCount = 0
        @Published private(set) var isFavorite = false
        @Published private(set) var audioURL: URL?
        @Published var model: SoundModel

        var shareSound: ShareContentModel {
            do {
                let url = try soundFileManager.audioURL(for: model.fileName)
                return ShareContentModel(url: url, preview: (model.title, portraitName))
            } catch {
                fatalError(error.localizedDescription)
            }
        }

        private let soundFileManager: FileManagerProtocol
        private var player: PlayerProtocol

        init(
            model: SoundModel = SoundModel(),
            player: PlayerProtocol = SoundPlayer(),
            soundFileManager: FileManagerProtocol = SoundFileManager()
        ) {
            self.model = model
            self.player = player
            self.soundFileManager = soundFileManager
            self.audioURL = nil
        }

        func onAppear(_ model: SoundModel) {
            onChange(model)
        }

        func onChange(_ model: SoundModel) {
            self.model = model
            fileName = model.fileName
            title = model.title
            playbackCount = model.playbackCount
            isFavorite = model.isFavorite
            audioURL = try? soundFileManager.audioURL(for: fileName)
        }
    }
}
