
//
//  LeaguesPresenter.swift
//  Sporty
//
//  Created by marwa maky on 21/08/2024.
//


import Foundation
class LeaguesPresenter {
    var leaguesView: LeaguesProtocol?
    var apiManager: APIManager?

    var leagues: [LeaguesResult] = []  
    
    init(leaguesView: LeaguesProtocol? = nil, apiManager: APIManager? = APIManager.shared) {
        self.leaguesView = leaguesView
        self.apiManager = apiManager
    }
    
    func fetchLeagues(for sport: String) {
        let endpoint = "\(sport)/?met=Leagues&APIkey=\(apiManager?.apiKey ?? "")"
        apiManager?.request(endpoint, parameters: nil) { [weak self] (result: Result<LeaguesModel, Error>) in
            switch result {
            case .success(let leaguesResponse):
                self?.leagues = leaguesResponse.result
                self?.leaguesView?.updateTable()
            case .failure(let error):
                print("Error fetching leagues: \(error)")
            }
        }
    }
}
