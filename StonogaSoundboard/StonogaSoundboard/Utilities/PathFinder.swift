//
//  PathFinder.swift
//  StonogaSoundboard
//
//  Created by Pawel Milek on 10/30/23.
//

import Foundation

final class PathFinder {
    static func inLibrary(_ name: String) throws -> URL {
        return try FileManager.default
            .url(for: .libraryDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(name)
    }

}
