//
//  PlayStopView.swift
//  Soundboard
//
//  Created by Pawel Milek on 3/7/24.
//  Copyright © 2024 Pawel Milek. All rights reserved.
//

import SwiftUI

struct PlayStopView: View {
    @EnvironmentObject private var composer: SoundComposer

    var body: some View {
        HStack(spacing: 10) {
            Button(action: play) {
                Image(systemName: "play.circle.fill")
            }
            Button(action: stop) {
                Image(systemName: "stop.circle.fill")
            }
        }
        .font(.system(size: 45, weight: .regular))
        .padding(5)
        .background {
            Capsule(style: .continuous)
                .foregroundStyle(Color(.systemBackground))
                .shadow(color: .primary.opacity(0.05), radius: 4, x: 0, y: 0)
        }
    }

    private func play() {
        composer.playSample()
    }

    private func stop() {
        composer.stopSample()
    }
}

#Preview {
    PlayStopView()
        .environmentObject(
            SoundComposer(
                player: QueueSoundPlayer(),
                soundResourcesManager: SoundResourcesManager()
            )
        )
        .padding()
        .background(Color(.systemGroupedBackground))
}
