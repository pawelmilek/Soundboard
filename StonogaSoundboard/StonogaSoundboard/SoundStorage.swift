//
//  SoundStorage.swift
//  StonogaSoundboard
//
//  Created by Pawel Milek on 10/27/23.
//

import Foundation

protocol StorageProtocol {
    func load() throws -> Set<SoundModel>
    func save(_ models: Set<SoundModel>) throws
}

struct SoundStorage: StorageProtocol {
    private static let key = "SavedSoundModelKey"
    private let defaults: UserDefaults

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    func load() throws -> Set<SoundModel> {
        if let savedSoundModel = defaults.object(forKey: Self.key) as? Data {
            let decoder = JSONDecoder()
            let loadedSounds = try decoder.decode([SoundModel].self, from: savedSoundModel)
            return Set(loadedSounds)

        } else {
            return []
        }
    }

    func save(_ models: Set<SoundModel>) throws {
        let encoder = JSONEncoder()
        let encoded = try encoder.encode(models)
        defaults.set(encoded, forKey: Self.key)
    }
}
