//
//  SoundRowView.swift
//  StonogaSoundboard
//
//  Created by Pawel Milek on 10/25/23.
//

import SwiftUI
import RealmSwift

struct SoundRowView: View {
    @EnvironmentObject private var listViewModel: SoundboardListView.ViewModel
    @StateObject private var viewModel = SoundRowView.ViewModel()
    @ObservedRealmObject var item: SoundModel

    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            PortraitView(
                image: viewModel.portraitName,
                count: viewModel.playbackCount
            )
            VStack(alignment: .leading, spacing: 5) {
                Text(viewModel.title)
                    .titleStyle()
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack(spacing: 5) {
                    FavoriteButton(isOn: $item.isFavorite)
                    ShareButton(content: viewModel.shareSound)
                }
            }
            .fixedSize(horizontal: false, vertical: true)
            PlayButton(
                count: $item.playbackCount,
                onAction: {
                    listViewModel.play(item.fileName)
                }
            )
        }
        .fixedSize(horizontal: false, vertical: true)
        .background(Color(UIColor.systemGray6))
        .cornerRadius(15)
        .shadow(color: .primary.opacity(0.2), radius: 0.05, x: 0, y: 0.5)
        .onAppear {
            viewModel.onAppear(item)
        }
        .onChange(of: item) {
            viewModel.onChange(item)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    SoundRowView(
        item: RealmManager(name: "stonoga.soundboard").realm!.objects(SoundModel.self)[3]
    )
    .padding()
    .environmentObject(SoundboardListView.ViewModel())
}

#Preview(traits: .sizeThatFitsLayout) {
    SoundRowView(
        item: RealmManager(name: "stonoga.soundboard").realm!.objects(SoundModel.self).last!
    )
    .padding()
    .environmentObject(SoundboardListView.ViewModel())
}
