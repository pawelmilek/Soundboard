//
//  QueueSoundPlayer.swift
//  Soundboard
//
//  Created by Pawel Milek on 3/7/24.
//  Copyright © 2024 Pawel Milek. All rights reserved.
//

import AVFoundation
import Combine

protocol QueueSoundPlayerProtocol {
    func play()
    func stop()
    func insert(item: AVPlayerItem)
    func remove(item: AVPlayerItem)
    func removeItems()
}

final class QueueSoundPlayer {
    private let player: AVQueuePlayer

    init() {
        try? AVAudioSession.sharedInstance().setCategory(.playback)
        player = AVQueuePlayer()
        player.actionAtItemEnd = .advance
    }

    func insert(items: [AVPlayerItem]) {
        items.forEach { insert(item: $0) }
    }

    func insert(item: AVPlayerItem) {
        seek(item: item, to: 0)
        if player.canInsert(item, after: nil) {
            player.insert(item, after: nil)
        }
    }

    func remove(item: AVPlayerItem) {
        player.remove(item)
    }

    func play() {
        player.play()
    }

    func stop() {
        removeItems()
    }

    func removeItems() {
        player.removeAllItems()
    }

    private func seek(item: AVPlayerItem, to timeInterval: TimeInterval) {
        Task {
            let time = CMTime(seconds: timeInterval, preferredTimescale: 600)
            await item.seek(to: time)
        }
    }
}
