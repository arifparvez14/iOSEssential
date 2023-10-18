//
//  LoginValidatorProtocol.swift
//  BasicApp_UnitTest
//
//  Created by BJIT on 10/7/23.
//

import Foundation

protocol LoginValidatorProtocol {
    
      func isFirstNameValid(firstName: String) -> Bool
      func isValidEmailFormat(email: String) -> Bool
      func isPasswordValid(password: String) -> Bool
      func doPasswordsMatch(password: String, repeatPassword: String) -> Bool
}
