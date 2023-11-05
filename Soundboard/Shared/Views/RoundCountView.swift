//
//  RoundCountView.swift
//  Soundboard
//
//  Created by Pawel Milek on 10/28/23.
//

import SwiftUI

public struct RoundCountView: View {
    let value: Int
    @State private var animateValue = 0

    public var body: some View {
        VStack {
            Text("\(animateValue)")
                .contentTransition(.numericText(value: Double(animateValue)))
                .font(.caption2)
                .fontWeight(.heavy)
                .fontDesign(.rounded)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .frame(maxWidth: 11, maxHeight: 11)
                .padding(3)
                .background(.background)
                .clipShape(Circle())
                .padding(2)
                .background(Color(UIColor.systemGray6))
                .clipShape(Circle())
                .onAppear {
                    withAnimation {
                        animateValue = value
                    }
                }
        }
        .id("contentTransitionId \(value)")
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    RoundCountView(value: 13)
        .padding()
}
