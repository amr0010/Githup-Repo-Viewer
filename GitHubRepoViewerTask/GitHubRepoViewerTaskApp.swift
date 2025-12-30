//
//  GitHubRepoViewerTaskApp.swift
//  GitHubRepoViewerTask
//
//  Created by Amr Magdy on 30/12/2025.
//

import SwiftUI

@main
struct GitHubRepoViewerTaskApp: App {

    @MainActor
    @StateObject private var appState = DIContainer.shared.makeAppState()


    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
        }
    }
}
