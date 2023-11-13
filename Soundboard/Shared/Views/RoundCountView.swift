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
                .fontWeight(.semibold)
                .fontDesign(.rounded)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .frame(maxWidth: 13, maxHeight: 13)
                .padding(3)
                .background(.accent)
                .foregroundStyle(.white)
                .clipShape(Circle())
                .padding(2.5)
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
    RoundCountView(value: 59)
        .padding()
}
