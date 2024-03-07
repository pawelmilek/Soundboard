//
//  SoundComposer.swift
//  Soundboard
//
//  Created by Pawel Milek on 3/8/24.
//  Copyright © 2024 Pawel Milek. All rights reserved.
//

import AVFoundation

@MainActor
final class SoundComposer: ObservableObject {
    @Published var soundURL: URL?
    @Published var errorMessage = ""

    private var soundItems = [AVPlayerItem]()
    private let player: QueueSoundPlayer
    private let soundResourcesManager: SoundResourcesManagerProtocol

    init(player: QueueSoundPlayer, soundResourcesManager: SoundResourcesManagerProtocol) {
        self.player = player
        self.soundResourcesManager = soundResourcesManager
    }

    func compose(with name: String) {
        guard !soundItems.isEmpty else { return }
        Task {
            let composition = AVMutableComposition()
            for item in soundItems {
                guard let compositionTrack = composition.addMutableTrack(
                    withMediaType: .audio,
                    preferredTrackID: CMPersistentTrackID()
                ) else { return }

                do {
                    if let track = try await item.asset.loadTracks(withMediaType: .audio).first {
                        debugPrint(soundItems)

                        let duration = try await track.load(.timeRange).duration
                        let start = CMTimeMake(value: .zero, timescale: 600)
                        let timeRange = CMTimeRange(start: start, duration: duration)
                        try compositionTrack.insertTimeRange(timeRange, of: track, at: composition.duration)
                    }
                } catch {
                    fatalError()
                }
            }

            assetExportSession(composition: composition, output: name)
        }
    }

    private func assetExportSession(composition: AVMutableComposition, output name: String) {
        if let assetExport = AVAssetExportSession(
            asset: composition,
            presetName: AVAssetExportPresetAppleM4A
        ) {
            let mergeSoundURL = soundResourcesManager.createComposerFileURL(with: name)
            assetExport.outputFileType = .m4a
            assetExport.outputURL = mergeSoundURL

            Task {
                await assetExport.export()
                switch assetExport.status {
                case AVAssetExportSession.Status.failed:
                    error(message: "failed \(String(describing: assetExport.error))")

                case AVAssetExportSession.Status.cancelled:
                    error(message: "cancelled \(String(describing: assetExport.error))")

                case AVAssetExportSession.Status.unknown:
                    error(message: "unknown \(String(describing: assetExport.error))")

                case AVAssetExportSession.Status.waiting:
                    error(message: "waiting \(String(describing: assetExport.error))")

                case AVAssetExportSession.Status.exporting:
                    error(message: "exporting \(String(describing: assetExport.error))")

                default:
                    debugPrint("Audio Concatenation Complete")
                    soundURL = assetExport.outputURL
                }
            }
        }
    }

    func playSample() {
        player.removeItems()
        soundItems.forEach { player.insert(item: $0)}
        player.play()
    }

    func stopSample() {
        player.stop()
    }

    func addItem(with fileName: String) {
        guard let soundURL = getAudioURL(fileName) else { return }
        let asset = AVAsset(url: soundURL)
        let playerItem = AVPlayerItem(
            asset: asset,
            automaticallyLoadedAssetKeys: [.tracks, .duration, .commonMetadata]
        )
        soundItems.append(playerItem)
    }

    func removeItem(at index: Int) {
        soundItems.remove(at: index)
    }

    private func getAudioURL(_ name: String) -> URL? {
        let url = try? soundResourcesManager.audioFileURL(with: name)
        return url
    }

    private func error(message: String) {
        soundItems.removeAll()
        player.removeItems()
        errorMessage = message
    }
}
