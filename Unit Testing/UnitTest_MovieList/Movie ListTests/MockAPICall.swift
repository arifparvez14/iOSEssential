//
//  MockAPICall.swift
//  Movie ListTests
//
//  Created by Muhammad Ariful islam on 18/10/23.
//

import XCTest
@testable import Movie_List

final class MockAPICall: XCTestCase {
    
    var sut: ClientServiceProtocol!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = MockClientService()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }

    func testMockMovieApiCall() throws {
        
        try XCTSkipUnless(NetworkMonitor.shared.isReachable, "Network connectivity needed for this test.")
        
        //given
        let promise = expectation(description: "MovieInfo fetch successfully")
        
        //when
        sut.searchMovie(query: nil) { result in

            //then
            switch result {
            case .success(let movieInfo):
                if movieInfo.results.count > 0 {
                    XCTAssertEqual(movieInfo.results.count, 3, "Object count didn't same")
                    promise.fulfill()
                }
            case .failure(let error):
                XCTAssertNil(error, "\(error.localizedDescription)")
                promise.fulfill()
            }
        }
        
        wait(for: [promise], timeout: 5)
    }
}
