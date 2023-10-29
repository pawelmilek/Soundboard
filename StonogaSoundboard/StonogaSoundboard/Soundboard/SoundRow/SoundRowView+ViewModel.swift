//
//  SoundRowView+ViewModel.swift
//  StonogaSoundboard
//
//  Created by Pawel Milek on 10/25/23.
//

import Foundation
import SwiftUI
import AVFoundation

extension SoundRowView {
    final class ViewModel: ObservableObject {
        @Published var title: String
        @Published var isFavorite: Bool
        @Published var isPlaying: Bool
        @Published var playbackCount: Int
        @Published var fileName: String

        var favoriteSymbolColor: Color {
            isFavorite ? .accentColor : .gray
        }

        var shareSound: ShareContentModel {
            do {
                let url = try soundFileManager.findURL(for: model.fileName)
                return ShareContentModel(url: url, preview: (model.fileName, "stonoga"))
            } catch {
                fatalError(error.localizedDescription)
            }
        }

        private let model: SoundModel
        private let soundFileManager: FileManagerProtocol

        init(
            model: SoundModel,
            soundFileManager: FileManagerProtocol = SoundFileManager()
        ) {
            self.model = model
            self.soundFileManager = soundFileManager
            title = model.fileName.replacingOccurrences(of: "-", with: " ")
            isFavorite = model.isFavorite
            isPlaying = model.isPlaying
            playbackCount = model.playbackCount
            fileName = model.fileName
        }
    }
}
