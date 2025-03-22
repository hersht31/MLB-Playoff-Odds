//
//  ContentView.swift
//  MLB Playoff Odds
//
//  Created by Hersh Thakkar on 5/26/24.
//

import SwiftUI

struct ContentView: View {
    @State var selectedTab = 0
    @StateObject private var scoreFetcher = ScoreFetcher()
    
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Text("Home")
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(0)
            LiveScoresView()
                .tabItem {
                    Image(systemName: "baseball.diamond.bases")
                    Text("Scores")
                }
                .tag(1)
            StandingsView()
                .tabItem {
                    Image(systemName: "flag.fill")
                    Text("Standings")
                }
                .tag(2)
            PlayoffOddsView(team: "Cubs", playoffOdds: "0%")
                .tabItem {
                    Image(systemName: "plus.forwardslash.minus")
                    Text("Playoff Odds")
                }
                .tag(3)
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
                .tag(3)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
