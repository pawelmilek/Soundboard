//
//  JSONParser.swift
//  Soundboard
//
//  Created by Pawel Milek on 1/24/24.
//  Copyright © 2024 Pawel Milek. All rights reserved.
//

import Foundation

struct JSONParser<M> where M: Decodable {

    static func parse(_ data: Data) -> M {
        do {
            let decodedData = try JSONDecoder().decode(M.self, from: data)
            return decodedData

        } catch {
            fatalError(error.localizedDescription)
        }
    }

}
