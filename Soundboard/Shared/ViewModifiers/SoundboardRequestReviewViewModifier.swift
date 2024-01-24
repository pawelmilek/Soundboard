//
//  SoundboardRequestReviewViewModifier.swift
//  Soundboard
//
//  Created by Pawel Milek on 1/24/24.
//

import SwiftUI
import RealmSwift
import StoreKit

struct SoundboardRequestReviewViewModifier: ViewModifier {
    @Environment(\.requestReview) private var requestReview
    @AppStorage("lastVersionPromptedForReview") private var lastVersionPromptedForReview = ""
    @ObservedResults(SoundModel.self, where: { $0.isFavorite }) private var favoriteSounds

    func body(content: Content) -> some View {
        content
            .onAppear {
                checkIfValidForReview()
        }
    }

    private func checkIfValidForReview() {
        guard RequestReviewRequirementsVerification.isRequestValid(
            favoriteCount: favoriteSounds.count,
            lastVersionPromptedForReview: lastVersionPromptedForReview
        ) else { return }

        lastVersionPromptedForReview = RequestReviewRequirementsVerification.appVersion
        presentReview()
    }

    private func presentReview() {
        Task {
            try await Task.sleep(for: .seconds(1.5))
            requestReview()
        }
    }
}

extension View {
    func soundboardRequestReview() -> some View {
        modifier(SoundboardRequestReviewViewModifier())
    }
}

