//  Team.swift
//  Sporty
//
//  Created by marwa maky on 21/08/2024.
//



import Foundation

struct TeamResponse: Decodable {
    let success: Int
    let result: [Team]
}

struct Team: Hashable, Decodable {
    let teamKey: Int
    let teamName: String
    let teamLogo: String
    let players: [Player]
    let coaches: [Coach]

    enum CodingKeys: String, CodingKey {
        case teamKey = "team_key"
        case teamName = "team_name"
        case teamLogo = "team_logo"
        case players = "players"
        case coaches = "coaches"
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(teamKey)
    }
    
    static func ==(lhs: Team, rhs: Team) -> Bool {
        return lhs.teamKey == rhs.teamKey
    }
}

struct Player: Decodable {
    let playerName: String
    let playerImage: String?

    enum CodingKeys: String, CodingKey {
        case playerName = "player_name"
        case playerImage = "player_image"
    }
}

struct Coach: Decodable {
    let coachName: String

    enum CodingKeys: String, CodingKey {
        case coachName = "coach_name"
    }
}
