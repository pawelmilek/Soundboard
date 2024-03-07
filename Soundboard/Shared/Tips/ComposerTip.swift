//
//  ComposerTip.swift
//  Soundboard
//
//  Created by Pawel Milek on 3/9/24.
//  Copyright © 2024 Pawel Milek. All rights reserved.
//

import Foundation
import TipKit

struct ComposerTip: Tip {
    public var options: [TipOption] {
        Tip.MaxDisplayCount(1)
    }

    var title: Text {
        Text("Composer")
            .fontWeight(.bold)
    }

    var message: Text? {
        Text("Compose and share your own sounds.")
    }

    var image: Image? {
        Image(systemName: "music.quarternote.3")
    }
}
