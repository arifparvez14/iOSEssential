//
//  PerformanceTest.swift
//  Movie ListTests
//
//  Created by Muhammad Ariful islam on 18/10/23.
//

import XCTest
@testable import Movie_List

final class PerformanceTest: XCTestCase {

    var sut: ClientService!
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = ClientService()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }


    func testPerformanceExample() throws {
        self.measure {
            sut.searchMovie(query: nil) { result in
                switch result {
                case .success(let t):
                    print(t.results.count)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }

}
