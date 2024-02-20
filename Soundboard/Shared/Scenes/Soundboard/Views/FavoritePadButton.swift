//
//  FavoritePadButton.swift
//  Soundboard
//
//  Created by Pawel Milek on 2/20/24.
//  Copyright © 2024 Pawel Milek. All rights reserved.
//

import SwiftUI

struct FavoritePadButton: View {
    @Binding public var isOn: Bool

    private var symbol: String {
        isOn ? "heart.fill" : "heart"
    }

    private var symbolEffect: BounceSymbolEffect {
        isOn ? .bounce.up.byLayer : .bounce.down.byLayer
    }

    public var body: some View {
        Button {
            isOn.toggle()
        } label: {
            Image(systemName: symbol)
                .symbolEffect(symbolEffect, value: isOn)
            .font(.title)
            .padding(5)
        }
        .controlSize(.extraLarge)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    VStack(spacing: 10) {
        FavoritePadButton(
            isOn: .constant(true)
        )
        FavoritePadButton(
            isOn: .constant(false)
        )
    }
    .padding()
}
