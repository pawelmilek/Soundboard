//
//  HTMLView.swift
//  Soundboard
//
//  Created by Pawel Milek on 1/24/24.
//

import UIKit
import SwiftUI
import WebKit

struct HTMLView: UIViewRepresentable {
    typealias UIViewType = WKWebView

    private let fileURL: URL?

    init(fileURL: URL?) {
        self.fileURL = fileURL
    }

    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.allowsBackForwardNavigationGestures = true
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let fileURL else { return }
        uiView.loadFileURL(fileURL, allowingReadAccessTo: fileURL)
    }
}
