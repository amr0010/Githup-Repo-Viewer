//
//  LoginView.swift
//  GitHubRepoViewerTask
//
//  Created by Amr Magdy on 30/12/2025.
//

import SwiftUI

struct LoginView: View {

    @EnvironmentObject var appState: AppState
    @StateObject private var viewModel = DIContainer.shared.makeAuthenticationViewModel()

    var body: some View {
        NavigationView {
            VStack(spacing: 32) {
                Spacer()

                VStack(spacing: 16) {
                    Image(systemName: "github")
                        .font(.system(size: 80))
                        .foregroundColor(.primary)

                    Text("GitHub Repository Viewer")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)

                    Text("Sign in with your GitHub account to view and manage your repositories")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }

                VStack(spacing: 16) {
                    Button(action: {
                        viewModel.login()
                    }) {
                        HStack {
                            if viewModel.isLoading {
                                ProgressView()
                                    .tint(.white)
                                    .scaleEffect(0.8)
                            } else {
                                Image(systemName: "github")
                                    .font(.title3)
                            }

                            Text("Sign in with GitHub")
                                .fontWeight(.medium)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.primary)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                    }
                    .disabled(viewModel.isLoading)

                    if let errorMessage = viewModel.errorMessage {
                        HStack {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .foregroundColor(.red)
                            Text(errorMessage)
                                .font(.caption)
                                .foregroundColor(.red)
                                .multilineTextAlignment(.leading)
                            Spacer()
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(.red.opacity(0.1))
                        )
                        .onTapGesture {
                            viewModel.clearError()
                        }
                    }
                }
                .padding(.horizontal, 32)

                Spacer()
            }
            .navigationTitle("Welcome")
            .navigationBarTitleDisplayMode(.large)
            .onAppear {
                viewModel.onLoginSuccess = { user in
                    appState.didLogin(user: user)
                }
            }
        }
    }
}
