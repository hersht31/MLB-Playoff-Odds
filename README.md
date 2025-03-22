# MLB Playoff Odds App

## Overview
The **MLB Playoff Odds** app provides real-time updates on Major League Baseball (MLB) playoff probabilities, live scores, and standings. Users can track their favorite teams, view spring training standings (Grapefruit and Cactus Leagues), and access dynamically fetched playoff odds without needing to refresh the app manually.

## Features
- **Live Playoff Odds:** Displays up-to-date playoff probabilities for all MLB teams.
- **Real-Time Scores:** Fetches live game scores and updates automatically.
- **Spring Training Standings:** Currently organizes standings based on Grapefruit and Cactus Leagues.
- **Team Logos:** Displays team logos alongside names.
- **Dynamic Data Fetching:** Uses Swift's `@StateObject` and `@State` to update UI when new data is received.

## Installation
### Prerequisites
- macOS with Xcode installed
- Swift 5.0+
- iOS Simulator or a physical device running iOS 16+

### Setup Instructions
1. Clone the repository:
   ```sh
   git clone https://github.com/your-repo/mlb-playoff-odds.git
   cd mlb-playoff-odds
   ```
2. Open the project in Xcode:
   ```sh
   open MLBPlayoffOdds.xcodeproj
   ```
3. Run the app on an iOS simulator or a connected device.

## Project Structure
- **ContentView.swift:** Main entry point with a `TabView` for navigation.
- **LiveScoresView.swift:** Displays live game scores.
- **StandingsView.swift:** Fetches and organizes standings based on Grapefruit and Cactus Leagues.
- **PlayoffOddsView.swift:** Displays dynamically fetched playoff probabilities for each team.
- **Models/**
  - `Team.swift`: Defines `Team` struct including team name, wins/losses, and spring training league.
  - `TeamStanding.swift`: Defines `TeamStanding` struct for standings.
- **Networking/**
  - `DataFetcher.swift`: Handles API requests and JSON parsing.

## Code Examples
### Fetching Standings
```swift
func fetchMLBStandings(completion: @escaping ([Team]) -> Void) {
    guard let url = URL(string: "https://example.com/api/mlb/standings") else { return }
    URLSession.shared.dataTask(with: url) { data, _, error in
        if let data = data {
            do {
                let standings = try JSONDecoder().decode([Team].self, from: data)
                completion(standings)
            } catch {
                print("Decoding error: \(error)")
            }
        }
    }.resume()
}
```

### Displaying Standings
```swift
var grapefruitTeams: [Team] {
    standings.filter { $0.springLeague == "Grapefruit" }
}

var cactusTeams: [Team] {
    standings.filter { $0.springLeague == "Cactus" }
}
```

## Troubleshooting
### Common Issues
1. **Error: Missing argument for parameter 'teams' in call**
   - Ensure that `StandingsView()` receives the correct parameter: `StandingsView(teams: fetchedTeams)`
2. **Live scores not updating**
   - Check API response format and verify `fetchLiveScores()` function.

## Future Enhancements
- Add team homepage with upcoming schedule and game calendar.
- Improve UI with animations and interactive charts.
- LLM chatbot integration for up-to-date baseball news and stats.

For any issues, contact Hersh Thakkar at hershthakkar31@gmail.com.

