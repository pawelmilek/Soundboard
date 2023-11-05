//
//  Title.swift
//  StonogaSoundboard
//
//  Created by Pawel Milek on 10/31/23.
//

import Foundation
import SwiftUI

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .fontWeight(.semibold)
            .lineLimit(2, reservesSpace: true)
            .foregroundStyle(.primary)
    }
}

struct SearchResult: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .fontWeight(.semibold)
            .foregroundStyle(.primary)
    }
}

public extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }

    func searchResultStyle() -> some View {
        modifier(SearchResult())
    }
}
