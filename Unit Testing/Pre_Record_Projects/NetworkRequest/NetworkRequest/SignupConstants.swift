//
//  SignupConstants.swift
//  NetworkRequest_Integration
//
//  Created by BJIT on 14/8/23.
//

import Foundation

struct SignupConstants {
    static let firstNameMinLength = 2
    static let firstNameMaxLength = 10
    static let lastNameMinLength = 2
    static let lastNameMaxLength = 12
    static let passwordMinLength = 8
    static let passwordMaxLength = 16
    static let signupURLString = "https://tlyqhtlbn8.execute-api.us-east-1.amazonaws.com/prod/signup-mock-service/users"
}
