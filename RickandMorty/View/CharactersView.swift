//
//  Character View.swift
//  RickandMorty
//
//  Created by Humberto Figueroa on 25/08/25.
//

import SwiftUI

struct CharactersView: View {
    @EnvironmentObject private var networkMonitor: NetworkMonitor
    @StateObject private var vm = CharacterListViewModel()

    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Rick & Morty")
                .toolbarTitleDisplayMode(.large)
        }
        .overlay(alignment: .top) {
            if networkMonitor.isOffline {
                Banner(text: "No connection. Showing limited data.", systemImage: "wifi.slash")
            }
        }
        .task { await vm.refresh() }
        .refreshable { await vm.refresh() }
    }

    @ViewBuilder
    private var content: some View {
        switch vm.state {
        case .idle, .loading:
            ProgressView("Loading…")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        case .error(let message):
            ErrorView(message: message) { Task { await vm.refresh() } }
        case .loaded(let items, let hasMore):
            List {
                ForEach(items) { character in
                    NavigationLink(value: character) {
                        CharacterRowView(character: character)
                    }
                    .onAppear { Task { await vm.loadMoreIfNeeded(currentItem: character) } }
                }
                if hasMore {
                    HStack { Spacer(); ProgressView(); Spacer() }
                }
            }
            .navigationDestination(for: RMCharacter.self) { character in
                CharacterDetailView(viewModel: CharacterDetailViewModel(character: character))
            }
            .listStyle(.plain)
        }
    }
}

// MARK: - Helpers
private struct Banner: View {
    let text: String
    let systemImage: String
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: systemImage)
            Text(text).font(.footnote)
        }
        .padding(10)
        .frame(maxWidth: .infinity)
        .background(.ultraThickMaterial)
        .overlay(Rectangle().frame(height: 0.5).foregroundStyle(.separator), alignment: .bottom)
    }
}

private struct ErrorView: View {
    let message: String
    let retry: () -> Void
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "exclamationmark.triangle").font(.largeTitle)
            Text(message).multilineTextAlignment(.center)
            Button("Retry", action: retry).buttonStyle(.borderedProminent)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
