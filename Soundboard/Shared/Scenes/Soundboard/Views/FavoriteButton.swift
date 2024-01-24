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
            donateEventTipWhenIsOn()
        } label: {
            HStack(alignment: .firstTextBaseline, spacing: 5) {
                Image(systemName: symbol)
                    .symbolEffect(symbolEffect, value: isOn)
                Text("Like")
            }
            .font(.caption2)
            .fontWeight(.regular)
            .padding(.horizontal, 5)
            .padding(.trailing, 5)
        }
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.capsule)
        .controlSize(.small)
    }

    private func donateEventTipWhenIsOn() {
        guard isOn else { return }
        Task {
            await FavoritesSoundTip.favoritesSoundEvent.donate()
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
