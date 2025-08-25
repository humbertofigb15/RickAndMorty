//
//  CharacterListViewModal.swift
//  RickandMorty
//
//  Created by Humberto Figueroa on 25/08/25.
//

import SwiftUI

struct RootTabView: View {
    var body: some View {
        TabView {
            CharactersView()
                .tabItem { Label("Characters", systemImage: "list.bullet") }
        }
    }
}

#Preview {
    RootTabView().environmentObject(NetworkMonitor())
}
