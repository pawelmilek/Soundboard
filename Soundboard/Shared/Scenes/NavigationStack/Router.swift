//
//  Router.swift
//  Soundboard
//
//  Created by Pawel Milek on 1/24/24.
//  Copyright © 2024 Pawel Milek. All rights reserved.
//

import SwiftUI

final class Router: ObservableObject {
    enum Route: Hashable, Identifiable {
        case info

        var id: Self { self }
    }

    @Published var routes = [Route]()
    @Published var selectRoute: Route?
    @Published var selectedSound: SoundModel?

    func navigate(to route: Route) {
        if UIDevice.current.userInterfaceIdiom == .phone {
            routes.append(route)
        } else {
            selectRoute = route
        }
    }

    func navigateBack() {
        if UIDevice.current.userInterfaceIdiom == .phone {
            routes.removeLast()
        } else {
            selectRoute = nil
        }
    }

    func popToRoot() {
        if UIDevice.current.userInterfaceIdiom == .phone {
            routes.removeAll()
        } else {
            selectRoute = nil
        }
    }

    @ViewBuilder
    func view(for route: Route) -> some View {
        switch route {
        case .info:
            InformationView()
        }
    }
}
