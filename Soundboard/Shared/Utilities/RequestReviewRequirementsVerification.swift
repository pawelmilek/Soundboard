//
//  RequestReviewRequirementsVerification.swift
//  Soundoard
//
//  Created by Pawel Milek on 1/24/24.
//

import Foundation

struct RequestReviewRequirementsVerification {
    static let appVersion = Bundle.versionNumber
    static private let minFavoriteSoundsBeforeRequestReview = 2

    static func isRequestValid(favoriteCount: Int, lastVersionPromptedForReview: String) -> Bool {
        let hasMetMinFavoriteNumber = favoriteCount >= minFavoriteSoundsBeforeRequestReview
        let hasRateCurrentAppVersion = appVersion == lastVersionPromptedForReview
        return hasMetMinFavoriteNumber && !hasRateCurrentAppVersion
    }
}
