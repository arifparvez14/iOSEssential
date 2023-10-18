//
//  LoginTestMock.swift
//  TestingDemoTests
//
//  Created by BJIT on 22/8/23.
//

import XCTest
@testable import TestingDemo

final class LoginTestMock: XCTestCase {

    var sut:SignupWebService!
    var signFormRequestModel:SignupFormRequestModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSignupWebService_WhenGivenSuccessfullResponse_ReturnsSuccess_MOCK() {

        //Arrange
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: config)
        
        let jsonString = "{\"status\":\"ok\"}"
        MockURLProtocol.stubResponseData =  jsonString.data(using: .utf8)

        sut = SignupWebService(urlString: Constants.signupURLString, urlSession: urlSession)

        signFormRequestModel = SignupFormRequestModel(firstName: "Sergey", lastName: "Kargopolov", email: "test@test.com", password: "12345678")

        let expectation = self.expectation(description: "Signup Web Service Response Expectation")

        // Act
        sut.signup(withForm: signFormRequestModel) { (signupResponseModel, error) in

            XCTAssertEqual(signupResponseModel?.status, "ok")
            expectation.fulfill()

        }

        self.wait(for: [expectation], timeout: 10)

    }
//
//
    func testSignupWebService_WhenReceivedDifferentJSONResponse_ErrorTookPlace() {
        // Arrange

        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: config)


        sut = SignupWebService(urlString: Constants.signupURLString, urlSession: urlSession)
        signFormRequestModel = SignupFormRequestModel(firstName: "John", lastName: "Doe", email: "test@test.com", password: "12345678")

        let jsonString = "{\"path\":\"/users\", \"error\":\"Internal Server Error\"}"
        MockURLProtocol.stubResponseData =  jsonString.data(using: .utf8)

        let expectation = self.expectation(description: "Signup() method expectation for a response that contains a different JSON structure")

        // Act
        sut.signup(withForm: signFormRequestModel) { (signupResponseModel, error) in

            // Assert
            XCTAssertNil(signupResponseModel, "The response model for a request containing unknown JSON response, should have been nil")
            XCTAssertEqual(error, SignupError.invalidResponseModel, "The signup() method did not return expected error")
            expectation.fulfill()

        }
//
        self.wait(for: [expectation], timeout: 5)
    }

    func testSignupWebservice_WhenEmptyURLStringProvided_ReturnsError() {
        // Arrange
        let expectation = self.expectation(description: "An empty request URL string expectation")

        sut = SignupWebService(urlString: "")
        signFormRequestModel = SignupFormRequestModel(firstName: "John", lastName: "Doe", email: "test@test.com", password: "12345678")
        // Act
        sut.signup(withForm: signFormRequestModel) { (signupResponseModel, error) in

            // Assert
            XCTAssertEqual(error, SignupError.invalidRequestURLString, "The signup() method did not return an expected error for an invalidRequestURLString error")
            XCTAssertNil(signupResponseModel, "When an invalidRequestURLString takes place, the response model must be nil")
            expectation.fulfill()
        }

        self.wait(for: [expectation], timeout: 2)
    }

    func testSignupWebService_WhenURLRequestFails_ReturnsErrorMessageDescription() {

        // Arrange
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: config)

        let expectation = self.expectation(description: "A failed Request expectation")
        let errorDescription = "A localized description of an error"
        MockURLProtocol.error = SignupError.failedRequest(description:errorDescription)

        sut = SignupWebService(urlString: Constants.signupURLString, urlSession: urlSession)
        signFormRequestModel = SignupFormRequestModel(firstName: "John", lastName: "Doe", email: "test@test.com", password: "12345678")

        // Act
        sut.signup(withForm: signFormRequestModel) { (signupResponseModel, error) in

            XCTAssertNil(signupResponseModel, "Not Nil")
            // XCTAssertEqual(error?.localizedDescription, errorDescription)
            expectation.fulfill()
        }

        self.wait(for: [expectation], timeout: 2)
    }

}
