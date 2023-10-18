//
//  NetowrkTest.swift
//  Movie ListTests
//
//  Created by Muhammad Ariful islam on 18/10/23.
//

import XCTest
@testable import Movie_List

final class NetworkTestUnitTest: XCTestCase {
    var sut: URLSession!
    let networkMonitor = NetworkMonitor.shared

    override func setUpWithError() throws {
      try super.setUpWithError()
      sut = URLSession(configuration: .default)
    }

    override func tearDownWithError() throws {
      sut = nil
      try super.tearDownWithError()
    }
    
    func testValidApiCallGetsHTTPStatusCode200() throws {
      
      //precondition
      try XCTSkipUnless( networkMonitor.isReachable, "Network connectivity needed for this test.")

      
      //given
      let urlString = "https://dogapi.dog/api/v2/breeds"
      let url = URL(string: urlString)!
      let promise = expectation(description: "Status code: 200")
      
      //when
      let dataTask = sut.dataTask(with: url) { _, response, error in
        
        //then
        if let error = error {
          XCTFail("Error: \(error.localizedDescription)")
          return
        } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
          if statusCode == 200 {
            promise.fulfill()
          } else {
            XCTFail("Status code: \(statusCode)")
          }
        }
      }
      
      dataTask.resume()
      wait(for: [promise], timeout: 5)
    }
    
    func testApiCallCompletes() throws {
        
        // given
        let urlString =  "https://dogapi.dog/api/v2/breeds"
        let url = URL(string: urlString)!
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        
        // when
        let dataTask = sut.dataTask(with: url) { _, response, error in
            
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
        }
        dataTask.resume()
        wait(for: [promise], timeout: 10)
        
        // then
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
}
