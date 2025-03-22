import SwiftUI

struct StandingsView: View {
    @State private var standings: [TeamStanding] = []
    
    var body: some View {
        List(standings, id: \.teamName) { team in
            HStack {
                Text(team.teamName).bold()
                Spacer()
                Text("W: \(team.wins) - L: \(team.losses)")
            }
        }
        .onAppear {
            fetchMLBStandings { fetchedStandings in
                DispatchQueue.main.async {
                    standings = fetchedStandings
                }
            }
        }
    }
}
