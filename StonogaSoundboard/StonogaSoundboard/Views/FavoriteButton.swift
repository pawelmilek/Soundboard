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
        Image(systemName: symbol)
            .resizable()
            .scaledToFit()
            .foregroundColor(isOn ? .accentColor : .gray)
            .symbolEffect(symbolEffect, value: isOn)
            .onTapGesture {
                isOn.toggle()
            }
    }
}

#Preview {
    HStack(spacing: 15) {
        FavoriteButton(isOn: .constant(true))
            .frame(maxWidth: 44)
        FavoriteButton(isOn: .constant(false))
            .frame(maxWidth: 44)
    }
}
