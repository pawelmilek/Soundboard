//
//  SoundboardRow.swift
//  Soundboard
//
//  Created by Pawel Milek on 10/25/23.
//

import SwiftUI
import RealmSwift

struct SoundboardRow: View {
    @ObservedRealmObject var item: SoundModel
    let shareContent: ShareContent
    var onPlayButton: () -> Void

    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            PortraitView(
                image: "portrait",
                count: item.playbackCount
            )
            VStack(alignment: .leading, spacing: 5) {
                Text(item.title)
                    .titleStyle()
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack(spacing: 5) {
                    FavoriteButton(isOn: $item.isFavorite)
                    ShareButton(content: shareContent)
                }
            }
            .fixedSize(horizontal: false, vertical: true)
            PlayButton(
                count: $item.playbackCount,
                onAction: onPlayButton
            )
        }
        .listRowSeparator(.hidden)
        .fixedSize(horizontal: false, vertical: true)
        .background(Color(UIColor.systemGray6))
        .cornerRadius(15)
        .shadow(color: .primary.opacity(0.2), radius: 0.05, x: 0, y: 0.5)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    SoundboardRow(
        item: RealmManager(name: "stonoga.soundboard").realm!.objects(SoundModel.self)[3],
        shareContent: ShareContent.default,
        onPlayButton: { }
    )
    .padding()
    .environmentObject(SoundboardViewModel())
}

#Preview(traits: .sizeThatFitsLayout) {
    SoundboardRow(
        item: RealmManager(name: "stonoga.soundboard").realm!.objects(SoundModel.self).last!,
        shareContent: ShareContent.default,
        onPlayButton: { }
    )
    .padding()
    .environmentObject(SoundboardViewModel())
}
