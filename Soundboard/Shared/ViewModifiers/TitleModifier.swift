//
//  TitleModifier.swift
//  Soundboard
//
//  Created by Pawel Milek on 10/31/23.
//

import Foundation
import SwiftUI

struct TitleModifier: ViewModifier {
    enum InterfaceIdiom {
        case phone
        case pad

        var font: Font { .subheadline }
        var fontWeight: Font.Weight { .semibold }

        var lineLimit: (limit: Int, reservesSpace: Bool) {
            switch self {
            case .phone: (2, true)
            case .pad: (3, false)
            }
        }
    }

    private let interface: InterfaceIdiom

    init(interface: InterfaceIdiom) {
        self.interface = interface
    }

    func body(content: Content) -> some View {
        content
            .font(interface.font)
            .fontWeight(interface.fontWeight)
            .lineLimit(
                interface.lineLimit.limit,
                reservesSpace: interface.lineLimit.reservesSpace
            )
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

extension View {
    func titleStyle(_ interfaceIdiom: TitleModifier.InterfaceIdiom) -> some View {
        modifier(TitleModifier(interface: interfaceIdiom))
    }

    func searchResultStyle() -> some View {
        modifier(SearchResult())
    }
}
