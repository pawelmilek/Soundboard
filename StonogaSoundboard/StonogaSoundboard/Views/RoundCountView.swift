//
//  RoundCountView.swift
//  StonogaSoundboard
//
//  Created by Pawel Milek on 10/28/23.
//

import SwiftUI

struct RoundCountView: View {
    let count: Int
    @State private var animateCount = 0

    var body: some View {
        VStack {
            Text("\(animateCount)")
                .contentTransition(.numericText(value: Double(animateCount)))
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
                        animateCount = count
                    }
                }
        }
        .id("contentTransitionId \(count)")
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    RoundCountView(count: 13)
        .padding()
}
