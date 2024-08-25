//
//  LatestEvent.swift
//  SportsTests
//
//  Created by marwa maky on 25/08/2024.
//


import XCTest
@testable import Sporty

final class LatestEventTests: XCTestCase {

    var apiManager: APIManager!

    override func setUpWithError() throws {
        super.setUp()
        apiManager = APIManager.shared
    }

    override func tearDownWithError() throws {
        apiManager = nil
        super.tearDown()
    }

    func testFetchLeagues() {
        let expectation = self.expectation(description: "Fetching leagues from API")
        let endpoint = "football/?met=Fixtures&leagueId=205&from=2023-01-18&to=2024-01-18&APIkey=\(apiManager.apiKey)"

        apiManager.request(endpoint, parameters: nil) { (result: Result<LeaguesModel, Error>) in
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
