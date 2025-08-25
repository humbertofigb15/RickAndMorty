//
//  CharacterDetailViewModel.swift
//  RickandMorty
//
//  Created by Humberto Figueroa on 25/08/25.
//

import Foundation

@MainActor
final class CharacterDetailViewModel: ObservableObject {
    @Published private(set) var character: RMCharacter
    init(character: RMCharacter) { self.character = character }
}
