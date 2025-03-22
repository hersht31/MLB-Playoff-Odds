//import SwiftUI
//import SwiftSoup
//
//struct PlayoffOddsView: View {
//    @State private var playoffOdds: [String: String] = [:]
//    @State private var errorMessage: String = ""
//    
//    var body: some View {
//        VStack {
//            if playoffOdds.isEmpty {
//                Text("Fetching Playoff Odds...")
//            } else {
//                List(playoffOdds.sorted(by: { $0.key < $1.key }), id: \.key) { team, odds in
//                    HStack {
//                        Text("Team: \(team)")
//                        Spacer()
//                        Text("Playoff Odds: \(odds)")
//                    }
//                }
//            }
//        }
//        .onAppear {
//            fetchPlayoffOdds { oddsData in
//                if oddsData.isEmpty {
//                    errorMessage = "Failed to fetch playoff odds."
//                    print(errorMessage)
//                    print(oddsData)
//                } else {
//                    playoffOdds = oddsData
//                    print(playoffOdds)
//                }
//            }
//        }
//    }
//
//    func fetchPlayoffOdds(completion: @escaping ([String: String]) -> Void) {
//        guard let url = URL(string: "https://www.fangraphs.com/standings/playoff-odds") else {
//            print("Invalid URL")
//            return
//        }
//        
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if let error = error {
//                print("Failed to fetch data: \(error.localizedDescription)")
//                return
//            }
//            
//            guard let data = data, let html = String(data: data, encoding: .utf8) else {
//                print("Failed to decode data")
//                return
//            }
//            
//            do {
//                let document = try SwiftSoup.parse(html)
//                let oddsTable = try document.select("table#standings")  // Update with the correct selector for the table
//
//                var playoffOdds: [String: String] = [:]
//                
//                // Adjust row parsing to match the Fangraphs table structure.
//                let rows = try oddsTable.select("tr").dropFirst()  // Drop the header row
//                for row in rows {
//                    let team = try row.select("td.team-column-selector").text()  // Adjust based on the correct selector
//                    let odds = try row.select("td.playoff-odds-column-selector").text()  // Adjust selector for odds
//                    
//                    playoffOdds[team] = odds
//                }
//                
//                completion(playoffOdds)
//                
//            } catch {
//                print("Failed to parse HTML: \(error.localizedDescription)")
//                completion([:])  // Return empty dictionary on failure
//            }
//        }.resume()
//    }
//}
import SwiftUI

struct PlayoffOddsView: View {
    let team: String
    let playoffOdds: String
    
    // Dictionary of team logos and background colors
    let teamLogos = [
        "Cubs": "Chicago-Cubs-Logo-removebg-preview",
        "Dodgers": "dodgers_logo",
        "Phillies": "phillies_logo",
        // Add other teams...
    ]
    
    let teamBackgroundColors: [String: Color] = [
        "Cubs": Color.blue,
        "Dodgers": Color.blue,
        "Phillies": Color.red,
        // Add other team background colors...
    ]
    
    var body: some View {
        VStack {
            if let logo = teamLogos[team], let backgroundColor = teamBackgroundColors[team] {
                ZStack {
                    Color.init(uiColor: .cubsBlue)
                        .ignoresSafeArea(edges: .top)
                        .colorScheme(.light)
                    VStack {
                        Spacer()
                        Text("\(team) Playoff Odds")
                            .font(.system(size: 40, weight: .bold, design: .default))
                            .foregroundColor(.white)
                            .offset(y: 25)
                        // Playoff Odds
                        Text(playoffOdds)
                            .font(.system(size: 55, weight: .bold, design: .default))
                            .foregroundColor(.white)
                            .offset(y: 40)
                        // Team Logo
                        Image(logo)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 400, height: 400, alignment: .center)
                            .offset(y: -40)
                        Spacer()
                    }
                }
            } else {
                Text("Team logo or color not available.")
            }
        }
    }
}

struct PlayoffOddsView_Previews: PreviewProvider {
    static var previews: some View {
        PlayoffOddsView(team: "Cubs", playoffOdds: "0%")
    }
}
