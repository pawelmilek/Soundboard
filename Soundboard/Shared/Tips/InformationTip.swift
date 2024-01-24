//
//  InformationTip.swift
//  Soundboard
//
//  Created by Pawel Milek on 1/24/24.
//

import TipKit

struct InformationTip: Tip {
    public var options: [TipOption] {
        Tip.MaxDisplayCount(1)
    }

    var title: Text {
        Text("Information")
            .fontWeight(.bold)
    }

    var message: Text? {
        Text("Find important details about the app, feedback and more.")
    }

    var image: Image? {
        Image(systemName: "info.circle.fill")
    }
}
