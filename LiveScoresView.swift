import SwiftUI

struct LiveScoresView: View {
    @StateObject private var scoreFetcher = ScoreFetcher()
    @Environment(\.colorScheme) var colorScheme

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        NavigationView {
            VStack {
                if scoreFetcher.isLoading {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                }
                
                else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(scoreFetcher.games) { game in
                                GameCardView(game: game)
                            }
                        }
                        .padding()
                        .background(colorScheme == .dark ? Color.black : Color.white)
                        .edgesIgnoringSafeArea(.all)
                    }
                    .refreshable {
                        scoreFetcher.fetchScores()
                    }
                }
            }
            .navigationTitle("Scores")
            .onAppear {
                scoreFetcher.fetchScores()
            }
        }
    }
}
