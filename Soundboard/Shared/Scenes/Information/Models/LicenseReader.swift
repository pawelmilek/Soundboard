//
//  LicenseReader.swift
//  Soundboard
//
//  Created by Pawel Milek on 1/24/24.
//

import SwiftUI

class LicenseReader: ObservableObject {
    @Published private(set) var fileURL: URL?

    private let fileName: String

    init(fileName: String) {
        self.fileName = fileName
    }

    func readFileURL() throws {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "html") else {
            throw FileLoaderError.fileNotFound(name: fileName)
        }

        fileURL = url
    }
}
