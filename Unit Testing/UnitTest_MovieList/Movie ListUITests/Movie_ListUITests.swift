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
    
    func testAuth() throws {
        
        let app = XCUIApplication()
        app.textFields["name"].tap()
        
        let emailTextField = app.textFields["email"]
        emailTextField.tap()
        emailTextField.tap()
        
        let passwordSecureTextField = app.secureTextFields["password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.tap()
        
        let confirmpasswordSecureTextField = app.secureTextFields["confirmPassword"]
        confirmpasswordSecureTextField.tap()
        confirmpasswordSecureTextField.tap()
        app/*@START_MENU_TOKEN@*/.buttons["login"]/*[[".buttons[\"Login\"]",".buttons[\"login\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let movieListNavigationBar = app.navigationBars["Movie List"]
        let searchSearchField = movieListNavigationBar.searchFields["Search"]
        searchSearchField.tap()
        searchSearchField.tap()
        movieListNavigationBar.buttons["love"].tap()
        app.navigationBars["Movie_List.CartView"].buttons["Movie List"].tap()
            
    }
}
