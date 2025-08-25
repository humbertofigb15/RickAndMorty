//
//  CharacterListViewModel.swift
//  RickandMorty
//
//  Created by Humberto Figueroa on 25/08/25.
//

import Foundation

@MainActor
final class CharacterListViewModel: ObservableObject {
    enum State: Equatable {
        case idle, loading
        case loaded([RMCharacter], hasMore: Bool)
        case error(String)
    }

    @Published private(set) var state: State = .idle

    private let api = RMAPI()
    private var page = 1
    private var canLoadMore = true
    private var items: [RMCharacter] = []

    func refresh() async {
        page = 1
        canLoadMore = true
        items = []
        await load(reset: true)
    }

    func loadMoreIfNeeded(currentItem: RMCharacter?) async {
        guard case .loaded = state, canLoadMore, let currentItem else { return }
        let thresholdIndex = items.index(items.endIndex, offsetBy: -5)
        if items.firstIndex(where: { $0.id == currentItem.id }) == thresholdIndex {
            await load(reset: false)
        }
    }

    private func load(reset: Bool) async {
        if reset { state = .loading }
        do {
            let pageData = try await api.fetchCharacters(page: page)
            if reset { items = [] }
            items += pageData.results
            canLoadMore = (pageData.info.next != nil)
            page += 1
            state = .loaded(items, hasMore: canLoadMore)
        } catch let apiError as APIError {
            state = .error(apiError.localizedDescription)
        } catch {
            state = .error(error.localizedDescription)
        }
    }
}

