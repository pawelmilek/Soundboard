//
//  Router.swift
//  Soundboard
//
//  Created by Pawel Milek on 1/24/24.
//  Copyright © 2024 Pawel Milek. All rights reserved.
//
// swiftlint:disable identifier_name

import SwiftUI

final class Router: ObservableObject {
    enum Route: Hashable, Identifiable {
        case info
        case composer

        var id: Self { self }
    }

    @Published var routes = [Route]()
    @Published var selectRoute: Route?
    @Published var selectedSound: SoundModel?

    private var isPhone: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }

    func navigate(to route: Route) {
        if isPhone {
            routes.append(route)
        } else {
            selectRoute = route
        }
    }

    func navigateBack() {
        if isPhone {
            routes.removeLast()
        } else {
            selectRoute = nil
        }
    }

    func popToRoot() {
        if isPhone {
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

        case .composer:
            ComposerView()
        }
    }
}
