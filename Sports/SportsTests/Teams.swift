//
//  Teams.swift
//  SportsTests
//
//  Created by marwa maky on 25/08/2024.
//

import XCTest
@testable import Sporty

final class TeamsTests: XCTestCase {

    var apiManager: APIManager!

    override func setUpWithError() throws {
        super.setUp()
        apiManager = APIManager.shared
    }

    override func tearDownWithError() throws {
        apiManager = nil
        super.tearDown()
    }

    func testFetchTeams() {
        let expectation = self.expectation(description: "Fetching teams from API")
        let endpoint = "football/?met=Teams&leagueId=205&APIkey=\(apiManager.apiKey)"

        apiManager.request(endpoint, parameters: nil) { (result: Result<TeamResponse, Error>) in
            switch result {
            case .success(let response):
                print("Response: \(response)")
                XCTAssertFalse(response.result.isEmpty, "Result should not be empty")
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                XCTFail("Request failed with error: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 20, handler: nil)
    }
}
