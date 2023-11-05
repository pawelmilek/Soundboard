//
//  FavoritesSoundTip.swift
//  Soundboard
//
//  Created by Pawel Milek on 11/2/23.
//

import Foundation
import TipKit

public final class FavoritesSoundTip: Tip, ObservableObject {
    public static let favoritesSoundEvent = Event(id: "FavoritesSoundEvent")

    public init() { }

    public var options: [TipOption] {
        Tip.MaxDisplayCount(1)
    }

    public var title: Text {
        Text("Favorites")
            .fontWeight(.bold)
    }

    public var message: Text? {
        Text("Tap on this button to list favorite sounds.")
    }

    public var image: Image? {
        Image(systemName: "heart.fill")
    }

    public var rules: [Rule] {
        [
            #Rule(Self.favoritesSoundEvent) { event in
                event.donations.count >= 2
            }
        ]
    }
}
