//
//  RequestBuilder.swift
//  GitHubRepoViewerTask
//
//  Created by Amr Magdy on 30/12/2025.
//


import Foundation

struct RequestBuilder {

    static func buildRequest(from endpoint: Endpoint) throws -> URLRequest {
        guard var components = URLComponents(string: endpoint.baseURL + endpoint.path) else {
            throw NetworkError.invalidURL
        }

        if let items = endpoint.queryItems, !items.isEmpty {
            components.queryItems = items
        }

        guard let url = components.url else {
            throw NetworkError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.timeoutInterval = APIConstants.Timeout.request

        endpoint.headers.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }

        if let token = endpoint.accessToken {
            request.setValue("Bearer \(token)", forHTTPHeaderField: APIConstants.Headers.authorization)
        }

        return request
    }

    static func buildRequest<T: Encodable>(from endpoint: Endpoint, body: T) throws -> URLRequest {
        var request = try buildRequest(from: endpoint)
        do {
            request.httpBody = try JSONEncoder().encode(body)
        } catch {
            throw NetworkError.encodingError(error)
        }
        return request
    }
}
