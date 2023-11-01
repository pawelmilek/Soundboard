//
//  SoundModel.swift
//  StonogaSoundboard
//
//  Created by Pawel Milek on 10/25/23.
//

import Foundation
import RealmSwift

// swiftlint:disable identifier_name
final class SoundModel: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title = ""
    @Persisted var fileName = ""
    @Persisted var playbackCount = 0
    @Persisted var isFavorite = false
}

extension SoundModel {

    static let example = {
        return [
            SoundModel(
                value: [
                    "title": "chj z wami",
                    "fileName": "chj-z-wami",
                    "playbackCount": 0,
                    "isFavorite": false
                ]
            ),
            SoundModel(
                value: [
                    "title": "chj warci jestescie",
                    "fileName": "chj-warci-jestescie",
                    "playbackCount": 0,
                    "isFavorite": false
                ]
            ),
            SoundModel(
                value: [
                    "title": "chcialem sie widziec z tym skuynem",
                    "fileName": "chcialem-sie-widziec-z-tym-skuynem",
                    "playbackCount": 0,
                    "isFavorite": false
                ]
            ),
            SoundModel(
                value: [
                    "title": "chcialem sie widziec z tym skuynem ziobro",
                    "fileName": "chcialem-sie-widziec-z-tym-skuynem-ziobro",
                    "playbackCount": 0,
                    "isFavorite": false
                ]
            ),
            SoundModel(
                value: [
                    "title": "bo cie odcholuje",
                    "fileName": "bo-cie-odcholuje",
                    "playbackCount": 0,
                    "isFavorite": false
                ]
            )
        ]
    }()
}
