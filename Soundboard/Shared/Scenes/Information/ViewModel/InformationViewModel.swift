//
//  InformationViewModel.swift
//  Soundboard
//
//  Created by Pawel Milek on 1/24/24.
//  Copyright © 2024 Pawel Milek. All rights reserved.
//

import SwiftUI
import Combine

@MainActor
final class InformationViewModel: ObservableObject {
    private enum Constant {
        static let recipient = "pawel.milek0626@gmail.com"
        static let appURLString = "https://sites.google.com/view/pmilek/trump-board"
        static let privacyPolicyURLString = "https://sites.google.com/view/pmilek/privacy-policy"
        static let writeReviewURLString = "https://apps.apple.com/app/id6473635641?action=write-review"
    }

    @Published private(set) var appName = ""
    @Published private(set) var appVersion = ""
    @Published private(set) var appCompatibility = ""
    @Published private(set) var appURLString = ""
    @Published private(set) var copyright = ""
    @Published private(set) var frameworks = [String]()

    private let recipient: String
    private let privacyPolicyURL: URL
    private let writeReviewURL: URL

    init() {
        appName = Bundle.applicationName
        appVersion = "\(Bundle.versionNumber) (\(Bundle.buildNumber))"
        appCompatibility = "iOS \(Bundle.minimumOSVersion)"
        appURLString = Constant.appURLString
        recipient = Constant.recipient
        privacyPolicyURL = URL(string: Constant.privacyPolicyURLString)!
        writeReviewURL = URL(string: Constant.writeReviewURLString)!

        copyright = "Copyright © All right reserved."
        frameworks = ["SwiftUI", "Combine", "StoreKit", "WebKit", "TipKit"]
    }

    func reportFeedback(_ openURL: OpenURLAction) {
        let feedbackEmail = SupportEmail(
            recipient: recipient,
            subject: "[Feedback] Swifty Forecast"
        )

        feedbackEmail.send(openURL: openURL)
    }

    func reportIssue(_ openURL: OpenURLAction) {
        let bugEmail = SupportEmail(
            recipient: recipient,
            subject: "[Bug] Swifty Forecast"
        )
        bugEmail.send(openURL: openURL)
    }

    func openDataPrivacyPolicy(_ openURL: OpenURLAction) {
        openURL(privacyPolicyURL)
    }

    func openWriteReview(_ openURL: OpenURLAction) {
        openURL(writeReviewURL)
    }
}
