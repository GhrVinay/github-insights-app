//
//  GitHubService.swift
//  GitHubInsightsApp
//
//  Created by GHR Vinay on 22/11/25.
//

import Foundation

protocol URLSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}

protocol GitHubServiceProtocol {
    func fetchTrendingRepostoriesByLanguage(lang: String) async throws -> [RepoDetail]
}


class GitHubService: GitHubServiceProtocol {
    let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func fetchTrendingRepostoriesByLanguage(lang: String) async throws -> [RepoDetail] {
        var components = URLComponents(string: "https://api.github.com/search/repositories")
        components?.queryItems = [
            URLQueryItem(name: "q", value: "language:\(lang)"),
            URLQueryItem(name: "sort", value: "stars")
        ]
        
        guard let url = components?.url else { throw GitHubServiceError.invalidUrl }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            let (data, response) = try await session.data(for: request)
            if let _resp = response as? HTTPURLResponse, !(200...299).contains(_resp.statusCode) {
                throw GitHubServiceError.invalidStatusCode
            }
            
            let resp = try JSONDecoder().decode(RepositoriesResponse.self, from: data)
            return resp.repoList
            
        } catch let err as GitHubServiceError {
            throw err
        } catch let err as DecodingError {
            throw GitHubServiceError.decoding(err)
        } catch {
            throw GitHubServiceError.server(error)
        }
        
    }
    
}
