//
//  IntegrationTesting.swift
//  Movie ListTests
//
//  Created by Muhammad Ariful islam on 19/10/23.
//

import XCTest
@testable import Movie_List

final class IntegrationTesting: XCTestCase {

    var sut: MockRespository!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = MockRespository()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    
    func testUserInfo() {
        //given
        let entity = UserModel(name: "Ariful", email: "a@a.com", password: "123456")
        
        //when
        sut.addUser(entity: entity)
        
        //then
        let user = sut.fetchUser()
        XCTAssertEqual(entity.name, user.first?.name, "User info didn't match")
        
    }
}
