//
//  Router.swift
//  Soundboard
//
//  Created by Pawel Milek on 1/24/24.
//  Copyright © 2024 Pawel Milek. All rights reserved.
//

import SwiftUI

final class Router: ObservableObject {
    enum Route: Hashable {
        case info
    }

    @Published var routes = [Route]()

    func navigate(to route: Route) {
        routes.append(route)
    }

    func navigateBack() {
        routes.removeLast()
    }

    func popToRoot() {
        routes.removeAll()
    }

    @ViewBuilder
    func view(for route: Route) -> some View {
        switch route {
        case .info:
            InformationView()
        }
    }
}
