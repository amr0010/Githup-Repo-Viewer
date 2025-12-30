//
//  APIConstants.swift
//  GitHubRepoViewer
//
//  Created by Amr Magdy on 30/12/2025.
//

import Foundation

struct APIConstants {

    struct Timeout {
        static let request: TimeInterval = 30.0
        static let resource: TimeInterval = 60.0
    }

    struct RetryPolicy {
        static let maxRetries = 3
        static let retryDelay: TimeInterval = 1.0
    }

    struct Pagination {
        static let defaultPageSize = 30
        static let maxPageSize = 100
    }

    struct Search {
        static let debounceDelay: TimeInterval = 0.3
        static let minQueryLength = 1
        static let maxQueryLength = 100
    }

    struct Headers {
        static let contentType = "Content-Type"
        static let accept = "Accept"
        static let userAgent = "User-Agent"
        static let authorization = "Authorization"
    }

}
