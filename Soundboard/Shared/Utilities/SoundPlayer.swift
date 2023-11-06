//
//  SoundPlayer.swift
//  Soundboard
//
//  Created by Pawel Milek on 10/27/23.
//

import Foundation
import AVFoundation

public protocol PlayerProtocol {
    var delegate: AVAudioPlayerDelegate? { get set }

    func playSound(_ name: String)
    func stopSound()
}

public final class SoundPlayer: PlayerProtocol {
    public weak var delegate: AVAudioPlayerDelegate?
    private var player: AVAudioPlayer?
    private let soundFileManager: FileManagerProtocol

    public init(soundFileManager: FileManagerProtocol = SoundFileManager()) {
        self.soundFileManager = soundFileManager
    }

    public func playSound(_ name: String) {
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

    public func stopSound() {
        player?.stop()
    }
}
