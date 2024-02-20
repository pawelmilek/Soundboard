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

    private var imageHeight: CGFloat {
        UIDevice.current.userInterfaceIdiom == .phone ? 65 : 55
    }

    private var cornerRadius: CGFloat {
        UIDevice.current.userInterfaceIdiom == .phone ? 12 : 5
    }

    var body: some View {
        let _ = print(Self._printChanges())

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
