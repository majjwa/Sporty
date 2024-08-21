//
//  LeaguesModel.swift
//  Sporty
//
//  Created by marwa maky on 21/08/2024.
//

import Foundation
struct LeaguesModel: Codable {
    let success: Int
    let result: [LeaguesResult]
         }

struct LeaguesResult: Codable {
    let leagueKey: Int
    let leagueName: String
    let leagueLogo: String?

    enum CodingKeys: String, CodingKey {
        case leagueKey = "league_key"
        case leagueName = "league_name"
        case leagueLogo = "league_logo"
      
    }
}
