//
//  OAuthManager.swift
//  GitHubRepoViewerTask
//
//  Created by Amr Magdy on 30/12/2025.
//
import Foundation
import AuthenticationServices

protocol OAuthManaging {
    @MainActor func authenticate(using provider: OAuthProvider) async throws -> String
}

final class OAuthManager: NSObject, OAuthManaging {

    private var session: ASWebAuthenticationSession?
    private let urlSession: URLSession

    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
        super.init()
    }

    @MainActor
    func authenticate(using provider: OAuthProvider) async throws -> String {
        try await withCheckedThrowingContinuation { continuation in
            session = ASWebAuthenticationSession(
                url: provider.authorizationURL,
                callbackURLScheme: provider.callbackURLScheme
            ) { [weak self] callbackURL, error in
                self?.handleAuthResponse(
                    provider: provider,
                    callbackURL: callbackURL,
                    error: error,
                    continuation: continuation
                )
            }

            session?.presentationContextProvider = self
            session?.prefersEphemeralWebBrowserSession = true
            session?.start()
        }
    }

    private func handleAuthResponse(
        provider: OAuthProvider,
        callbackURL: URL?,
        error: Error?,
        continuation: CheckedContinuation<String, Error>
    ) {
        if let error = error {
            if (error as? ASWebAuthenticationSessionError)?.code == .canceledLogin {
                continuation.resume(throwing: AuthError.authCancelled)
            } else {
                continuation.resume(throwing: AuthError.networkError(error))
            }
            return
        }

        guard let callbackURL,
              let code = provider.extractAuthorizationCode(from: callbackURL),
              !code.isEmpty
        else {
            continuation.resume(throwing: AuthError.invalidCallback)
            return
        }

        Task {
            do {
                let token = try await exchangeCodeForToken(code: code, provider: provider)
                continuation.resume(returning: token)
            } catch {
                continuation.resume(throwing: error)
            }
        }
    }

    private func exchangeCodeForToken(code: String, provider: OAuthProvider) async throws -> String {
        var request = URLRequest(url: provider.tokenURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = provider.tokenExchangeBody(authorizationCode: code)

        do {
            let (data, response) = try await urlSession.data(for: request)
            return try provider.extractAccessToken(from: data, response: response)
        } catch let authError as AuthError {
            throw authError
        } catch {
            throw AuthError.networkError(error)
        }
    }
}

extension OAuthManager: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        ASPresentationAnchor()
    }
}
