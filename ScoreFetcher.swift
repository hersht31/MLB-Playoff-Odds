import Foundation
import Combine

class ScoreFetcher: ObservableObject {
    @Published var games: [Game] = []
    @Published var isLoading = false
    private var timer: Timer?

    init() {
        fetchScores()
        startTimer()
    }

    func fetchScores() {
        isLoading = true
        let urlString = "https://statsapi.mlb.com/api/v1/schedule?sportId=1"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            isLoading = false
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
            }
            
            if let error = error {
                print("Error fetching games: \(error)")
                return
            }
            
            guard let data = data else {
                print("Invalid data")
                return
            }
            
            do {
                let gamesResponse = try JSONDecoder().decode(GamesResponse.self, from: data)
                let games = gamesResponse.dates.first?.games ?? []
                DispatchQueue.main.async {
                    self.games = games
                }
            } catch {
                print("Decoding error: \(error)")
            }
        }.resume()
    }

    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 45.0, repeats: true) { _ in
            self.fetchScores()
        }
    }

    deinit {
        stopTimer()
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}
