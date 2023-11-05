//
//  PathFinder.swift
//  StonogaSoundboard
//
//  Created by Pawel Milek on 10/30/23.
//

import Foundation

public final class PathFinder {

    public static func documentDirectory() throws -> URL {
        guard let directory = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first else {
            throw CocoaError.error(.fileReadUnsupportedScheme)
        }
        return directory
    }

}
