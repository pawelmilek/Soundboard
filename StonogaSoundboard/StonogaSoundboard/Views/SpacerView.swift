//
//  SpacerView.swift
//  StonogaSoundboard
//
//  Created by Pawel Milek on 10/27/23.
//

import SwiftUI

struct SpacerView: View {
    var body: some View {
        Image(systemName: "circle.fill")
            .resizable()
            .scaledToFit()
            .foregroundColor(.gray)
            .frame(maxHeight: 3)
    }
}

#Preview {
    SpacerView()
}
