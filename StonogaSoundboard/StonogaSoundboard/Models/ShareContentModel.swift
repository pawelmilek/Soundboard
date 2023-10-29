//
//  ShareContentModel.swift
//  StonogaSoundboard
//
//  Created by Pawel Milek on 10/28/23.
//

import Foundation
import CoreTransferable

struct ShareContentModel {
    let url: URL
    let preview: (name: String, image: String)
}

extension ShareContentModel: Transferable {
    public static var transferRepresentation: some TransferRepresentation {
        FileRepresentation(exportedContentType: .mpeg4Audio) { content in
            SentTransferredFile(content.url)
        }
    }
}
