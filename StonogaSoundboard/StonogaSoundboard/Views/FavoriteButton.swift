//
//  FavoriteButton.swift
//  StonogaSoundboard
//
//  Created by Pawel Milek on 10/26/23.
//

import SwiftUI

struct FavoriteButton: View {
    @Binding var isOn: Bool

    private var symbol: String {
        isOn ? "heart.fill" : "heart"
    }

    private var symbolEffect: BounceSymbolEffect {
        isOn ? .bounce.up.byLayer : .bounce.down.byLayer
    }

    var body: some View {
        Button {
            isOn.toggle()
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
}

#Preview(traits: .sizeThatFitsLayout) {
    VStack(spacing: 10) {
        FavoriteButton(isOn: .constant(true))
        FavoriteButton(isOn: .constant(false))
    }
    .padding()
}
