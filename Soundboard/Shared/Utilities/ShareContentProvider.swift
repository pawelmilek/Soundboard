//
//  ShareContentProvider.swift
//  Soundboard
//
//  Created by Pawel Milek on 11/6/23.
//

import Foundation

struct ShareContentProvider {
    private let fileManager: SoundResourcesManagerProtocol

    init(fileManager: SoundResourcesManagerProtocol = SoundResourcesManager()) {
        self.fileManager = fileManager
    }

    func content(with title: String, image: String, _ fileName: String) -> ShareContent {
        do {
            let url = try fileManager.audioFileURL(with: fileName)
            return ShareContent(url: url, preview: (title, image))
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
