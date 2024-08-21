import Foundation
import Alamofire

class APIManager {
    static let shared = APIManager()
    
    // Constants
    private let baseURL = "https://apiv2.allsportsapi.com/"
    private let apiKey = "35a407c26b3b2a396025776d4cf0618f2475499b9faf30bd6b226eb779d3a5fc"
    
    private init() {}
    
    func request<T: Decodable>(_ endpoint: String, parameters: [String: Any]?, completion: @escaping (Result<T, Error>) -> Void) {
        let urlString = "\(baseURL)\(endpoint)"
        AF.request(urlString, parameters: parameters).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decodedObject: T = try DecoderFunc.decode(data: data)
                    completion(.success(decodedObject))
                    print("Decoded Object: \(decodedObject)")
                } catch {
                    completion(.failure(error))
                    NotificationCenter.default.post(name: NSNotification.Name("DataFetchError"), object: nil)
                    print("Decoding Error: \(error)")
                }
            case .failure(let error):
                completion(.failure(error))
                NotificationCenter.default.post(name: NSNotification.Name("DataFetchError"), object: nil)
                print("Request Error: \(error)")
            }
        }
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func fetchLeagues(for sport: String, completion: @escaping (Result<LeaguesModel, Error>) -> Void) {
        let endpoint = "\(sport)/?met=Leagues&APIkey=\(apiKey)"
        request(endpoint, parameters: nil) { (result: Result<LeaguesModel, Error>) in
            completion(result)
        }
    }
    func fetchUpcomingEvents(leagueId: Int, fromDate: String, toDate: String, completion: @escaping (Result<[Event], Error>) -> Void) {
        let endpoint = "football?met=Fixtures&leagueId=\(leagueId)&from=\(fromDate)&to=\(toDate)&APIkey=\(apiKey)"
        request(endpoint, parameters: nil) { (result: Result<ApiResponse, Error>) in
            switch result {
            case .success(let apiResponse):
                completion(.success(apiResponse.result))
            case .failure(let error):
                completion(.failure(error))
                print("Error fetching upcoming events: \(error)")
            }
        }
    }

    func fetchLatestResults(leagueId: Int, fromDate: String, toDate: String, completion: @escaping (Result<[Event], Error>) -> Void) {
        let endpoint = "football?met=Fixtures&leagueId=\(leagueId)&from=\(fromDate)&to=\(toDate)&APIkey=\(apiKey)"
        request(endpoint, parameters: nil) { (result: Result<ApiResponse, Error>) in
            switch result {
            case .success(let eventsResponse):
                completion(.success(eventsResponse.result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchTeamDetails(teamId: Int, completion: @escaping (Result<ApiResponse, Error>) -> Void) {
        let endpoint = "football?met=Teams&teamId=\(teamId)&APIkey=\(apiKey)"
        request(endpoint, parameters: nil) { (result: Result<ApiResponse, Error>) in
            completion(result)
        }
    }

    
    
    
}
