//
//  RoundCountView.swift
//  Soundboard
//
//  Created by Pawel Milek on 10/28/23.
//

import SwiftUI

public struct RoundCountView: View {
    let value: Int
    @State private var animatedValue = 0
    private let height = CGFloat(13)
    private let font = Font.caption2

    public var body: some View {
        VStack {
            Text("\(animatedValue)")
                .contentTransition(.numericText(value: Double(animatedValue)))
                .font(font)
                .fontWeight(.semibold)
                .fontDesign(.rounded)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .frame(maxWidth: height, maxHeight: height)
                .padding(3)
                .background(.accent)
                .foregroundStyle(.white)
                .clipShape(Circle())
                .padding(2.5)
                .background(Color(UIColor.systemGray6))
                .clipShape(Circle())
                .animation(.default, value: animatedValue)
        }
        .onAppear {
            withAnimation {
                animatedValue = value
            }
        }
        .id("contentTransitionId \(value)")
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    RoundCountView(value: 59)
        .padding()
}
