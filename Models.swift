import Foundation

struct GamesResponse: Codable {
    let dates: [DateInfo]
}

//struct DateInfo: Codable {
//    let date: String
//    let games: [Game]
//}

//struct Game: Codable, Identifiable {
//    let id: Int
//    let gameDate: String
//    let status: Status
//    let teams: Teams
//    let linescore: LineScore?
//
//    enum CodingKeys: String, CodingKey {
//        case id = "gamePk"
//        case gameDate
//        case status
//        case teams
//        case linescore
//    }
//}
//
//struct Status: Codable {
//    let detailedState: String
//}

//struct Teams: Codable {
//    let away: Team
//    let home: Team
//}
//
//struct Team: Codable {
//    let team: TeamInfo
//    let score: Int?
//}

//struct TeamInfo: Codable {
//    let id: Int
//    let name: String
//    let abbreviation: String
//}
//struct TeamRecord: Identifiable, Codable {
//    let team: Team
//    let name: String
//    let wins: Int
//    let losses: Int
//    
//    var pct: Double {
//        let totalGames = Double(wins + losses)
//        return totalGames == 0 ? 0 : Double(wins) / totalGames
//    }
//    
//    var id: String { team.id }
//    
//    enum CodingKeys: String, CodingKey {
//        case team
//        case name
//        case wins
//        case losses
//    }
//}

struct TeamRecord: Codable, Identifiable {
    let id: String
    let team: Team
    let wins: Int
    let losses: Int
    let pct: Double
}

struct MLBStandingsResponse: Codable {
    let records: [DivisionRecords]
}

struct DivisionRecords: Codable, Identifiable {
    let id: String
    let divisionName: String
    let records: [TeamRecord]
}

struct LineScore: Codable {
    let currentInning: Int?
    let inningState: String?
    let outs: Int?
    let offense: Offense?
}

struct Offense: Codable {
    let runners: [Runner]?
}

struct Runner: Codable {
    let movement: Movement
}

struct Movement: Codable {
    let start: String?
    let end: String?
}

struct ScheduleResponse: Codable {
    let dates: [DateInfo]
    let games: [Game]
}

struct DateInfo: Codable {
    let date: String
    let games: [Game]
}

struct Game: Identifiable, Codable {
    let id: Int
    let status: Status
    let teams: Teams
    let gameDate: String
    let linescore: LineScore?
    
    enum CodingKeys: String, CodingKey {
        case id = "gamePk"
        case status
        case teams
        case gameDate
        case linescore
    }
}

struct Status: Codable {
    let detailedState: String
}

struct Teams: Codable {
    let away: TeamInfo
    let home: TeamInfo
}

struct TeamInfo: Codable {
    let team: Team
    let score: Int?
    let record: Record?
    let probablePitcher: Pitcher?

    enum CodingKeys: String, CodingKey {
        case team
        case score = "score"
        case record
        case probablePitcher
    }
}

struct Team: Codable {
    let name: String
    
    var logoUrl: String? {
        TeamLogos.logos[name]
    }
//    
//
//    let id = UUID()
//    let wins: Int
//    let losses: Int
//    let springLeague: String
}

struct Record: Codable {
    let wins: Int
    let losses: Int
}

struct Pitcher: Codable {
    let fullName: String
    let wins: Int
    let losses: Int
    let era: Double
}
