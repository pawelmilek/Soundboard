//
//  StoreComposerTip.swift
//  Soundboard
//
//  Created by Pawel Milek on 3/11/24.
//  Copyright © 2024 Pawel Milek. All rights reserved.
//

import Foundation
import TipKit

struct StoreComposerTip: Tip {
    public var options: [TipOption] {
        Tip.MaxDisplayCount(1)
    }

    var title: Text {
        Text("Store")
            .fontWeight(.bold)
    }

    var message: Text? {
        Text("Store new sound bits.")
    }

    var image: Image? {
        Image(systemName: "externaldrive.badge.plus")
    }
}
