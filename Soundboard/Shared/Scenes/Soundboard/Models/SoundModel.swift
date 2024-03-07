//
//  SoundModel.swift
//  Soundboard
//
//  Created by Pawel Milek on 11/3/23.
//

import Foundation
import RealmSwift

public final class SoundModel: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var fileName = ""
    @Persisted var title = ""
    @Persisted var playbackCount = 0
    @Persisted var isFavorite = false
}

public extension SoundModel {

    private static func createSoundModels(from fileNames: Set<String>) -> Set<SoundModel> {
        let models = fileNames.compactMap { fileName in
            let title = fileName.components(separatedBy: ".").first!.trimmingCharacters(in: .whitespacesAndNewlines)
            return SoundModel(
                value: [
                    "fileName": fileName,
                    "title": title,
                    "playbackCount": 0,
                    "isFavorite": false
                ]
            )
        }
        return Set(models)
    }

    static let example: [SoundModel] = {
        let fileManager = SoundResourcesManager()
        let audioFiles = try? fileManager.loadAudioFiles()
        let soundsSet = createSoundModels(from: Set(audioFiles!))
        return Array(soundsSet)

//        return [
//            SoundModel(
//                value: [
//                    "title": "chj z wami",
//                    "fileName": "chj-z-wami.m4a",
//                    "playbackCount": 0,
//                    "isFavorite": false
//                ]
//            ),
//            SoundModel(
//                value: [
//                    "title": "chj warci jestescie",
//                    "fileName": "chj-warci-jestescie.m4a",
//                    "playbackCount": 0,
//                    "isFavorite": false
//                ]
//            ),
//            SoundModel(
//                value: [
//                    "title": "chcialem sie widziec z tym skuynem",
//                    "fileName": "chcialem-sie-widziec-z-tym-skuynem.m4a",
//                    "playbackCount": 0,
//                    "isFavorite": false
//                ]
//            ),
//            SoundModel(
//                value: [
//                    "title": "chcialem sie widziec z tym skuynem ziobro",
//                    "fileName": "chcialem-sie-widziec-z-tym-skuynem-ziobro.m4a",
//                    "playbackCount": 0,
//                    "isFavorite": false
//                ]
//            ),
//            SoundModel(
//                value: [
//                    "title": "bo cie odcholuje",
//                    "fileName": "bo-cie-odcholuje.m4a",
//                    "playbackCount": 0,
//                    "isFavorite": false
//                ]
//            )
//        ]
    }()
}
