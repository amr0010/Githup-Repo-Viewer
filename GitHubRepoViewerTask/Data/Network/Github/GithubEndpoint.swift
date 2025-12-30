//
//  Endpoint.swift
//  GitHubRepoViewerTask
//
//  Created by Amr Magdy on 30/12/2025.
//


import Foundation

enum Endpoint {
    case user(accessToken: String)
    case repositories(accessToken: String, page: Int, perPage: Int)
    case branches(accessToken: String, owner: String, repo: String, page: Int, perPage: Int)

    var baseURL: String { "https://api.github.com" }

    var path: String {
        switch self {
        case .user:
            return "/user"
        case .repositories:
            return "/user/repos"
        case .branches(_, let owner, let repo, _, _):
            return "/repos/\(owner)/\(repo)/branches"
        }
    }

    var method: HTTPMethod { .get }

    var queryItems: [URLQueryItem]? {
        switch self {
        case .user:
            return nil
        case .repositories(_, let page, let perPage):
            return [
                .init(name: "sort", value: "updated"),
                .init(name: "page", value: "\(page)"),
                .init(name: "per_page", value: "\(perPage)")
            ]
        case .branches(_, _, _, let page, let perPage):
            return [
                .init(name: "page", value: "\(page)"),
                .init(name: "per_page", value: "\(perPage)")
            ]
        }
    }

    var headers: [String: String] {
        [
            APIConstants.Headers.accept: "application/vnd.github+json",
            APIConstants.Headers.contentType: "application/json"
        ]
    }

    var accessToken: String? {
        switch self {
        case .user(let token),
             .repositories(let token, _, _),
             .branches(let token, _, _, _, _):
            return token
        }
    }
}
