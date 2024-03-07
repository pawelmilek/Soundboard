//
//  ComposerItem.swift
//  Soundboard
//
//  Created by Pawel Milek on 3/7/24.
//  Copyright © 2024 Pawel Milek. All rights reserved.
//

import SwiftUI

struct ComposerGridItem: View {
    let title: String
    let fill: Color

    var body: some View {
        Text(title)
            .font(.footnote)
            .fontWeight(.medium)
            .foregroundStyle(.white)
            .lineLimit(2)
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .background(
                Capsule()
                    .fill(fill)
                    .shadow(
                        color: .primary.opacity(0.5),
                        radius: 2,
                        x: 0,
                        y: 0
                    )
            )
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    ComposerGridItem(
        title: SoundModel.example.first!.title,
        fill: .accent
    )
    .padding()
}
