//
//  RepositoriesResponse.swift
//  GitHubInsightsApp
//
//  Created by GHR Vinay on 22/11/25.
//

struct RepositoriesResponse: Decodable {
    var repoList: [RepoDetail]
    
    enum CodingKeys: String, CodingKey {
        case items
    }
    
    init(from decoder: any Decoder) throws {
        self.repoList = try decoder.container(keyedBy: CodingKeys.self).decodeIfPresent([RepoDetail].self, forKey: .items) ?? []
    }
}
