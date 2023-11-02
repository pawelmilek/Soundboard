//
//  FavoritesSoundTip.swift
//  StonogaSoundboard
//
//  Created by Pawel Milek on 11/2/23.
//

import Foundation
import TipKit

final class FavoritesSoundTip: Tip, ObservableObject {
    static let favoritesSoundEvent = Event(id: "FavoritesSoundEvent")

    var options: [TipOption] {
        Tip.MaxDisplayCount(1)
    }

    var title: Text {
        Text("Favorites")
            .fontWeight(.bold)
    }

    var message: Text? {
        Text("Tap on this button to list favorite sounds.")
    }

    var image: Image? {
        Image(systemName: "heart.fill")
    }

    var rules: [Rule] {
        [
            #Rule(Self.favoritesSoundEvent) { event in
                event.donations.count >= 2
            }
        ]
    }
}
