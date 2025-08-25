//
//  CharacterRowView.swift
//  RickandMorty
//
//  Created by Humberto Figueroa on 25/08/25.
//

import SwiftUI

struct CharacterRowView: View {
    let character: RMCharacter

    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: URL(string: character.image)) { phase in
                switch phase {
                case .empty:
                    ProgressView().frame(width: 60, height: 60)
                case .success(let image):
                    image.resizable().scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                case .failure:
                    Image(systemName: "photo")
                        .frame(width: 60, height: 60)
                        .background(.thinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                @unknown default:
                    EmptyView()
                }
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(character.name).font(.headline)
                Text("\(character.species) • \(character.status)")
                    .font(.subheadline).foregroundStyle(.secondary)
            }
            Spacer()
        }
        .padding(.vertical, 6)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(character.name), \(character.species), \(character.status)")
    }
}
