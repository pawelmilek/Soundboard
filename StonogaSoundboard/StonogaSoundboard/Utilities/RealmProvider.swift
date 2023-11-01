//
//  RealmProvider.swift
//  StonogaSoundboard
//
//  Created by Pawel Milek on 10/30/23.
//

import Foundation
import RealmSwift

struct RealmProvider {
    private static let realmName = "soundboard.realm"

    static var shared: RealmProvider = {
        do {
            let fileURL = try PathFinder.inLibrary(realmName)
            let config = Realm.Configuration(
                fileURL: fileURL,
                schemaVersion: 1,
                deleteRealmIfMigrationNeeded: true
            )

            return RealmProvider(config: config)
        } catch {
            fatalError("Error: \(Self.realmName) not load")
        }
    }()

    var realm: Realm {
        do {
            return try Realm(configuration: configuration)
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    var previewRealm: Realm {
        var realm: Realm
        let identifier = "preview.\(Self.realmName)"
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

    var fileURL: URL? {
        configuration.fileURL
    }

    private let configuration: Realm.Configuration

    private init(config: Realm.Configuration) {
        configuration = config
    }
}
