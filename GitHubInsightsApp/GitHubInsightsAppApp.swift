//
//  GitHubInsightsAppApp.swift
//  GitHubInsightsApp
//
//  Created by GHR Vinay on 22/11/25.
//

import SwiftUI

@main
struct GitHubInsightsAppApp: App {
    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
        WindowGroup {
            NavigationStack {
                RepoListView(vm: RepoListVM(service: GitHubService()))
            }
        }
    }
}
