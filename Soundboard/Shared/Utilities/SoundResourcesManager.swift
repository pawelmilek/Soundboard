//
//  SoundResourcesManager.swift
//  Soundboard
//
//  Created by Pawel Milek on 10/26/23.
//

import Foundation

protocol SoundResourcesManagerProtocol {
    func loadAudioFiles() throws -> [String]
    func audioFileURL(with name: String) throws -> URL
    func createComposerFileURL(with fileName: String) -> URL
}

struct SoundResourcesManager: SoundResourcesManagerProtocol {
    private static let composerPath = "ComposerSounds"
    private static let fileExtension = "m4a"

    private let fileManager: FileManager
    private let bundle: Bundle

    init(fileManager: FileManager = .default, bundle: Bundle = .main) {
        self.fileManager = fileManager
        self.bundle = bundle
    }

    func loadAudioFiles() throws -> [String] {
        var result: [String]

        let bundlePath = bundle.bundlePath
        let composerPath = composerSoundsDirectoryURL().path()
        let bundleFiles = try fileManager.contentsOfDirectory(atPath: bundlePath)
        result = bundleFiles.filter { $0.hasSuffix(".\(Self.fileExtension)") }

        if let composerFiles = try? fileManager.contentsOfDirectory(atPath: composerPath) {
            let composerContent = composerFiles.filter { $0.hasSuffix(".\(Self.fileExtension)") }
            result.append(contentsOf: composerContent)
        }
        return result
    }

    func audioFileURL(with name: String) throws -> URL {
        let fileURLWithPath: URL

        if let path = bundle.path(forResource: name.components(separatedBy: ".").first!, ofType: Self.fileExtension) {
            fileURLWithPath = URL(fileURLWithPath: path)

        } else {
            let url = composedAudioFileURL(with: name)
            let isPathExists = fileManager.fileExists(atPath: url.path)
            if isPathExists {
                fileURLWithPath = url
            } else {
                throw CocoaError(.fileNoSuchFile)
            }
        }

        return fileURLWithPath
    }

    private func composedAudioFileURL(with name: String) -> URL {
        let documentURL = composerSoundsDirectoryURL()
        let isDocumentsDirectoryExists = (try? documentURL.checkResourceIsReachable()) ?? false

        if !isDocumentsDirectoryExists {
            createDocumentDirectory(at: documentURL)
        }

        let fileURL = documentURL.appendingPathComponent(name)
        return fileURL
    }

    func createComposerFileURL(with name: String) -> URL {
        let documentURL = composerSoundsDirectoryURL()
        let isDocumentsDirectoryExists = (try? documentURL.checkResourceIsReachable()) ?? false

        if !isDocumentsDirectoryExists {
            createDocumentDirectory(at: documentURL)
        }

        let fileURL = documentURL.appendingPathComponent("\(name).m4a")
        return fileURL
    }

    private func composerSoundsDirectoryURL() -> URL {
        URL.documentsDirectory.appending(path: Self.composerPath, directoryHint: .isDirectory)
    }

    private func createDocumentDirectory(at url: URL) {
        do {
            try fileManager.createDirectory(at: url, withIntermediateDirectories: false)
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
}
