import SwiftUI

struct GameCardView: View {
    let game: Game
    @AppStorage("favoriteTeam") private var favoriteTeam = "None"
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            HStack {
                teamInfoView(team: game.teams.away)
                Spacer()
                if let awayScore = game.teams.away.score {
                    Text("\(awayScore)")
                        .font(.headline)
                        .padding(.trailing, 8)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                }
//                if game.teams.away.team.name == favoriteTeam {
//                    Image(systemName: "star.fill")
//                        .foregroundColor(.yellow)
//                        .controlSize(.small)
//                }
            }
            
            HStack {
                teamInfoView(team: game.teams.home)
                Spacer()
                if let homeScore = game.teams.home.score {
                    Text("\(homeScore)")
                        .font(.headline)
                        .padding(.trailing, 8)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                }
//                if game.teams.home.team.name == favoriteTeam {
//                    Image(systemName: "star.fill")
//                        .foregroundColor(.yellow)
//                        .controlSize(.small)
//                }
            }
            if let linescore = game.linescore {
                HStack {
                    Text("Inning: \(linescore.currentInning ?? 0)")
                    Spacer()
                    Text("\(linescore.inningState ?? "")")
                }
                HStack {
                    Text("Outs: \(linescore.outs ?? 0)")
                    Spacer()
                    Text("Runners: \(linescore.offense?.runners?.count ?? 0)")
                }
            }
            if game.status.detailedState == "Game Over" || game.status.detailedState == "Final" {
                Text("Final")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.red)
            }
            else if game.status.detailedState == "In Progress" {
                Text("Live")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.green)
            }
            else if game.status.detailedState == "Pre-Game"{
                Text("Pregame")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.teal)
            }
            else if game.status.detailedState == "Warmup"{
                Text(game.status.detailedState)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.yellow)
            }
            else if game.status.detailedState == "Delayed Start"{
                Text("Delayed")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.orange)
            }
            else {
                Text(formatStartTime(dateString: game.gameDate))
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
            }
        }
        .padding()
        .background(colorScheme == .dark ? Color.gray : Color.white)
        .cornerRadius(8)
//        .shadow(radius: 2)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
    }
}

private func teamInfoView(team: TeamInfo) -> some View {
    HStack {
        if let logoUrl = team.team.logoUrl {
            AsyncImage(url: logoUrl, placeholder: Image(systemName: "photo"))
                .frame(minWidth: 40, maxWidth: 40, minHeight: 40, maxHeight: 40)
                .clipShape(Circle())
        }
//        VStack(alignment: .leading) {
//            Text(team.team.name)
//                .font(.headline)
//                .lineLimit(1) // Ensure single line for team names
//            if let record = team.record {
//                Text("\(record.wins)-\(record.losses)")
//                    .font(.subheadline)
//                    .foregroundColor(.gray)
//                    .lineLimit(1) // Ensure single line for records
//            }
//        }
    }
}

func formatStartTime(dateString: String) -> String {
    let isoFormatter = ISO8601DateFormatter()
    isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "h:mm a"

    // Print the original gameDate string for debugging
    //print("Original gameDate string: \(dateString)")

    if let date = isoFormatter.date(from: dateString) {
        let formattedDate = dateFormatter.string(from: date)
        //print("Formatted gameDate string: \(formattedDate)")
        return formattedDate
    } else {
        // Try another format if the first one fails
        let alternativeFormatter = DateFormatter()
        alternativeFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = alternativeFormatter.date(from: dateString) {
            let formattedDate = dateFormatter.string(from: date)
            //print("Formatted gameDate string with alternative formatter: \(formattedDate)")
            return formattedDate
        } else {
            //print("Failed to parse date string: \(dateString)")
            return "TBD"
        }
    }
}
