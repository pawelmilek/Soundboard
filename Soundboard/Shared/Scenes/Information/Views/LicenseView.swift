//
//  LicenseView.swift
//  Soundboard
//
//  Created by Pawel Milek on 1/24/24.
//

import SwiftUI

struct LicenseView: View {
    @StateObject private var reader = LicenseReader(fileName: "packages_license")

    var body: some View {
        HTMLView(fileURL: reader.fileURL)
            .padding(.top, 1)
            .navigationBarTitle("Licenses")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                try? reader.readFileURL()
            }
    }
}

#Preview {
    NavigationStack {
        LicenseView()
    }
}
