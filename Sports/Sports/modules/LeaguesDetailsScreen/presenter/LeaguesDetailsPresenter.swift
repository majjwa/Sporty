import Foundation

class LeaguesDetailsPresenter {
    var view: LeaguesDetailsProtocol?
    var apiManager: APIManager?
    var dateHelper: DateHelper
    var upComingEvents: [Event] = []
    var latestEvents: [Event] = []
    var teams: [Team] = []
    var selectedLeague: LeaguesResult?

    init(view: LeaguesDetailsProtocol? = nil, apiManager: APIManager? = nil, dateHelper: DateHelper = DateHelper()) {
        self.view = view
        self.apiManager = apiManager
        self.dateHelper = dateHelper
    }

    func fetchUpComing(leagueId: Int) {
        let fromDate = dateHelper.getCurrentDate()
        let toDate = dateHelper.getOneYearFromNowDate()

        let parameters: [String: Any] = [
            "met": "Fixtures",
            "leagueId": leagueId,
            "from": fromDate,
            "to": toDate,
            "APIkey": apiManager?.apiKey ?? ""
        ]

        apiManager?.request("football", parameters: parameters) { (result: Result<ApiResponse, Error>) in
            switch result {
            case .success(let response):
                self.upComingEvents = response.result
                self.processTeamData(from: response.result)
                self.view?.updateCollectionView()
            case .failure(let error):
                print("Failed to fetch upcoming events: \(error)")
            }
        }
    }

    func fetchLatest(leagueId: Int) {
        let fromDate = dateHelper.getOneYearAgoDate()
        let toDate = dateHelper.getCurrentDate()

        let parameters: [String: Any] = [
            "met": "Fixtures",
            "leagueId": leagueId,
            "from": fromDate,
            "to": toDate,
            "APIkey": apiManager?.apiKey ?? ""
        ]

        apiManager?.request("football", parameters: parameters) { (result: Result<ApiResponse, Error>) in
            switch result {
            case .success(let response):
                self.latestEvents = response.result
                self.processTeamData(from: response.result)
                self.view?.updateCollectionView()
            case .failure(let error):
                print("Failed to fetch latest events: \(error)")
            }
        }
    }

    
        
        private func processTeamData(from events: [Event]) {
            // Resolve duplicates
            var teamSet = Set<Team>()
            for event in events {
                let homeTeamKey = event.homeTeamKey
                let awayTeamKey = event.awayTeamKey
                let homeTeamName = event.eventHomeTeam
                let awayTeamName = event.eventAwayTeam
                let homeTeamLogo = event.homeTeamLogo ?? ""
                let awayTeamLogo = event.awayTeamLogo ?? ""
                
                let homeTeam = Team(teamKey: homeTeamKey, teamName: homeTeamName, teamLogo: homeTeamLogo, players: [], coaches: [])
                let awayTeam = Team(teamKey: awayTeamKey, teamName: awayTeamName, teamLogo: awayTeamLogo, players: [], coaches: [])
                
                teamSet.insert(homeTeam)
                teamSet.insert(awayTeam)
            }
            
            teams = Array(teamSet)
        }

       

}
