//
//  ApiManager.swift
//  Sporty
//
//  Created by marwa maky on 21/08/2024.
//


import Foundation
import Alamofire

public class APIManager {
    public static let shared = APIManager()

    // Constants
    let baseURL = "https://apiv2.allsportsapi.com/"
    let apiKey = "35a407c26b3b2a396025776d4cf0618f2475499b9faf30bd6b226eb779d3a5fc"

    private init() {}

    public func request<T: Decodable>(_ endpoint: String, parameters: [String: Any]?, completion: @escaping (Result<T, Error>) -> Void) {
        let urlString = "\(baseURL)\(endpoint)"
        AF.request(urlString, parameters: parameters).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decodedObject: T = try JSONDecoder().decode(T.self, from: data)
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
