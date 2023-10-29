//
//  Repository.swift
//  StonogaSoundboard
//
//  Created by Pawel Milek on 10/27/23.
//

import Foundation

protocol Repository {
    func load() -> Set<SoundModel>
    func save(_ models: Set<SoundModel>)
}

struct SoundRepository: Repository {
    private let storage: StorageProtocol
    private let soundFileManager: FileManagerProtocol

    init(
        storage: StorageProtocol = SoundStorage(),
        soundFileManager: FileManagerProtocol = SoundFileManager()
    ) {
        self.storage = storage
        self.soundFileManager = soundFileManager
    }

    func load() -> Set<SoundModel> {
        var storedSoundModels = loadSoundModelsFromStorage()
        let hasStoredModels = !storedSoundModels.isEmpty

        if hasStoredModels {
            guard hasChangedSoundResources() else {
                return storedSoundModels
            }

            let transactions = loadResourcesChangeTransactions()
            insert(transactions.insert, destination: &storedSoundModels)
            delete(transactions.delete, destination: &storedSoundModels)
            return storedSoundModels
        } else {
            let soundModels = loadFilesAndCreateSoundModels()
            return soundModels
        }
    }

    private func loadSoundModelsFromStorage() -> Set<SoundModel> {
        do {
            return try storage.load()
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    private func hasChangedSoundResources() -> Bool {
        let result = loadResourcesChangeTransactions()
        let hasToDelete = !result.delete.isEmpty
        let hasToInsert = !result.insert.isEmpty
        return hasToDelete || hasToInsert
    }

    private func loadResourcesChangeTransactions() -> (insert: Set<String>, delete: Set<String>) {
        let resources = loadSoundFileNamesFromResources()
        let storage = loadSoundFileNamesFromStorage()

        let addedAndRemovedSounds = resources.symmetricDifference(storage)
        let soundsToRemove = storage.intersection(addedAndRemovedSounds)
        let soundsToAdd = addedAndRemovedSounds.subtracting(soundsToRemove)
        return (insert: soundsToAdd, delete: soundsToRemove)
    }

    private func insert( _ files: Set<String>, destination: inout Set<SoundModel>) {
        let newModels = createSoundModels(from: files)
        destination.formUnion(newModels)
    }

    private func delete(_ files: Set<String>, destination: inout Set<SoundModel>) {
        files.forEach { fileNameToDelete in
            guard let remove = destination.first(where: { $0.fileName == fileNameToDelete }) else {
                return
            }
            destination.remove(remove)
        }
    }

    private func loadSoundFileNamesFromStorage() -> Set<String> {
        let models = loadSoundModelsFromStorage()
        return Set(models.compactMap { $0.fileName })
    }

    private func loadSoundFileNamesFromResources() -> Set<String> {
        do {
            let names = try soundFileManager.loadFiles()
            return Set(names)
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    private func loadFilesAndCreateSoundModels() -> Set<SoundModel> {
        let fileNames = loadSoundFileNamesFromResources()
        let models = createSoundModels(from: fileNames)
        return models
    }

    private func createSoundModels(from fileNames: Set<String>) -> Set<SoundModel> {
        let models = fileNames.compactMap {
            SoundModel(
                fileName: $0,
                playbackCount: 0,
                isFavorite: false,
                isPlaying: false
            )
        }
        return Set(models)
    }

    func save(_ models: Set<SoundModel>) {
        do {
            try storage.save(models)
        } catch {
            fatalError(error.localizedDescription)
        }
    }

}
