//
//  RepoListVM.swift
//  GitHubInsightsApp
//
//  Created by GHR Vinay on 22/11/25.
//

import Foundation

@Observable
class RepoListVM {
    private let service: GitHubServiceProtocol
    var repoList: [RepoDetail] = []
    
    init(service: GitHubServiceProtocol) {
        self.service = service
    }
    
    func loadRepos(lang: String) async {
        do {
            
            let _list = try await service.fetchTrendingRepostoriesByLanguage(lang: lang)
            repoList = Array(_list.prefix(5)) // return first 5
        } catch {
            print("Error loading repos", error)
        }
        
    }
}
