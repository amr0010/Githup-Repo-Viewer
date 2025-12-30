# GitHub Repo Viewer (iOS)

## Demo

📹 **Demo GIF**
![ScreenRecording2025-12-30at6 39 38PM-ezgif com-video-to-gif-converter](https://github.com/user-attachments/assets/b69e6822-872b-4129-a46f-61246bfaad0f)

---

## Overview
An iOS app that authenticates with GitHub and displays the user’s repositories and branches.

The project follows **Clean Architecture** principles with a clear separation between:
- Presentation (SwiftUI + ViewModels)
- Domain (Use Cases + Entities)
- Data (Repositories, OAuth, API clients)

OAuth authentication is abstracted through a generic `OAuthManager` with provider-based configuration.

---

## Setup
To run the app, you need to provide your own GitHub OAuth credentials.

1. Create a GitHub OAuth App  
   GitHub → Settings → Developer Settings → OAuth Apps → New OAuth App

2. Set the callback URL to: githubrepoviewer://oauth-callback


3. In the project:
- go to `GitHubConfig.plist`
- Fill in:
  - `CLIENT_ID`
  - `CLIENT_SECRET`

4. Build and run the app.

---

## Trade-offs
- **OAuth client secret is stored locally** for this demo.  
In a production app, the token exchange should be handled by a backend service to avoid shipping secrets in the client.
- **Limited automated testing** due to time constraints.  

---

## Future Work
- Increase test coverage (repositories, pagination, error cases).
- Further modularization (separate features into frameworks).
- Improve offline handling and caching.

---


