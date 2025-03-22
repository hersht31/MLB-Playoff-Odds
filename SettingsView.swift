import SwiftUI

struct SettingsView: View {
    @AppStorage("favoriteTeam") private var favoriteTeam = "None"
    @AppStorage("isDarkMode") private var isDarkMode = false

    let teams = ["Select Team", "Arizona Diamondbacks", "Atlanta Braves", "Baltimore Orioles", "Boston Red Sox", "Chicago Cubs", "Chicago White Sox", "Cincinatti Reds", "Cleveland Guardians", "Colorado Rockies", "Detroit Tigers", "Houston Astros", "Kansas City Royals", "Los Angeles Angels", "Los Angeles Dodgers", "Miami Marlins", "Milwaukee Brewers", "Minnesota Twins", "New York Mets", "New York Yankees", "Oakland Athletics", "Philadelphia Phillies", "Pittsburgh Pirates", "San Diego Padres", "San Francisco Giants", "Seattle Mariners", "St. Louis Cardinals", "Tampa Bay Rays", "Texas Rangers", "Toronto Blue Jays", "Washington Nationals"]

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Favorite Team")) {
                    Picker("Select your favorite team", selection: $favoriteTeam) {
                        ForEach(teams, id: \.self) { team in
                            Text(team)
                        }
                    }
                }
                
                Section(header: Text("Appearance")) {
                    Toggle(isOn: $isDarkMode) {
                        Text("Dark Mode")
                    }
                }
            }
            .navigationTitle("Settings")
        }
        .onChange(of: isDarkMode) { value in
            if value {
                UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .dark
            } else {
                UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .light
            }
        }
    }
}
