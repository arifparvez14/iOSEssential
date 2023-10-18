//
//  LoginValidator.swift
//  TestingDemo
//
//  Created by BJIT on 22/8/23.
//


import Foundation

class LoginValidator {
    
    func isFirstNameValid(firstName: String) -> Bool {
        var returnValue = true
        
        if firstName.count < 2 || firstName.count > 10 {
            returnValue = false
        }
        
        return returnValue
    }
    
    func isLastNameValid(lastName: String) -> Bool {
        var returnValue = true
        
        if lastName.count < 2 || lastName.count > 12 {
            returnValue = false
        }
        
        return returnValue
    }
    
    func isValidEmailFormat(email: String) -> Bool {
       return NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: email)
    }
    
    func isPasswordValid(password: String) -> Bool {
        var returnValue = true
        
        if password.count < 8 ||
        password.count > 16 {
            returnValue = false
        }
        
        return returnValue
    }
    
    func doPasswordsMatch(password: String, repeatPassword: String) -> Bool {
        return password == repeatPassword
    }
    
}
