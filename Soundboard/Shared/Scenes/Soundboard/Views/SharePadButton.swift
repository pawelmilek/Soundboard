//
//  SharePadButton.swift
//  Soundboard
//
//  Created by Pawel Milek on 2/20/24.
//  Copyright © 2024 Pawel Milek. All rights reserved.
//

import SwiftUI

struct SharePadButton: View {
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
            Image(systemName: symbol)
                .font(.title)
                .padding(5)
        })
        .controlSize(.extraLarge)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    SharePadButton(content: ShareContent(
        url: URL(string: "www.apple.com")!,
        preview: ("chj warci jestescie", "imageName"))
    )
    .padding()
}
