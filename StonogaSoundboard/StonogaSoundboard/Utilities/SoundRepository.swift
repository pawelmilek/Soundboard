//
//  SoundRepository.swift
//  StonogaSoundboard
//
//  Created by Pawel Milek on 10/27/23.
//

import Foundation
import RealmSwift

protocol Repository {
    @discardableResult
    func load() -> Results<SoundModel>
    func update(_ model: SoundModel)
    func get(by fileName: String) -> SoundModel?
}

struct SoundRepository: Repository {
    private let realm: Realm
    private let soundFileManager: FileManagerProtocol

    init(
        realm: Realm = RealmManager.shared.realm,
        soundFileManager: FileManagerProtocol = SoundFileManager()
    ) {
        self.realm = realm
        self.soundFileManager = soundFileManager
    }

    @discardableResult
    func load() -> Results<SoundModel> {
        let storedSoundModels = loadSoundModelsFromStorage()
        let hasStoredModels = !storedSoundModels.isEmpty

        if hasStoredModels {
            guard hasChangedSoundResources() else { return storedSoundModels }
            let newestModels = updateStorageChangeTransactions()
            return newestModels

        } else {
            let result = addingSoundModels()
            return result
        }
    }

    private func loadSoundModelsFromStorage() -> Results<SoundModel> {
        let realm = RealmManager.shared.realm
        let storedSoundModels = realm.objects(SoundModel.self)
        return storedSoundModels
    }

    private func updateStorageChangeTransactions() -> Results<SoundModel> {
        let transactions = loadResourcesChangeTransactions()
        if !transactions.insert.isEmpty {
            insert(transactions.insert)
        }

        if !transactions.delete.isEmpty {
            delete(transactions.delete)
        }

        let result = loadSoundModelsFromStorage()
        return result
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

    private func addingSoundModels() -> Results<SoundModel> {
        let realm = RealmManager.shared.realm

        do {
            try realm.write {
                let models = loadFilesAndCreateSoundModels()
                realm.add(models)
            }

            let added = realm.objects(SoundModel.self)
            return added

        } catch {
            fatalError("Can't bootstrap item data: \(error.localizedDescription)")
        }
    }

    private func loadSoundFileNamesFromResources() -> Set<String> {
        do {
            let names = try soundFileManager.loadAudioFiles()
            return Set(names)
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    private func loadSoundFileNamesFromStorage() -> Set<String> {
        let models = loadSoundModelsFromStorage()
        return Set(models.compactMap { $0.fileName })
    }

    private func insert(_ files: Set<String>) {
        let realm = RealmManager.shared.realm

        do {
            try realm.write {
                let newModels = createSoundModels(from: files)
                realm.add(newModels)
            }
        } catch {
            fatalError("Can't bootstrap item data: \(error.localizedDescription)")
        }
    }

    private func delete(_ files: Set<String>) {
        let realm = RealmManager.shared.realm
        let toDelete = files.compactMap { get(by: $0) }

        do {
            try realm.write {
                if !toDelete.isEmpty {
                    realm.delete(toDelete)
                }
            }
        } catch {
            fatalError("Can't bootstrap item data: \(error.localizedDescription)")
        }
    }

    private func loadFilesAndCreateSoundModels() -> Set<SoundModel> {
        let fileNames = loadSoundFileNamesFromResources()
        let models = createSoundModels(from: fileNames)
        return models
    }

    private func createSoundModels(from fileNames: Set<String>) -> Set<SoundModel> {
        let models = fileNames.compactMap { fileName in
            SoundModel(
                value: [
                    "title": fileName.replacingOccurrences(of: "-", with: " "),
                    "fileName": fileName,
                    "playbackCount": 0,
                    "isFavorite": false
                ]
            )
        }
        return Set(models)
    }

    func update(_ model: SoundModel) {
        let realm = RealmManager.shared.realm
        do {
            try realm.write {
                realm.add(model, update: .modified)
            }
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func get(by fileName: String) -> SoundModel? {
        let realm = RealmManager.shared.realm
        return realm.objects(SoundModel.self).first(where: { $0.fileName == fileName })
    }
}
