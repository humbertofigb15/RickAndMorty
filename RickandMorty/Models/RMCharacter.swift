//
//  RMCharacter.swift
//  RickandMorty
//
//  Created by Humberto Figueroa on 25/08/25.
//

import Foundation

struct RMCharacter: Identifiable, Codable, Hashable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: SimpleRef
    let location: SimpleRef
    let image: String
    let episode: [String]
    let url: String
    let created: String

    // Keep equality/hash cheap and stable
    static func == (lhs: RMCharacter, rhs: RMCharacter) -> Bool { lhs.id == rhs.id }
    func hash(into hasher: inout Hasher) { hasher.combine(id) }

    struct SimpleRef: Codable, Hashable {
        let name: String
        let url: String
    }
}

