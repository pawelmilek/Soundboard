//
//  ShareContent.swift
//  SoundboardKit
//
//  Created by Pawel Milek on 11/3/23.
//

import Foundation

import Foundation
import CoreTransferable

public struct ShareContent {
    let url: URL
    let preview: (name: String, image: String)

    public init(url: URL, preview: (name: String, image: String)) {
        self.url = url
        self.preview = preview
    }
}

extension ShareContent: Transferable {
    public static var transferRepresentation: some TransferRepresentation {
        FileRepresentation(exportedContentType: .mpeg4Audio) { content in
            SentTransferredFile(content.url)
        }
    }
}
