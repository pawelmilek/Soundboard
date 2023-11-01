//
//  SoundPlayer.swift
//  StonogaSoundboard
//
//  Created by Pawel Milek on 10/27/23.
//

import Foundation
import AVFoundation

protocol PlayerProtocol {
    var delegate: AVAudioPlayerDelegate? { get set }

    func playSound(_ name: String)
    func stopSound()
}

final class SoundPlayer: PlayerProtocol {
    weak var delegate: AVAudioPlayerDelegate?
    private var player: AVAudioPlayer?
    private let soundFileManager: FileManagerProtocol

    init(soundFileManager: FileManagerProtocol = SoundFileManager()) {
        self.soundFileManager = soundFileManager
    }

    func playSound(_ name: String) {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            let url = try soundFileManager.audioURL(for: name)
            player = try AVAudioPlayer(contentsOf: url)
            player?.volume = 1.0
            player?.delegate = delegate
            player?.play()

        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func stopSound() {
        player?.stop()
    }
}
