//
//  SoundboardPadRow.swift
//  Soundboard
//
//  Created by Pawel Milek on 2/16/24.
//  Copyright © 2024 Pawel Milek. All rights reserved.
//

import SwiftUI
import RealmSwift

struct SoundboardPadRow: View {
    @ObservedRealmObject var item: SoundModel

    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            PortraitView(
                image: "portrait",
                count: item.playbackCount
            )
            VStack {
                Text(item.title)
                    .titleStyle(.pad)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .alignmentGuide(.listRowSeparatorLeading) { _ in 0 }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    SoundboardPadRow(
        item: RealmManager(name: "stonoga.soundboard").realm!.objects(SoundModel.self)[3]
    )
    .padding()
    .environmentObject(SoundboardViewModel())
}

#Preview(traits: .sizeThatFitsLayout) {
    SoundboardPadRow(
        item: RealmManager(name: "stonoga.soundboard").realm!.objects(SoundModel.self).last!
    )
    .padding()
    .environmentObject(SoundboardViewModel())
}

