//
//  PlayButton.swift
//  SoundboardKit
//
//  Created by Pawel Milek on 10/26/23.
//

import SwiftUI

public struct PlayButton: View {
    @Binding var count: Int
    @State private var isOn = false

    var onAction: @MainActor () -> Void
    private let symbol = "play.circle.fill"

    public init(count: Binding<Int>, onAction: @escaping () -> Void) {
        self._count = count
        self.onAction = onAction
    }

    public var body: some View {
        Image(systemName: symbol)
            .symbolEffect(
                .bounce.down.byLayer,
                value: isOn
            )
            .font(.system(size: 40))
            .fontWeight(.thin)
            .foregroundColor(.accentColor)
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
