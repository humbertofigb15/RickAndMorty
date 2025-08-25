//
//  PageResponse.swift
//  RickandMorty
//
//  Created by Humberto Figueroa on 25/08/25.
//

import Foundation

struct PagedResponse<T: Codable>: Codable {
    let info: Info
    let results: [T]

    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
}
