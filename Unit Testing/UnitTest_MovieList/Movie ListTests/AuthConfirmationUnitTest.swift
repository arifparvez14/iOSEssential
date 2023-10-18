//
//  AuthConfirmationUnitTest.swift
//  Movie ListTests
//
//  Created by Muhammad Ariful islam on 18/10/23.
//

import XCTest
@testable import Movie_List

final class AuthConfirmationUnitTest: XCTestCase {

    var sut: AuthViewModel!
    var errorMessage: String!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = AuthViewModel(authValidator: AuthValidator())
        sut.viewDelegate = self
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    
    //Test via callback
    func testValidationError() {

        //given
        let credentials = AuthCredentials(
            name: nil,
            email: "a@a.com",
            password: "123456",
            confirmPassword: "123456")
        
        //when
        sut.submit(authCredentials: credentials) {(error) in
            
            //then
           XCTAssertEqual(error, AuthError.nameValidationError.rawValue, "Validation error")
        }
    }
    
    // Test via delegation
    func testNameValidationErrorShowingASExpected() {
        //given
        let credentials = AuthCredentials(
            name: nil,
            email: "a@a.com",
            password: "123456",
            confirmPassword: "123456")
        
        self.errorMessage = AuthError.nameValidationError.rawValue
        
        //when
        sut.submit(authCredentials: credentials)
    }
    
    func testEmailValidationErrorShowingASExpected() {
        //given
        let credentials = AuthCredentials(
            name: "ABCDSE",
            email: nil,
            password: "123456",
            confirmPassword: "123456")
        
        self.errorMessage = AuthError.emailValidationError.rawValue
        
        //when
        sut.submit(authCredentials: credentials)
    }
    
    func testPasswordValidationErrorShowingASExpected() {
        //given
        let credentials = AuthCredentials(
            name: "ABCDSE",
            email: "a@a.com",
            password: nil,
            confirmPassword: "123456")
        
        self.errorMessage = AuthError.passwordValidationError.rawValue
        
        //when
        sut.submit(authCredentials: credentials)
    }
    
    func testMatchPasswordValidationErrorShowingASExpected() {
        //given
        let credentials = AuthCredentials(
            name: "ABCDSE",
            email: "a@a.com",
            password: "123456",
            confirmPassword: nil)
        self.errorMessage = AuthError.matchPasswordValidationError.rawValue
        
        //when
        sut.submit(authCredentials: credentials)
    }
}

extension AuthConfirmationUnitTest: AuthViewDelegate {
    func validationError(errorMessage: String) {
        //then
        XCTAssertTrue(errorMessage == self.errorMessage, "Validation Error")
    }
}
