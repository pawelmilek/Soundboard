//
//  CustomConfigurationAccessor.swift
//  Soundboard
//
//  Created by Pawel Milek on 1/25/24.
//  Copyright © 2024 Pawel Milek. All rights reserved.
//

import Foundation

enum CustomConfigurationAccessor {
    enum Key: String {
        case appID = "AppID"
        case appURL = "AppURL"
        case appPrivacyPolicyURL = "AppPrivacyPolicyURL"
        case supportEmail = "SupportEmail"
    }

    private static let configurationKey = "CustomConfiguration"

    static func value(for key: Key) throws -> String {
        guard let config = Bundle.main.object(forInfoDictionaryKey: configurationKey) as? [String: String] else {
            throw CocoaError(.keyValueValidation)
        }

        if let value = config[key.rawValue] {
            return value
        } else {
            throw CocoaError(.keyValueValidation)
        }
    }
}
