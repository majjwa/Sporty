import Foundation
class LeaguesDetailsPresenter {
    var view: LeaguesDetailsProtocol?
    var apiManager: APIManager?
    var coreDataManager: CoreDataManager
    var dateHelper: DateHelper
    var upComingEvents: [Event] = []
    var latestEvents: [Event] = []
    var teams: [Team] = []
    var selectedLeague: LeaguesResult?

    init(view: LeaguesDetailsProtocol? = nil, apiManager: APIManager? = nil, coreDataManager: CoreDataManager, dateHelper: DateHelper = DateHelper()) {
        self.view = view
        self.apiManager = apiManager
        self.coreDataManager = coreDataManager
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
        var teamSet = Set<Team>()
        for event in events {
            let homeTeam = Team(teamKey: event.homeTeamKey, teamName: event.eventHomeTeam, teamLogo: event.homeTeamLogo ?? "", players: [], coaches: [])
            let awayTeam = Team(teamKey: event.awayTeamKey, teamName: event.eventAwayTeam, teamLogo: event.awayTeamLogo ?? "", players: [], coaches: [])
            
            teamSet.insert(homeTeam)
            teamSet.insert(awayTeam)
        }

        teams = Array(teamSet)
    }

    func isLeagueFavorite(_ league: LeaguesResult) -> Bool {
        return coreDataManager.isLeagueFavorite(leagueKey: league.leagueKey)
    }

    func fetchFavoriteState() {
        guard let league = selectedLeague else {
            print("No selected league to check for favorites")
            return
        }
        
        let isFavorite = coreDataManager.isLeagueFavorite(leagueKey: league.leagueKey)
        view?.updateFavoriteStatus(isFavorite: isFavorite)
    }

    func saveFavorite(_ league: LeaguesResult) {
        coreDataManager.saveFavorite(league: league)
        fetchFavoriteState()
    }

    func deleteFavorite(_ league: LeaguesResult) {
        coreDataManager.deleteFavorite(leagueKey: league.leagueKey)
        fetchFavoriteState()
    }
}
