//
//  SoundModel.swift
//  StonogaSoundboard
//
//  Created by Pawel Milek on 10/25/23.
//

import Foundation
import CoreTransferable

struct SoundModel: Identifiable, Codable, Hashable {
    var id: String { fileName }
    let fileName: String
    var playbackCount: Int
    var isFavorite: Bool
    var isPlaying: Bool
}

extension SoundModel {

    static let example = {
        return [
            SoundModel(
                fileName: "chj-z-wami",
                playbackCount: 0,
                isFavorite: false,
                isPlaying: false
            ),
            SoundModel(
                fileName: "chj-warci-jestescie",
                playbackCount: 0,
                isFavorite: false,
                isPlaying: false
            ),
            SoundModel(
                fileName: "chcialem-sie-widziec-z-tym-skuynem",
                playbackCount: 0,
                isFavorite: false,
                isPlaying: false
            ),
            SoundModel(
                fileName: "chcialem-sie-widziec-z-tym-skuynem-ziobro",
                playbackCount: 0,
                isFavorite: false,
                isPlaying: false
            ),
            SoundModel(
                fileName: "chcesz-pozdrowic-publicznosc",
                playbackCount: 0,
                isFavorite: false,
                isPlaying: false
            ),
            SoundModel(
                fileName: "chcesz-nam-stratowac-nasze-miasto",
                playbackCount: 0,
                isFavorite: false,
                isPlaying: false
            ),
            SoundModel(
                fileName: "by-tego-czlowieka-wprowadzic-do-parlamentu",
                playbackCount: 0,
                isFavorite: false,
                isPlaying: false
            ),
            SoundModel(
                fileName: "bo-to-garstka-polakow",
                playbackCount: 0,
                isFavorite: false,
                isPlaying: false
            ),
            SoundModel(
                fileName: "bo-mnie-stac-na-wszystko",
                playbackCount: 0,
                isFavorite: false,
                isPlaying: false
            ),
            SoundModel(
                fileName: "bo-jestescie-chj-warci",
                playbackCount: 0,
                isFavorite: false,
                isPlaying: false
            ),
            SoundModel(
                fileName: "bo-jestescie-banda-nieudacznikow",
                playbackCount: 0,
                isFavorite: false,
                isPlaying: false
            ),
            SoundModel(
                fileName: "bo-cie-odcholuje",
                playbackCount: 0,
                isFavorite: false,
                isPlaying: false
            ),
            SoundModel(
                fileName: "bo-cie-odcholuje-2",
                playbackCount: 0,
                isFavorite: false,
                isPlaying: false
            ),
            SoundModel(
                fileName: "biznes",
                playbackCount: 0,
                isFavorite: false,
                isPlaying: false
            ),
            SoundModel(
                fileName: "bedzie-was-ps-rchal-w-dpe",
                playbackCount: 0,
                isFavorite: false,
                isPlaying: false
            ),
            SoundModel(
                fileName: "bedzie-was-ps-kua-dymal-tak",
                playbackCount: 0,
                isFavorite: false,
                isPlaying: false
            ),
            SoundModel(
                fileName: "bede-zyl-kua-tak",
                playbackCount: 0,
                isFavorite: false,
                isPlaying: false
            ),
            SoundModel(
                fileName: "beda-wam-odbieraly-smak-zycia",
                playbackCount: 0,
                isFavorite: false,
                isPlaying: false
            )
        ]
    }()
}
