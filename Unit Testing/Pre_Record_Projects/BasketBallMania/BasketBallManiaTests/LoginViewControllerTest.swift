//
//  LoginViewControllerTest.swift
//  BasicApp_UnitTestTests
//
//  Created by Faiaz Rahman on 15/8/23.
//

import XCTest
@testable import BasketBallMania

final class LoginViewControllerTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSignupViewController_WhenCreated_HasRequiredTextFieldsEmpty() throws {
        //Arrange
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyboard.instantiateViewController(identifier: "LoginVC") as LoginVC
        sut.loadViewIfNeeded()
        
        //Act
        let firstNameTextField = try XCTUnwrap(sut.namefield, "The firstNameTextField is not connected to an IBOutlet")
        let emailTextField = try XCTUnwrap(sut.emailField, "The emailTextField is not connected to an IBOutlet")
        let passwordTextField = try XCTUnwrap(sut.passwordField, "The passwordTextField is not connected to an IBOutlet")
        let repeatPasswordTextField = try XCTUnwrap(sut.password2Field, "The repeatPasswordTextField is not connected to an IBOutlet")
           
        //Assert
        XCTAssertEqual(firstNameTextField.text, "", "First name text field was not empty when the view controller initially loaded")
        XCTAssertEqual(emailTextField.text, "", "Email text field was not empty when the view controller initially loaded")
        XCTAssertEqual(passwordTextField.text, "","Password text field was not empty when the view controller initially loaded")
        XCTAssertEqual(repeatPasswordTextField.text, "","Repeat Password text field was not empty when the view controller initially loaded")
    }
    
    func testViewController_WhenCreated_HasSignupButtonAndAction() throws {
        // Arrange
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyboard.instantiateViewController(identifier: "LoginVC") as LoginVC
        sut.loadViewIfNeeded()
        let signupButton: UIButton = try XCTUnwrap(sut.signupBtn, "Signup button does not have a referencing outlet")
        
        // Act
        let signupButtonActions = try XCTUnwrap(signupButton.actions(forTarget: sut, forControlEvent: .touchUpInside), "Signup button does not have any actions assigned to it")

        // Assert
        XCTAssertEqual(signupButtonActions.count, 1)
        XCTAssertEqual(signupButtonActions.first, "signupButtonTapped:", "There is no action with a name signupButtonTapped assigned to signup button")
    }


}
