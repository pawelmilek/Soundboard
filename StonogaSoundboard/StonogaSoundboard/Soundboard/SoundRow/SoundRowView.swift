//
//  SoundRowView.swift
//  StonogaSoundboard
//
//  Created by Pawel Milek on 10/25/23.
//

import SwiftUI

struct SoundRowView: View {
    @EnvironmentObject var soundboardViewModel: SoundboardView.ViewModel
    @ObservedObject var viewModel: SoundRowView.ViewModel

    private var soundIndex: Int {
        soundboardViewModel.soundIndex(with: viewModel.fileName)
    }

    var body: some View {
        HStack(spacing: 10) {
            PortraitView(image: "stonoga")
                .padding(.horizontal, 4)
            VStack(alignment: .leading, spacing: 5) {
                Text(viewModel.title)
                    .font(.body)
                    .fontWeight(.bold)
                    .fontDesign(.rounded)
                    .lineLimit(2)
                    .frame(minHeight: 43, maxHeight: 43, alignment: .center)
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack(spacing: 20) {
                    FavoriteButton(isOn: $soundboardViewModel.models[soundIndex].isFavorite)
                        .onChange(of: soundboardViewModel.models[soundIndex].isFavorite) {
                            soundboardViewModel.save()
                        }
                    ShareButton(content: viewModel.shareSound)
                }
                .frame(maxHeight: 18)
            }
            PlayerButton(isPlaying: $soundboardViewModel.models[soundIndex].isPlaying)
                .onChange(of: soundboardViewModel.models[soundIndex].isPlaying) { oldState, newState in
                    debugPrint("name: \(viewModel.fileName)")
                    soundboardViewModel.playStop(viewModel.fileName, from: oldState, to: newState)
                }
        }
        .padding(10)
        .background(Color(UIColor.systemGray6))
        .cornerRadius(15)
        .shadow(color: .gray.opacity(0.3), radius: 0.2, x: 1, y: 1)
        .overlay(alignment: .topLeading) {
            RoundCountView(count: viewModel.playbackCount)
            .offset(x: 5, y: 5)
        }

    }
}

#Preview(traits: .sizeThatFitsLayout) {
    SoundRowView(
        viewModel: .init(model: SoundModel.example.first!)
    )
    .padding()
    .environmentObject(SoundboardView.ViewModel())
}

#Preview(traits: .sizeThatFitsLayout) {
    SoundRowView(
        viewModel: .init(model: SoundModel.example.last!)
    )
    .padding()
    .environmentObject(SoundboardView.ViewModel())
}
