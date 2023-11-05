//
//  RealmManager.swift
//  StonogaSoundboard
//
//  Created by Pawel Milek on 10/30/23.
//

import Foundation
import RealmSwift

public final class RealmManager: ObservableObject {
    var previewRealm: Realm {
        var realm: Realm
        let identifier = "preview.realm"
        let config = Realm.Configuration(inMemoryIdentifier: identifier)
        do {
            realm = try Realm(configuration: config)
            let realmObjects = realm.objects(SoundModel.self)
            if realmObjects.count > 0 {
                return realm
            } else {
                try realm.write {
                    realm.add(SoundModel.example)
                }
                return realm
            }
        } catch let error {
            fatalError("Can't bootstrap item data: \(error.localizedDescription)")
        }
    }

    private(set) var realm: Realm?
    private let soundFileManager: FileManagerProtocol

    public init(name: String, soundFileManager: FileManagerProtocol = SoundFileManager()) {
        self.soundFileManager = soundFileManager
        setupScheme(with: name)
        populateRealm()
    }

    private func setupScheme(with name: String) {
        do {
            let fileURL = try PathFinder.documentDirectory().appendingPathComponent("\(name).realm")
            let configuration = Realm.Configuration(
                fileURL: fileURL,
                schemaVersion: 1,
                deleteRealmIfMigrationNeeded: false
            )

            Realm.Configuration.defaultConfiguration = configuration
            self.realm = try Realm()
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func debugPrintRealmFileURL() {
        let realmURLAbsoluteString = realm?.configuration.fileURL?.absoluteString ?? "Invalid URL"
        debugPrint("Realm file URL: \(realmURLAbsoluteString)")
    }


    private func populateRealm() {
        let storedSounds = loadSoundsFromStorage()
        let hasStoredModels = !storedSounds.isEmpty

        if hasStoredModels {
            guard hasChangedSoundResources() else { return }
            updateStorageChangeTransactions()

        } else {
            insertModels()
        }
    }

    private func loadSoundsFromStorage() -> Set<SoundModel> {
        guard let storedSounds = realm?.objects(SoundModel.self) else { return [] }
        return Set(storedSounds)
    }

    private func updateStorageChangeTransactions() {
        let transactions = loadResourcesChangeTransactions()
        if !transactions.insert.isEmpty {
            insert(transactions.insert)
        }

        if !transactions.delete.isEmpty {
            delete(transactions.delete)
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

    private func insertModels() {
        do {
            try realm?.write {
                let models = loadFilesAndCreateSoundModels()
                realm?.add(models)
            }
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
        let models = loadSoundsFromStorage()
        return Set(models.compactMap { $0.fileName })
    }

    private func insert(_ files: Set<String>) {
        do {
            try realm?.write {
                let newModels = createSoundModels(from: files)
                realm?.add(newModels)
            }
        } catch {
            fatalError("Can't bootstrap item data: \(error.localizedDescription)")
        }
    }

    private func delete(_ files: Set<String>) {
        let toDelete = files.compactMap { object(forPrimaryKey: $0) }
        guard !toDelete.isEmpty else { return }

        do {
            try realm?.write {
                realm?.delete(toDelete)
            }
        } catch {
            fatalError("Can't bootstrap item data: \(error.localizedDescription)")
        }
    }

    private func object(forPrimaryKey fileName: String) -> SoundModel? {
        return realm?.object(ofType: SoundModel.self, forPrimaryKey: fileName)
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
                    "fileName": fileName,
                    "title": fileName.replacingOccurrences(of: "-", with: " "),
                    "playbackCount": 0,
                    "isFavorite": false
                ]
            )
        }
        return Set(models)
    }

}
