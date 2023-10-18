//
//  SignupModel.swift
//  NetworkRequest_Integration
//
//  Created by BJIT on 14/8/23.
//

import Foundation

struct SignupFormModel {
    let firstName: String
    let lastName: String
    let email: String
    let password: String
    let repeatPassword: String
}

struct SignupFormRequestModel: Encodable {
    let firstName: String
    let lastName: String
    let email: String
    let password: String
}

struct SignupResponseModel: Decodable {
    let status: String
}

protocol SignupWebServiceProtocol {
        func signup(withForm formModel: SignupFormRequestModel, completionHandler: @escaping (SignupResponseModel?, SignupError?) -> Void)
}
