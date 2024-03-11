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
    @Published private(set) var appName = ""
    @Published private(set) var appVersion = ""
    @Published private(set) var appCompatibility = ""
    @Published private(set) var appURLString = ""
    @Published private(set) var appStorePreviewURL = ""
    @Published private(set) var copyright = ""
    @Published private(set) var frameworks = [String]()
    @Published private(set) var previewTip = AppStorePreviewTip()
    private var recipient: String?
    private var privacyPolicyURL: URL?
    private var writeReviewURL: URL?

    init() {
        appName = Bundle.applicationName
        appVersion = "\(Bundle.versionNumber) (\(Bundle.buildNumber))"
        appCompatibility = "iOS \(Bundle.minimumOSVersion)"

        let currentYear = String(Calendar.current.component(.year, from: .now))
        copyright = "Copyright © \(currentYear) Pawel Milek.\nAll rights reserved."
        frameworks = ["SwiftUI", "Combine", "StoreKit", "WebKit", "TipKit"]
        appStorePreviewURL = "https://apps.apple.com/us/developer/pawel-milek/id1139599148"
        setupConfigurationValues()
    }

    private func setupConfigurationValues() {
        do {
            appURLString = try CustomConfigurationAccessor.value(for: .appURL)
            recipient = try CustomConfigurationAccessor.value(for: .supportEmail)

            let privacyPolicyURLString = try CustomConfigurationAccessor.value(for: .appPrivacyPolicyURL)
            privacyPolicyURL = URL(string: privacyPolicyURLString)

            let appID = try CustomConfigurationAccessor.value(for: .appID)
            let writeReviewURLString = "https://apps.apple.com/app/id\(appID)?action=write-review"
            writeReviewURL = URL(string: writeReviewURLString)
        } catch {
            debugPrint(error.localizedDescription)
        }
    }

    func reportFeedback(_ openURL: OpenURLAction) {
        guard let recipient else { return }
        let feedbackEmail = SupportEmail(
            recipient: recipient,
            subject: "[Feedback] Swifty Forecast"
        )

        feedbackEmail.send(openURL: openURL)
    }

    func reportIssue(_ openURL: OpenURLAction) {
        guard let recipient else { return }
        let bugEmail = SupportEmail(
            recipient: recipient,
            subject: "[Bug] Swifty Forecast"
        )
        bugEmail.send(openURL: openURL)
    }

    func openDataPrivacyPolicy(_ openURL: OpenURLAction) {
        guard let privacyPolicyURL else { return }
        openURL(privacyPolicyURL)
    }

    func openWriteReview(_ openURL: OpenURLAction) {
        guard let writeReviewURL else { return }
        openURL(writeReviewURL)
    }
}
