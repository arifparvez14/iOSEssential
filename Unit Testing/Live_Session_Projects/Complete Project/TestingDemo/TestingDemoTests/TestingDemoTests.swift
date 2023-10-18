//
//  TestingDemoTests.swift
//  TestingDemoTests
//
//  Created by BJIT on 22/8/23.
//

import XCTest
@testable import TestingDemo

final class TestingDemoTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoginValidator_whenShortInputGiven_shouldReturnFalse() {
        
        //Arrange
        let sut = LoginValidator()
        let firstName = "X"
        
        //Act
        let result = sut.isFirstNameValid(firstName: firstName)
        
        //Assert
        XCTAssertFalse(result, "It should be true but somehow failed")
    }
    
    func testLoginValidator_whenValidInputGiven_shouldReturnTrue() {
        
        //Arrange
        let sut = LoginValidator()
        let firstName = "John"
        
        //Act
        let result = sut.isFirstNameValid(firstName: firstName)
        
        //Assert
        XCTAssertTrue(result, "It should be false but somehow failed")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
