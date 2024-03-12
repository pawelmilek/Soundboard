//
//  ComposerView.swift
//  Soundboard
//
//  Created by Pawel Milek on 3/7/24.
//  Copyright © 2024 Pawel Milek. All rights reserved.
//

import SwiftUI
import RealmSwift
import TipKit

struct ComposerView: View {
    @ObservedResults(SoundModel.self) private var sounds
    @EnvironmentObject private var realmManager: RealmManager
    @State private var composeSounds = [SoundModel]()
    @State private var newSound: SoundModel?
    @State private var newSoundName = ""
    @State private var presentFormAlert = false
    @State private var presentError = false
    @State private var presentComposerError = false
    @StateObject private var composer = SoundComposer(
        player: QueueSoundPlayer(),
        soundResourcesManager: SoundResourcesManager()
    )
    private var isButtonDisabled: Bool { composeSounds.isEmpty }

    var body: some View {
        VStack {
            ScrollView(.vertical) {
                WrappedHStack(sounds) { item in
                    Button {
                        addComposeSound(item)
                    } label: {
                        ComposerGridItem(
                            title: item.title,
                            fill: Color(UIColor.systemGray)
                        )
                    }
                }
                .padding(.horizontal, 10)
            }
            GroupBox {
                ScrollView(.vertical) {
                    WrappedHStack(composeSounds) { item in
                        Button {
                            removeComposeSound(item)
                        } label: {
                            ComposerGridItem(
                                title: item.title,
                                fill: .accent
                            )
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .animation(.bouncy, value: composeSounds)
                .overlay {
                    ContentUnavailableView(
                        "No sounds selected",
                        systemImage: "music.note.list"
                    )
                    .opacity(composeSounds.isEmpty ? 1 : 0)
                    .animation(.easeOut, value: composeSounds)
                }
                PlayStopView()
                    .padding(.bottom, 15)
                    .disabled(isButtonDisabled)
                    .animation(.easeOut, value: composeSounds)
                    .environmentObject(composer)
            } label: {
                HStack {
                    Text("Compose a sound bit")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Button(action: presentNewSoundForm) {
                        Image(systemName: "externaldrive.badge.plus")
                    }
                    .buttonStyle(.bordered)
                    .disabled(isButtonDisabled)
                    .popoverTip(StoreComposerTip(), arrowEdge: .top)
                }
            }
            .ignoresSafeArea(edges: .bottom)
            .frame(height: 290)
        }
        .scrollBounceBehavior(.basedOnSize)
        .navigationTitle("Composer")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Sound", isPresented: $presentFormAlert) {
            TextField("Name", text: $newSoundName)
                .autocorrectionDisabled()
            Button("Cancel", action: cancelSound)
            Button("Save", action: saveSound)
                .disabled(newSoundName.isEmpty)
        } message: {
            Text("Please enter an extraordinary sound name.")
        }
        .alert("Error", isPresented: $presentError, presenting: newSoundName) { _ in
        } message: { newSoundName in
            Text("Please choose different name. File \"\(newSoundName)\" already exists.")
        }
        .alert(composer.errorMessage, isPresented: $presentComposerError) {
            Button("OK") { }
        }
        .onReceive(composer.$soundURL) { composedSoundURL in
            guard let composedSoundURL else { return }
            insertComposedSoundModel(at: composedSoundURL)
        }
        .onReceive(composer.$errorMessage) { errorMessage in
            guard !errorMessage.isEmpty else { return }
            presentComposerError.toggle()
        }
    }

    private func insertComposedSoundModel(at url: URL) {
        let fileName = [url.lastPathComponent]
        realmManager.insert(Set(fileName))
    }

    private func presentNewSoundForm() {
        presentFormAlert.toggle()
    }

    private func addComposeSound(_ item: SoundModel) {
        composeSounds.append(item)
        composer.addItem(with: item.fileName)
    }

    private func removeComposeSound(_ item: SoundModel) {
        guard let index = composeSounds.firstIndex(of: item) else { return }
        composeSounds.remove(at: index)
        composer.removeItem(at: index)
    }

    private func saveSound() {
        if sounds.contains(where: { $0.fileName == newSoundName }) {
            presentError.toggle()
        } else {
            composer.compose(with: newSoundName)
            composeSounds.removeAll()
        }
        clearSoundName()
    }

    private func cancelSound() {
        clearSoundName()
    }

    private func clearSoundName() {
        newSoundName = ""
    }
}

#Preview {
    NavigationStack {
        ComposerView()
            .injectDependencies()
    }
}
