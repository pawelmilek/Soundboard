//
//  SoundModel.swift
//  StonogaSoundboard
//
//  Created by Pawel Milek on 11/3/23.
//

import Foundation
import RealmSwift

public final class SoundModel: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) public var id: ObjectId
    @Persisted var title = ""
    @Persisted var fileName = ""
    @Persisted var playbackCount = 0
    @Persisted var isFavorite = false
}

public extension SoundModel {

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
