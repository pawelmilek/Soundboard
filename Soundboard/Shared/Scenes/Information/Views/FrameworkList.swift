//
//  FrameworkList.swift
//  Soundboard
//
//  Created by Pawel Milek on 1/24/24.
//

import SwiftUI

struct FrameworkList: View {
    let title: String
    let content: [String]

    var body: some View {
        DisclosureGroup {
            ForEach(content, id: \.self) { item in
                HStack {
                    Text(item)
                        .fontDesign(.monospaced)
                        .foregroundStyle(.accent)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Image(systemName: "books.vertical.fill")
                        .foregroundStyle(.orange)

                }
                .font(.caption)
                .fontWeight(.heavy)
                .padding(.leading, 15)
            }
        } label: {
            InfoRow(
                tintColor: .orange,
                symbol: "swift",
                title: title,
                content: nil,
                link: nil,
                action: nil
            )
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    let frameworks = [
        "SwiftUI",
        "Combine",
        "StoreKit",
        "WebKit",
        "TipKit"
    ]

    return FrameworkList(
        title: "Frameworks",
        content: frameworks
    )
    .padding()
}
