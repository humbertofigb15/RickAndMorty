//
//  RickandMortyApp.swift
//  RickandMorty
//
//  Created by Humberto Figueroa on 25/08/25.
//

import SwiftUI

@main
struct RickandMortyApp: App {
    @StateObject private var networkMonitor = NetworkMonitor()

    var body: some Scene {
        WindowGroup {
            RootTabView()
                .environmentObject(networkMonitor)
        }
    }
}

#Preview {
    RootTabView()
        .environmentObject(NetworkMonitor())
}
