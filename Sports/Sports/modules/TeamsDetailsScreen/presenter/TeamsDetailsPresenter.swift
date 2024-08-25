//
//  TeamsDetailsPresenter.swift
//  Sporty
//
//  Created by marwa maky on 23/08/2024.
//
import Foundation

class TeamsDetailsPresenter {
    weak var view: TeamDetailsViewProtocol?
    var teamKey: Int?
    var apiManager: APIManager?
    var team: Team?

    init(teamKey: Int?) {
        self.teamKey = teamKey
    }
    func fetchTeamDetails() {
        guard let teamKey = teamKey else {
            print("Team key is missing.")
            return
        }
        
        let parameters: [String: Any] = [
            "met": "Teams",
            "teamId": teamKey,
            "APIkey": apiManager?.apiKey ?? ""
        ]
        
        apiManager?.request("football", parameters: parameters) { [weak self] (result: Result<TeamResponse, Error>) in
            switch result {
            case .success(let response):
                if response.success == 1, let teamResponse = response.result.first {
                    let players = teamResponse.players.map { Player(playerName: $0.playerName, playerImage: $0.playerImage) }
                    let coaches = teamResponse.coaches.map { Coach(coachName: $0.coachName) }
                    self?.team = Team(
                        teamKey: teamResponse.teamKey,
                        teamName: teamResponse.teamName,
                        teamLogo: teamResponse.teamLogo,
                        players: players,
                        coaches: coaches
                    )
                    
                    self?.view?.updateTeamDetails()
                } else {
                    print("No team data found in the response.")
                }
            case .failure(let error):
                print("Failed to fetch team details: \(error)")
            }
        }
    }

}
