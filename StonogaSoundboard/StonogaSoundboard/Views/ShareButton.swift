//
//  ShareButton.swift
//  StonogaSoundboard
//
//  Created by Pawel Milek on 10/27/23.
//

import SwiftUI

struct ShareButton: View {
    private let symbol = "square.and.arrow.up"
    var content: ShareContentModel

    var body: some View {
        ShareLink(item: content,
                  preview: SharePreview(
                    content.preview.name,
                    image: Image(content.preview.image)
                  ),
                  label: {
            Image(systemName: symbol)
                .resizable()
                .scaledToFit()
                .foregroundColor(.gray)
        })
        .buttonStyle(.borderless)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    ShareButton(content: ShareContentModel(
        url: URL(string: "www.apple.com")!,
        preview: (SoundModel.example.first!.fileName, "stonoga"))
    )
    .frame(maxWidth: 44)
}
