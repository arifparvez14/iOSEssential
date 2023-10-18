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

enum AuthError: String, Error {
    case nameValidationError = "Name should be within 5 to 15 character"
    case emailValidationError = "Invalid Email address"
    case passwordValidationError = "Password length should be withon 5 to 15 character"
    case matchPasswordValidationError = "Password didn't match"
}

struct AuthCredentials {
    let name: String?
    let email: String?
    let password: String?
    let confirmPassword: String?
}

class AuthValidator: AuthValidatorProtocol {
    
    let minLength = 5
    let maxLength = 15
    
    func nameValid(name: String?) -> Bool {
        guard let name = name else { return false }
        
        if name.count < minLength || name.count > maxLength {
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
        
        if password.count < minLength || password.count > maxLength {
            return false
        }
        return true
    }
    
    func doPasswordsMatch(password: String?, repeatPassword: String?) -> Bool {
        guard let password = password, let repeatPassword = repeatPassword else { return false }
        return password == repeatPassword
    }
}

