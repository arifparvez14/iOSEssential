//
//  AuthValidator.swift
//  Movie List
//
//  Created by Muhammad Ariful islam on 18/10/23.
//

import Foundation

protocol AuthValidatorProtocol {
      func nameValid(name: String?) -> Bool
      func isValidEmailFormat(email: String?) -> Bool
      func isPasswordValid(password: String?) -> Bool
      func doPasswordsMatch(password: String?, repeatPassword: String?) -> Bool
}

struct AuthConstants {
    static let firstNameMinLength = 2
    static let firstNameMaxLength = 10
    static let lastNameMinLength = 2
    static let lastNameMaxLength = 12
    static let passwordMinLength = 5
    static let passwordMaxLength = 16
}

struct AuthCredentials {
    let name: String?
    let email: String?
    let password: String?
    let confirmPassword: String?
}

class AuthValidator: AuthValidatorProtocol {
    
    func nameValid(name: String?) -> Bool {
        guard let name = name else { return false }
        
        if name.count < AuthConstants.firstNameMinLength || name.count > AuthConstants.firstNameMaxLength {
            return false
        }
        return true
    }
    
    func isValidEmailFormat(email: String?) -> Bool {
        guard let email = email else { return false }
        return NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: email)
    }
    
    func isPasswordValid(password: String?) -> Bool {
        guard let password = password else { return false }
        
        if password.count < AuthConstants.passwordMinLength || password.count > AuthConstants.passwordMaxLength {
            return false
        }
        return true
    }
    
    func doPasswordsMatch(password: String?, repeatPassword: String?) -> Bool {
        guard let password = password, let repeatPassword = repeatPassword else { return false }
        return password == repeatPassword
    }
}

