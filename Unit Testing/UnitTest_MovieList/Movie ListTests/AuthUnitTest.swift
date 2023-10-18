//
//  AuthUnitTest.swift
//  Movie ListTests
//
//  Created by Muhammad Ariful islam on 18/10/23.
//

import XCTest
@testable import Movie_List

final class AuthUnitTest: XCTestCase {

    var sut: AuthViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = AuthViewModel(authValidator: AuthValidator())
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }

    func testUserNameValidator() {
        //given
        let name = "Ariful"
        
        //when
        let result = sut.authValidator.nameValid(name: name)
        
        //then
        XCTAssertTrue(result, AuthError.nameValidationError.rawValue)
        
    }
    
    func testEmailValidator() {
        //given
        let email = "a@a.com"
        
        //when
        let result = sut.authValidator.isValidEmailFormat(email: email)
        
        //then
        XCTAssertTrue(result, AuthError.emailValidationError.rawValue)
    }
    
    func testPasswordValidator() {
        //given
        let password = "123675"
        
        //when
        let result = sut.authValidator.isPasswordValid(password: password)
        
        //then
        XCTAssertTrue(result, AuthError.passwordValidationError.rawValue)
    }
    
    func testMatchPasswordvalidator() {
        //given
        let password = "123456"
        let confirmPassword = "123456"
        
        //when
        let result = sut.authValidator.doPasswordsMatch(password: password, repeatPassword: confirmPassword)
        
        //then
        XCTAssertTrue(result, AuthError.matchPasswordValidationError.rawValue)
    }
}
