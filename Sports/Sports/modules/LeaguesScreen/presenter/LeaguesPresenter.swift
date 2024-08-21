//
//  LeaguesPresenter.swift
//  Sporty
//
//  Created by marwa maky on 21/08/2024.
//

import Foundation
class LeaguesPresenter{
    var leaguesView: LeaguesProtocol?
    var apiManager: APIManager?
    init(leaguesView: LeaguesProtocol? = nil, apiManager: APIManager? = nil) {
        self.leaguesView = leaguesView
        self.apiManager = apiManager
    }
   
}
