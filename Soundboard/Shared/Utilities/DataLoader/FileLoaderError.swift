//
//  FileLoaderError.swift
//  Soundboard
//
//  Created by Pawel Milek on 1/24/24.
//

import Foundation

enum FileLoaderError: Error {
  case fileNotFound(name: String)
  case incorrectFormat
  case unsupportedError
}

// MARK: - Error description
extension FileLoaderError {

  var errorDescription: String? {
    switch self {
    case .fileNotFound:
      return "File Not Found"

    case .incorrectFormat:
      return "Error reading unrecognized format"

    case .unsupportedError:
      return "Unsupported Error"
    }
  }

}
