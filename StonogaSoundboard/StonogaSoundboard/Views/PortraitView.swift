//
//  PortraitView.swift
//  StonogaSoundboard
//
//  Created by Pawel Milek on 10/28/23.
//

import SwiftUI

struct PortraitView: View {
    let image: String

    var body: some View {
        Image(image)
            .resizable()
            .scaledToFit()
            .frame(maxWidth: 50)
            .clipShape(RoundedRectangle(cornerRadius: 5))
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    PortraitView(image: "stonoga")
        .padding()
}
