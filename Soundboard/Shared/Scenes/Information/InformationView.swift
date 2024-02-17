//
//  InformationView.swift
//  Soundboard
//
//  Created by Pawel Milek on 1/24/24.
//

import SwiftUI
import StoreKit

struct InformationView: View {
    @StateObject private var viewModel = InformationViewModel()
    @Environment(\.openURL) private var openURL

    var body: some View {
        List {
            Section {
                InfoRow(
                    tintColor: .blue,
                    symbol: "apps.iphone",
                    title: "Application",
                    content: viewModel.appName,
                    link: nil,
                    action: nil
                )
                InfoRow(
                    tintColor: .blue,
                    symbol: "gear",
                    title: "Version",
                    content: viewModel.appVersion,
                    link: nil,
                    action: nil
                )
                InfoRow(
                    tintColor: .blue,
                    symbol: "info.circle",
                    title: "Compatibility",
                    content: viewModel.appCompatibility,
                    link: nil,
                    action: nil
                )
                FrameworkList(
                    title: "Frameworks",
                    content: viewModel.frameworks
                )
                InfoRow(
                    tintColor: .green,
                    symbol: "ellipsis.curlybraces",
                    title: "Developer",
                    content: "Pawel Milek",
                    link: nil,
                    action: nil
                )
                InfoRow(
                    tintColor: Color(.accent),
                    symbol: "globe",
                    title: "Website",
                    content: nil,
                    link: (
                        destination: viewModel.appURLString,
                        label: viewModel.appName
                    ),
                    action: nil
                )
            } header: {
                Text("About the app")
            }

            Section {
                InfoRow(
                    tintColor: .blue,
                    symbol: "envelope.fill",
                    title: "Contact",
                    content: nil,
                    link: nil,
                    action: reportFeedback
                )
                InfoRow(
                    tintColor: .red,
                    symbol: "ant.fill",
                    title: "Report Issue",
                    content: nil,
                    link: nil,
                    action: reportIssue
                )
                InfoRow(
                    tintColor: .yellow,
                    symbol: "star.fill",
                    title: "Rate Application",
                    content: nil,
                    link: nil,
                    action: openWriteReview
                )
            } header: {
                Text("Feedback")
            }

            Section {
                NavigationLink {
                    LicenseView()
                } label: {
                    InfoRow(
                        tintColor: .blue,
                        symbol: "doc.plaintext.fill",
                        title: "Licenses",
                        content: nil,
                        link: nil,
                        action: nil
                    )
                }
                InfoRow(
                    tintColor: .blue,
                    symbol: "lock.shield.fill",
                    title: "Privacy Policy",
                    content: nil,
                    link: nil,
                    action: openDataPrivacyPolicy
                )
            } header: {
                Text("Documents")
            } footer: {
                HStack {
                    Text(viewModel.copyright)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .padding(.vertical, 8)
            }
            .padding(.top, 1)
            .navigationTitle("Info")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private func reportFeedback() {
        viewModel.reportFeedback(openURL)
    }

    private func reportIssue() {
        viewModel.reportIssue(openURL)
    }

    private func openDataPrivacyPolicy() {
        viewModel.openDataPrivacyPolicy(openURL)
    }

    private func openWriteReview() {
        viewModel.openWriteReview(openURL)
    }
}

#Preview {
    NavigationStack {
        InformationView()
    }
}
