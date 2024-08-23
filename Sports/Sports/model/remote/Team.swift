//
//  Team.swift
//  Sporty
//
//  Created by marwa maky on 23/08/2024.
//

import Foundation


struct Team: Hashable {
    let teamKey: String
    let teamName: String
    let teamLogo: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(teamKey)
    }
    
    static func ==(lhs: Team, rhs: Team) -> Bool {
        return lhs.teamKey == rhs.teamKey
    }
}
