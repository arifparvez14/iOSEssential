//
//  SignupModelValidatorProtocol.swift
//  TDD_Demo
//
//  Created by Faiaz Rahman on 13/8/23.
//

import Foundation

protocol SignupModelValidatorProtocol {
    
      func isFirstNameValid(firstName: String) -> Bool
      
      func isLastNameValid(lastName: String) -> Bool
      
      func isValidEmailFormat(email: String) -> Bool
      func isPasswordValid(password: String) -> Bool
      
      func doPasswordsMatch(password: String, repeatPassword: String) -> Bool
}
