//
//  PlayButton.swift
//  Soundboard
//
//  Created by Pawel Milek on 10/26/23.
//

import SwiftUI

struct PlayButton: View {
    @Binding var count: Int
    @State private var isOn = false

    var onAction: @MainActor () -> Void
    private let symbol = "play.circle.fill"

    private var font: Font {
        UIDevice.current.userInterfaceIdiom == .phone
        ? .system(size: 40)
        : .system(size: 120)
    }

    init(count: Binding<Int>, onAction: @escaping () -> Void) {
        self._count = count
        self.onAction = onAction
    }

    var body: some View {
        Image(systemName: symbol)
            .symbolEffect(
                .bounce.down.byLayer,
                value: isOn
            )
            .font(font)
            .fontWeight(.semibold)
            .foregroundColor(.accentColor)
            .shadow(color: .primary.opacity(0.25), radius: 2, x: 0, y: 0)
            .onTapGesture {
                onAction()
                isOn.toggle()
                count += 1
            }
            .padding(.trailing, 5)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    PlayButton(count: .constant(1), onAction: {})
        .padding()
}
