//
//  Event.swift
//  Sporty
//
//  Created by marwa maky on 21/08/2024.
//


import Foundation
struct ApiResponse: Decodable {
    let success: Int
    let result: [Event]
}

struct Event: Decodable {
    let eventKey: Int
    let eventDate: String
    let eventTime: String
    let eventHomeTeam: String
    let eventAwayTeam: String
    let eventFinalResult: String
    let homeTeamKey: Int
    let awayTeamKey: Int
    let homeTeamLogo: String?
    let awayTeamLogo: String?


    enum CodingKeys: String, CodingKey {
        case eventKey = "event_key"
        case eventDate = "event_date"
        case eventTime = "event_time"
        case eventHomeTeam = "event_home_team"
        case eventAwayTeam = "event_away_team"
        case eventFinalResult = "event_final_result"
        case homeTeamKey = "home_team_key"
        case awayTeamKey = "away_team_key"
        case homeTeamLogo = "home_team_logo"
        case awayTeamLogo = "away_team_logo"
       
    }
    
}
