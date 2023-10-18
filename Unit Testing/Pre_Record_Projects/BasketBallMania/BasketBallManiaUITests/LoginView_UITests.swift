//
//  BasicApp_UnitTestUITests.swift
//  BasicApp_UnitTestUITests
//
//  Created by BJIT on 10/7/23.
//

import XCTest

final class LoginView_UITests: XCTestCase {
    
    private var app: XCUIApplication!
    private var firstName: XCUIElement!
    private var email: XCUIElement!
    private var password: XCUIElement!
    private var repeatPassword: XCUIElement!
    private var signupButton: XCUIElement!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        

        

        
        
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
//        app = nil
//        firstName = nil
//        email = nil
//        password = nil
//        repeatPassword = nil
//        signupButton = nil
        try super.tearDownWithError()
    }

    func testSignupViewController_WhenViewLoaded_RequiredUIElementsAreEnabled() throws {
        
        app = XCUIApplication()
        app.launch()
        
        
        email = app.textFields["emailAddressTextField"]
        firstName = app.textFields["firstNameTextField"]
        password = app.textFields["passwordTextField"]
        repeatPassword = app.textFields["repeatPasswordTextField"]
        signupButton = app.buttons["signupButton"]
             
        XCTAssertTrue(firstName.isEnabled, "First name UITextField is not enabled for user interactions")
        XCTAssertTrue(email.isEnabled, "Email address UITextField is not enabled for user interactions")
        XCTAssertTrue(password.isEnabled, "Password UITextField is not enabled for user interactions")
        XCTAssertTrue(repeatPassword.isEnabled, "Repeat password UITextField is not enabled for user interactions")
        XCTAssertTrue(signupButton.isEnabled, "The Signup button is not enabled for user interactions")

    }
    
    func testViewController_WhenValidFormSubmitted_navigateToGameVC() {
        // Arrange
        
        app = XCUIApplication()
        app.launch()
        
        
        
        
        email = app.textFields["emailAddressTextField"]
        email.tap()
        email.typeText("test@test.com")
        
        firstName = app.textFields["firstNameTextField"]
        firstName.tap()
        firstName.typeText("Sergey")
        
        
        password = app.textFields["passwordTextField"]
        password.tap()
        password.typeText("12345678")
        
        repeatPassword = app.textFields["repeatPasswordTextField"]
        repeatPassword.tap()
        repeatPassword.typeText("12345678")
        
        signupButton = app.buttons["signupButton"]
        // Act
        signupButton.tap()
        
//        Thread.sleep(forTimeInterval: 1.0)

        // Assert
        let leftBtn = app.buttons["leftButton"]
        XCTAssertTrue(leftBtn.waitForExistence(timeout: 2), "App is not at Basket Ball VC")
        
        
//        XCTAssertTrue(app.alerts["successAlertDialog"].waitForExistence(timeout: 3), "A Success Alert dialog was not presented when valid signup form was submitted")
    }
    
    func testViewController_WhenBallPositionChanged_HitThePostbar() {
        // Arrange
        
        app = XCUIApplication()
        app.launch()
        
        
        email = app.textFields["emailAddressTextField"]
        email.tap()
        email.typeText("test@test.com")
        
        firstName = app.textFields["firstNameTextField"]
        firstName.tap()
        firstName.typeText("john")
        
        
        password = app.textFields["passwordTextField"]
        password.tap()
        password.typeText("12345678")
        
        repeatPassword = app.textFields["repeatPasswordTextField"]
        repeatPassword.tap()
        repeatPassword.typeText("12345678")
        
        signupButton = app.buttons["signupButton"]
        // Act
        signupButton.tap()
        

        // Assert
        let leftBtn = app.buttons["leftButton"]
        leftBtn.tap()
        leftBtn.tap()
        leftBtn.tap()
        
        let rightBtn = app.buttons["rightButton"]
        rightBtn.tap()
        rightBtn.tap()
        
        
        let throwBtn = app.buttons["throwBtn"]
        throwBtn.tap()

        rightBtn.tap()
        rightBtn.tap()
        
        leftBtn.tap()
        leftBtn.tap()
        leftBtn.tap()
        
        throwBtn.tap()
        
        XCTAssertTrue(leftBtn.waitForExistence(timeout: 2), "App is not at Basket Ball VC")
        
        
//        XCTAssertTrue(app.alerts["successAlertDialog"].waitForExistence(timeout: 3), "A Success Alert dialog was not presented when valid signup form was submitted")
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
