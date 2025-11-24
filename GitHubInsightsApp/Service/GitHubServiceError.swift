//
//  DD.swift
//  GitHubInsightsApp
//
//  Created by GHR Vinay on 23/11/25.
//

import Foundation

enum GitHubServiceError: Error, Equatable {
    /// deliberate throws
    case invalidUrl
    case invalidStatusCode
    
    /// external throws
    case decoding(Error)
    case server(Error)
    
    static func == (lhs: GitHubServiceError, rhs: GitHubServiceError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidStatusCode, .invalidStatusCode),
            (.invalidUrl, .invalidUrl):
            return true
        case let (.decoding(l), .decoding(r)),
            let (.server(l), .server(r)):
            return (l as NSError) === (r as NSError)
        default:
            return false
        }
    }
}
