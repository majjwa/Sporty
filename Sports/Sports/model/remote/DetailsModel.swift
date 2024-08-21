import Foundation

struct Event: Codable {
    let eventKey: Int
    let eventDate: String
    let eventTime: String
    let leagueId: Int?
    let homeTeamKey: Int
    let awayTeamKey: Int
    let eventHomeTeam: String
    let eventAwayTeam: String
    let homeTeamLogo: String?
    let awayTeamLogo: String?

    enum CodingKeys: String, CodingKey {
        case eventKey = "event_key"
        case eventDate = "event_date"
        case eventTime = "event_time"
        case leagueId = "league_id"
        case homeTeamKey = "home_team_key"
        case awayTeamKey = "away_team_key"
        case eventHomeTeam = "event_home_team"
        case eventAwayTeam = "event_away_team"
        case homeTeamLogo = "home_team_logo"
        case awayTeamLogo = "away_team_logo"
    }
}
