//
//  TDD_practiceTests.swift
//  TDD_practiceTests
//
//  Created by Faiaz Rahman on 15/8/23.
//

import XCTest
@testable import TDD_practice

final class TDD_practiceTests: XCTestCase {
    
    var sut: SignupValidatorClass!
    override func setUpWithError() throws {
         sut = SignupValidatorClass()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        sut = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSignupFormValidator_whenValidNameProvided_shouldReturnTrue() {
        
        // Arrange
        let firstName = "John"

        
        //Act
        let result = sut.firstNameValidator(firstName : firstName)
        
        //Assert
        XCTAssertTrue(result, "somehow its failed")
        
    }
    
    func testSignupFormValidator_whenInvalidNameProvided_shouldReturnFalse() {
        
        // Arrange
        let firstName = "JohnDOEloooog"
        
        //Act
        let result = sut.firstNameValidator(firstName : firstName)
        
        //Assert
        XCTAssertFalse(result, "somehow its failed")
        
    }


}
