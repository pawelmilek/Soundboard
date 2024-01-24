//
//  SoundboardNavigationStack.swift
//  Soundboard
//
//  Created by Pawel Milek on 1/24/24.
//  Copyright © 2024 Pawel Milek. All rights reserved.
//

import SwiftUI

struct SoundboardNavigationStack: View {
    @EnvironmentObject private var router: Router

    var body: some View {
        NavigationStack(path: $router.routes) {
            SoundboardView()
                .navigationDestination(for: Router.Route.self) { route in
                    router.view(for: route)
                }
        }
    }
}

#Preview {
    SoundboardNavigationStack()
        .environmentObject(Router())
}
