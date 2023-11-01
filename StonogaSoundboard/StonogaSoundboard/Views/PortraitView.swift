//
//  PortraitView.swift
//  StonogaSoundboard
//
//  Created by Pawel Milek on 10/28/23.
//

import SwiftUI

struct PortraitView: View {
    let image: String
    let count: Int

    var body: some View {
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
