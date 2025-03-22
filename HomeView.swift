//import SwiftUI
//
//struct HomeView: View {
//    @StateObject private var scoreFetcher = ScoreFetcher()
//    @AppStorage("favoriteTeam") private var favoriteTeam: String = "None"
//    
//    var body: some View {
//        NavigationView {
//            VStack {
//                if favoriteTeam == "None" {
//                    Text("No Favorite Team Selected")
//                        .font(.largeTitle)
//                        .fontWeight(.bold)
//                        .padding()
//                } else {
//                    FavoriteTeamGameView(favoriteTeam: favoriteTeam, games: scoreFetcher.games)
//                }
//            }
//            .navigationTitle("Home")
//        }
//        .onAppear {
//            scoreFetcher.fetchScores()
//        }
//    }
//}
//
//struct FavoriteTeamGameView: View {
//    let favoriteTeam: String
//    let games: [Game]
//    
//    var favoriteGame: Game? {
//        games.first { $0.teams.away.name == favoriteTeam || $0.teams.home.name == favoriteTeam }
//    }
//    
//    var body: some View {
//        if let game = favoriteGame {
//            VStack {
//                Text("Live Score")
//                    .font(.headline)
//                GameCardView(game: game)
//            }
//        } else {
//            Text("No Current Game for \(favoriteTeam)")
//                .font(.largeTitle)
//                .fontWeight(.bold)
//                .padding()
//        }
//    }
//}
