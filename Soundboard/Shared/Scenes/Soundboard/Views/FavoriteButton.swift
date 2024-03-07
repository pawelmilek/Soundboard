//
//  FavoriteButton.swift
//  Soundboard
//
//  Created by Pawel Milek on 10/26/23.
//

import SwiftUI

public struct FavoriteButton: View {
    @Binding public var isOn: Bool

    private var symbol: String {
        isOn ? "heart.fill" : "heart"
    }

    private var symbolEffect: BounceSymbolEffect {
        isOn ? .bounce.up.byLayer : .bounce.down.byLayer
    }

    public init(isOn: Binding<Bool>) {
        self._isOn = isOn
    }

    public var body: some View {
        Button {
            isOn.toggle()
        } label: {
            HStack(alignment: .firstTextBaseline, spacing: 5) {
                Image(systemName: symbol)
                    .symbolEffect(symbolEffect, value: isOn)
                Text("Like")
            }
            .font(.caption2)
            .fontWeight(.semibold)
            .foregroundStyle(.white)
            .padding(.horizontal, 15)
            .padding(.vertical, 5)
        }
        .buttonStyle(.borderless)
        .background {
            Capsule()
                .foregroundStyle(.accent)
                .shadow(color: .primary.opacity(0.25), radius: 2, x: 0, y: 0)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    VStack(spacing: 10) {
        FavoriteButton(
            isOn: .constant(true)
        )
        FavoriteButton(
            isOn: .constant(false)
        )
    }
    .padding()
}
