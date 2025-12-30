//
//  UserAvatar.swift
//  GitHubRepoViewerTask
//
//  Created by Amr Magdy on 30/12/2025.
//

import SwiftUI

struct UserAvatar: View {

    let urlString: String?

    var body: some View {
        AsyncImage(url: URL(string: urlString ?? "")) { image in
            image.resizable().scaledToFill()
        } placeholder: {
            Image(systemName: "person.circle.fill")
                .foregroundColor(.secondary)
        }
        .frame(width: 32, height: 32)
        .clipShape(Circle())
        .accessibilityLabel("Account")
    }
}
