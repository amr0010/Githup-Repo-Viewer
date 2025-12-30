//
//  APIClientProtocol.swift
//  GitHubRepoViewerTask
//
//  Created by Amr Magdy on 30/12/2025.
//


import Foundation

protocol APIClientProtocol {
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T
    func request<T: Decodable, U: Encodable>(_ endpoint: Endpoint, body: U) async throws -> T
}
