//
//  InformationTip.swift
//  Soundboard
//
//  Created by Pawel Milek on 1/24/24.
//

import TipKit

struct InformationTip: Tip {
    static let visitViewEvent = Event(id: "visitInformationViewEvent")

    var title: Text {
        Text("Information")
            .fontWeight(.bold)
            .fontDesign(.monospaced)
    }

    var message: Text? {
        Text("Find important details about the app, feedback and more.")
            .fontDesign(.monospaced)
    }

    var image: Image? {
        Image(systemName: "info.circle.fill")
    }

    var rules: [Rule] {
        [
            #Rule(Self.visitViewEvent) { event in
                event.donations.count == 0
            }
        ]
    }
}
