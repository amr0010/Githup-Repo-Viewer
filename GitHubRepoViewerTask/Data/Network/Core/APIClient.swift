//
//  APIClient.swift
//  GitHubRepoViewerTask
//
//  Created by Amr Magdy on 30/12/2025.
//


import Foundation

final class APIClient: APIClientProtocol {

    private let session: URLSession
    private let decoder: JSONDecoder

    init(session: URLSession = .shared, decoder: JSONDecoder = APIClient.configuredDecoder()) {
        self.session = session
        self.decoder = decoder
    }

    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        let request = try RequestBuilder.buildRequest(from: endpoint)
        return try await performRequest(request, as: T.self)
    }

    func request<T: Decodable, U: Encodable>(_ endpoint: Endpoint, body: U) async throws -> T {
        let request = try RequestBuilder.buildRequest(from: endpoint, body: body)
        return try await performRequest(request, as: T.self)
    }

    private func performRequest<T: Decodable>(_ request: URLRequest, as type: T.Type) async throws -> T {
        do {
            let (data, response) = try await session.data(for: request)

            guard let http = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }

            try validate(http)

            guard !data.isEmpty else { throw NetworkError.noData }

            do {
                return try decoder.decode(T.self, from: data)
            } catch {
                throw NetworkError.decodingError(error)
            }

        } catch let error as NetworkError {
            throw error
        } catch let urlError as URLError {
            switch urlError.code {
            case .notConnectedToInternet, .networkConnectionLost:
                throw NetworkError.networkUnavailable
            case .timedOut:
                throw NetworkError.timeout
            default:
                throw NetworkError.unknown(urlError)
            }
        } catch {
            throw NetworkError.unknown(error)
        }
    }

    private func validate(_ response: HTTPURLResponse) throws {
        switch response.statusCode {
        case 200...299:
            return
        case 401:
            throw NetworkError.unauthorized
        default:
            throw NetworkError.serverError(response.statusCode)
        }
    }

    private static func configuredDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        df.timeZone = TimeZone(abbreviation: "UTC")
        decoder.dateDecodingStrategy = .formatted(df)
        return decoder
    }
}
