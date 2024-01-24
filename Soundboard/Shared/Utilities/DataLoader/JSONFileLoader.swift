//
//  JSONFileLoader.swift
//  Soundboard
//
//  Created by Pawel Milek on 1/24/24.
//  Copyright © 2024 Pawel Milek. All rights reserved.
//


import Foundation

enum JSONFileLoader {

    static func loadFile(with name: String) throws -> Data {
        guard let path = Bundle.main.path(forResource: name, ofType: "json") else {
            throw FileLoaderError.fileNotFound(name: name)
        }

        do {
            let pathURL = URL(fileURLWithPath: path)
            let data = try Data(contentsOf: pathURL)
            return data

        } catch {
            throw FileLoaderError.fileNotFound(name: name)
        }
    }

}
