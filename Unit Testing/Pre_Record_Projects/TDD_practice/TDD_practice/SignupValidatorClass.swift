//
//  SignupValidatorClass.swift
//  TDD_practice
//
//  Created by Faiaz Rahman on 15/8/23.
//

import Foundation

class SignupValidatorClass{
    
    
    func firstNameValidator(firstName: String) -> Bool {
        
        if firstName.count > 2 && firstName.count < 9  {
            return true
        } else {
            return false
        }
    }
}
