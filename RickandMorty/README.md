Rick and Morty SwiftUI App
📱 What the app does

This iOS app is built with SwiftUI and connects to the Rick and Morty API.

It allows users to:
- Browse a list of characters (with name, image, species, and status).
- Tap on a character to view a detail screen with extended information (gender, origin, location, episodes).
- Handle offline mode with a friendly banner.
- Show loading states for both content and images.
- Recover gracefully from API errors with retry options.
- The app is implemented using the MVVM pattern, with clean separation of Models, ViewModels, Networking, and Views.

🌐 API Endpoint
The app uses the Rick and Morty API:
https://rickandmortyapi.com/api/character

Example:
https://rickandmortyapi.com/api/character?page=1 → List of characters.
https://rickandmortyapi.com/api/character/1 → Detail for Rick Sanchez.

🛠 How to run the app
Requirements
Xcode 15 or newer
iOS 17 or newer (deployment target can be set to iOS 16 if needed)
Internet connection to fetch API data

Steps
- Clone this repository:
- git clone https://github.com/humbertofigb15/RickAndMorty.git
- Open the project in Xcode:
- open RickAndMorty.xcodeproj
- Select a simulator (e.g., iPhone 15 Pro).
- Build & Run (⌘R).
- The app will launch and display the list of Rick and Morty characters.
