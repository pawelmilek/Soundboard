//
//  PathError.swift
//  StonogaSoundboard
//
//  Created by Pawel Milek on 10/30/23.
//

import Foundation

public enum PathError: Error {
    case notFound
    case containerNotFound(identifier: String)
}

// MARK: - LocalizedError protocol
extension PathError: LocalizedError {

    public var errorDescription: String? {
        switch self {
        case .notFound:
            return "Resource not found"

        case .containerNotFound(let identifier):
            return "Shared container for group \(identifier) not found"
        }
    }

}
