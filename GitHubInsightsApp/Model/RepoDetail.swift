//
//  RepoDetail.swift
//  GitHubInsightsApp
//
//  Created by GHR Vinay on 22/11/25.
//

struct RepoDetail: Decodable, Hashable {
    var name: String
    var owner: String
    var stars: Int
    
    enum CodingKeys: String, CodingKey {
        case name
        case owner
        case stargazers_count
    }
    
    enum OwnerKeys: String, CodingKey {
        case login
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? "--"
        self.stars = try container.decodeIfPresent(Int.self, forKey: .stargazers_count) ?? 0
        
        let ownerContainer = try container.nestedContainer(keyedBy: OwnerKeys.self, forKey: .owner)
        self.owner = try ownerContainer.decodeIfPresent(String.self, forKey: .login) ?? "--"
    }
}
