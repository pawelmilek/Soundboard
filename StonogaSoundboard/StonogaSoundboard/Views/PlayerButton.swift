//
//  PlayStopButton.swift
//  StonogaSoundboard
//
//  Created by Pawel Milek on 10/26/23.
//

import SwiftUI

struct PlayerButton: View {
    @Binding var isPlaying: Bool

    private var symbol: String {
        isPlaying ? "stop.fill" : "play.fill"
    }

    var body: some View {
        Button {
            isPlaying.toggle()
        } label: {
            Image(systemName: symbol)
                .font(.largeTitle)
                .foregroundColor(.accentColor)
        }
        .tint(.clear)
        .buttonStyle(.bordered)
    }
}

#Preview {
    HStack(spacing: 10) {
        PlayerButton(isPlaying: .constant(true))
            .frame(maxWidth: 44)
        PlayerButton(isPlaying: .constant(false))
            .frame(maxWidth: 44)
    }
}
