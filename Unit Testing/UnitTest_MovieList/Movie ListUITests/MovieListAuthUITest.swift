//
//  Movie_ListUITests.swift
//  Movie ListUITests
//

import XCTest
@testable import Movie_List

class Movie_ListUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        app.terminate()
    }
    
    func testAuthRequiredUIElementsAreEnable() throws {
        let nameTextField = app.textFields["name"]
        let emailTextField = app.textFields["email"]
        let passwordTextField = app.textFields["password"]
        let confirmPasswordTextField = app.textFields["confirmPassword"]
        
        XCTAssertTrue(nameTextField.isEnabled, "Name text field not enable for user interaction")
        XCTAssertTrue(emailTextField.isEnabled, "Email text field not enable for user interaction")
        XCTAssertTrue(passwordTextField.isEnabled, "Password text field not enable for user interaction")
        XCTAssertTrue(confirmPasswordTextField.isEnabled, "Confirm password text field not enable for user interaction")
    }
    
    func testLoginFlow() {
        let nameTextField = app.textFields["name"]
        nameTextField.tap()
        nameTextField.typeText("Ariful")
        
        let emailTextField = app.textFields["email"]
        emailTextField.tap()
        emailTextField.typeText("a@a.com")
        
        let passwordSecureTextField = app.textFields["password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("12345678")
        
        let confirmpasswordSecureTextField = app.textFields["confirmPassword"]
        confirmpasswordSecureTextField.tap()
        confirmpasswordSecureTextField.typeText("1234567")
        
        let loginButton = app.buttons["login"]
        loginButton.tap()
    }
}
