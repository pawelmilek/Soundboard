//
//  PortraitView.swift
//  Soundboard
//
//  Created by Pawel Milek on 10/28/23.
//

import SwiftUI

struct PortraitView: View {
    let image: String
    let count: Int

    private var isPhone: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }

    private var imageHeight: CGFloat {
        isPhone ? 65 : 55
    }

    private var cornerRadius: CGFloat {
        isPhone ? 12 : 5
    }

    var body: some View {
        Image(image)
            .resizable()
            .scaledToFit()
            .frame(maxHeight: imageHeight)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .overlay(alignment: .topLeading) {
                RoundCountView(value: count)
                    .offset(x: -7, y: -8)
            }
            .padding(10)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    PortraitView(image: "portrait", count: 13)
}
