//
//  SoundDetailView.swift
//  Soundboard
//
//  Created by Pawel Milek on 2/19/24.
//  Copyright © 2024 Pawel Milek. All rights reserved.
//

import SwiftUI
import RealmSwift

struct SoundDetailView: View {
    @ObservedRealmObject var item: SoundModel
    let shareContent: ShareContent
    var onPlayButton: () -> Void

    var body: some View {
        VStack(spacing: 15) {
            Image("portrait")
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 350)
                .clipShape(
                    RoundedRectangle(cornerRadius: 25)
                )
                .shadow(color: .accent, radius: 5, x: 0, y: 0)
                .overlay(alignment: .topTrailing) {
                    VStack(spacing: 0) {
                        FavoritePadButton(isOn: $item.isFavorite)
                        SharePadButton(content: shareContent)
                    }
                    .foregroundStyle(.white)
                    .padding()
                }

            Text(item.title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .lineLimit(1, reservesSpace: true)
                .minimumScaleFactor(0.9)
            PlayButton(
                count: $item.playbackCount,
                onAction: onPlayButton
            )
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    SoundDetailView(
        item: RealmManager(name: "stonoga.soundboard").realm!.objects(SoundModel.self)[3],
        shareContent: ShareContent.default,
        onPlayButton: { }
    )
    .padding()
    .environmentObject(SoundboardViewModel())
}
