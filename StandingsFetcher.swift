import Foundation

struct TeamStanding: Codable {
    let teamName: String
    let wins: Int
    let losses: Int
}

func fetchMLBStandings(completion: @escaping ([TeamStanding]) -> Void) {
    let urlString = "https://statsapi.mlb.com/api/v1/standings?leagueId=103,104&season=2024&standingsTypes=springTraining"
    
    guard let url = URL(string: urlString) else {
        print("Invalid API URL")
        completion([])
        return
    }
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        guard let data = data, error == nil else {
            print("Failed to fetch standings: \(error?.localizedDescription ?? "Unknown error")")
            completion([])
            return
        }
        
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            guard let records = json?["records"] as? [[String: Any]] else {
                print("No records found in API response")
                completion([])
                return
            }
            
            var standings: [TeamStanding] = []
            
            for record in records {
                if let teams = record["teamRecords"] as? [[String: Any]] {
                    for team in teams {
                        if let teamInfo = team["team"] as? [String: Any],
                           let teamName = teamInfo["name"] as? String,
                           let wins = team["wins"] as? Int,
                           let losses = team["losses"] as? Int {
                            
                            standings.append(TeamStanding(teamName: teamName, wins: wins, losses: losses))
                        }
                    }
                }
            }
            
            completion(standings)
        } catch {
            print("JSON Parsing Error: \(error)")
            completion([])
        }
    }
    task.resume()
}
