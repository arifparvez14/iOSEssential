//
//  LoginScreenUITests.swift
//  LoginScreenUITests
//
//  Created by BJIT on 22/8/23.
//

import XCTest

final class LoginScreenUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoginScreen_whenAllPropertiesValid_labelShouldShowSuccessfull() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let statusLabel = app.staticTexts["status"]
        
        
        let firstNameTextField = app.textFields["firstName"]
        firstNameTextField.tap()
        firstNameTextField.typeText("John")

        let emailTextField = app/*@START_MENU_TOKEN@*/.textFields["email"]/*[[".textFields[\"Email\"]",".textFields[\"email\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        emailTextField.tap()
        emailTextField.typeText("john@gmail.com")
        
        let passwordTextField = app.textFields["password"]
        passwordTextField.tap()
        passwordTextField.typeText("Bangladesh1971")
        
        let repeatpasswordTextField = app/*@START_MENU_TOKEN@*/.textFields["repeatPassword"]/*[[".textFields[\"Repeat Password\"]",".textFields[\"repeatPassword\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        repeatpasswordTextField.tap()
        repeatpasswordTextField.typeText("Bangladesh1971")
        
        app.buttons["Login"].tap()
        
        XCTAssertEqual("Successful", statusLabel.label)

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
