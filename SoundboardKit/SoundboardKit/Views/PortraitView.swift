//
//  PortraitView.swift
//  SoundboardKit
//
//  Created by Pawel Milek on 10/28/23.
//

import SwiftUI

public struct PortraitView: View {
    let image: String
    let count: Int

    public init(image: String, count: Int) {
        self.image = image
        self.count = count
    }

    public var body: some View {
        Image(image)
            .resizable()
            .scaledToFit()
            .frame(maxHeight: 65)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(alignment: .topLeading) {
                RoundCountView(value: count)
                    .offset(x: -7, y: -8)
            }
            .padding(10)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    PortraitView(image: "stonoga", count: 13)
}
