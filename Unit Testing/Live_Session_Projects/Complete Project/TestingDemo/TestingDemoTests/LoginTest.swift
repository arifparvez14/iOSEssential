//
//  LoginTest.swift
//  TestingDemoTests
//
//  Created by BJIT on 22/8/23.
//

import XCTest
@testable import TestingDemo

final class LoginTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSignupWebService_WhenGivenSuccessfullResponse_ReturnsSuccess() {
        
        // Arrange
        let sut = SignupWebService(urlString: Constants.signupURLString)
        let signFormRequestModel = SignupFormRequestModel(firstName: "John", lastName: "Doe", email: "test@test.com", password: "12345678")
        
        let expectation = self.expectation(description: "Signup Web Service Response Expectation")
        
        // Act
        sut.signup(withForm: signFormRequestModel) { (signupResponseModel, error) in
            XCTAssertEqual(signupResponseModel?.status, "ok")
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 5)
    }


}
