import Foundation
import Alamofire

class APIManager {
    static let shared = APIManager()
    private let baseURL = "https://apiv2.allsportsapi.com/"
    private let apiKey = "35a407c26b3b2a396025776d4cf0618f2475499b9faf30bd6b226eb779d3a5fc"
    
    private init() {}
    
    // Fetch leagues for a specific sport
    func fetchLeagues(for sport: String, completion: @escaping (ResultEnum<LeaguesModel, Error>) -> Void) {
        let urlString = "\(baseURL)\(sport)/?met=Leagues&APIkey=\(apiKey)"
        performRequest(urlString: urlString, completion: completion)
    }
    
    // Fetch upcoming events for a specific league
    func fetchUpcomingEvents(leagueId: Int, fromDate: String, toDate: String, completion: @escaping (ResultEnum<[Event], Error>) -> Void) {
        let urlString = "\(baseURL)football?met=Fixtures&leagueId=\(leagueId)&from=\(fromDate)&to=\(toDate)&APIkey=\(apiKey)"
        performRequest(urlString: urlString, completion: completion)
    }
    
    // Fetch latest results for a specific league
    func fetchLatestResults(leagueId: Int, fromDate: String, toDate: String, completion: @escaping (ResultEnum<[Event], Error>) -> Void) {
        let urlString = "\(baseURL)football?met=Fixtures&leagueId=\(leagueId)&from=\(fromDate)&to=\(toDate)&APIkey=\(apiKey)"
        performRequest(urlString: urlString, completion: completion)
    }
    
    // Fetch team details
    func fetchTeamDetails(teamId: Int, completion: @escaping (ResultEnum<LeaguesModel, Error>) -> Void) {
        let urlString = "\(baseURL)football?met=Teams&teamId=\(teamId)&APIkey=\(apiKey)"
        performRequest(urlString: urlString, completion: completion)
    }

    private func performRequest<T: Codable>(urlString: String, completion: @escaping (ResultEnum<T, Error>) -> Void) {
        AF.request(urlString).responseData { response in
            switch response.result {
            case .success(let data):
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Raw JSON Response: \(jsonString)")
                }
                do {
                    let decodedObject = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedObject))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}
