//
//  SoundFileManager.swift
//  StonogaSoundboard
//
//  Created by Pawel Milek on 10/26/23.
//

import Foundation

public protocol FileManagerProtocol {
    func loadAudioFiles() throws -> [String]
    func audioURL(for name: String) throws -> URL
}

public struct SoundFileManager: FileManagerProtocol {
    private static let fileExtension = "m4a"

    private let fileManager: FileManager
    private let bundle: Bundle

    init(fileManager: FileManager = .default, bundle: Bundle = .main) {
        self.fileManager = fileManager
        self.bundle = bundle
    }

    public func loadAudioFiles() throws -> [String] {
        let path = bundle.bundlePath
        let allFiles = try fileManager.contentsOfDirectory(atPath: path)
        let result = allFiles
            .filter { $0.hasSuffix(".\(Self.fileExtension)") }
            .compactMap { $0.components(separatedBy: ".").first! }
        return result
    }

    public func audioURL(for name: String) throws -> URL {
        guard let path = bundle.path(
            forResource: name,
            ofType: Self.fileExtension
        ) else {
            throw CocoaError(.fileNoSuchFile)
        }

        let url = URL(fileURLWithPath: path)
        return url
    }

}
