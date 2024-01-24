//
//  SoundboardSortOrder.swift
//  Soundboard
//
//  Created by Pawel Milek on 1/24/24.
//

import Foundation

enum SoundboardSortOrder: String, Identifiable, CaseIterable, CustomStringConvertible {
    case title
    case playback

    var id: Self { self }
    var description: String {
        switch self {
        case .title:
            "Title"
        case .playback:
            "Playback"
        }
    }

    var keyPath: String  {
        switch self {
        case .title:
            "title"

        case .playback:
            "playbackCount"
        }
    }

    var ascending: Bool {
        switch self {
        case .title:
            true

        case .playback:
            false
        }
    }
}
