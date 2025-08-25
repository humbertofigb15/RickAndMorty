//
//  CharacterDetaillView.swift
//  RickandMorty
//
//  Created by Humberto Figueroa on 25/08/25.
//

import SwiftUI

struct CharacterDetailView: View {
    @ObservedObject var viewModel: CharacterDetailViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                AsyncImage(url: URL(string: viewModel.character.image)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView().frame(height: 280)
                    case .success(let image):
                        image.resizable().scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .shadow(radius: 4)
                    case .failure:
                        Image(systemName: "photo")
                            .font(.system(size: 60))
                            .frame(maxWidth: .infinity, minHeight: 200)
                            .padding()
                            .background(.thinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                    @unknown default:
                        EmptyView()
                    }
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text(viewModel.character.name)
                        .font(.largeTitle).bold()
                    Text("\(viewModel.character.species) • \(viewModel.character.status)")
                        .foregroundStyle(.secondary)

                    Divider()

                    DetailRow(title: "Gender", value: viewModel.character.gender)
                    DetailRow(title: "Origin", value: viewModel.character.origin.name)
                    DetailRow(title: "Location", value: viewModel.character.location.name)
                    DetailRow(title: "Episodes", value: "\(viewModel.character.episode.count)")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            }
            .padding()
        }
        .navigationTitle("Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct DetailRow: View {
    let title: String
    let value: String
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title).font(.caption).foregroundStyle(.secondary)
            Text(value).font(.body)
        }
    }
}
