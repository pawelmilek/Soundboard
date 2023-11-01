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
            HStack(alignment: .firstTextBaseline, spacing: 5) {
                Image(systemName: symbol)
                Text("Share")
            }
            .font(.caption2)
            .fontWeight(.regular)
            .padding(.horizontal, 5)
            .padding(.trailing, 5)
        })
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.capsule)
        .controlSize(.small)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    ShareButton(content: ShareContentModel(
        url: URL(string: "www.apple.com")!,
        preview: (SoundModel.example.first!.fileName, "stonoga"))
    )
    .padding()
}
