//
//  ShareButton.swift
//  Soundboard
//
//  Created by Pawel Milek on 10/27/23.
//

import SwiftUI

public struct ShareButton: View {
    private let symbol = "square.and.arrow.up"
    let content: ShareContent

    public init(content: ShareContent) {
        self.content = content
    }

    public var body: some View {
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
            .fontWeight(.semibold)
            .foregroundStyle(.white)
            .padding(.horizontal, 15)
            .padding(.vertical, 5)
        })
        .buttonStyle(.borderless)
        .background {
            Capsule()
                .foregroundStyle(.accent)
                .shadow(color: .primary.opacity(0.25), radius: 2, x: 0, y: 0)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    ShareButton(content: ShareContent(
        url: URL(
            string: "www.apple.com"
        )!,
        preview: ("chj warci jestescie", "imageName"))
    )
    .padding()
}
