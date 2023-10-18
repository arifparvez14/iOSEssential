//
//  AuthViewModel.swift
//  Movie List
//
//  Created by Muhammad Ariful islam on 18/10/23.
//

import Foundation

protocol AuthViewDelegate: AnyObject {
    func validationError(errorMessage: String)
}

protocol AuthCoordinationDelegate: AnyObject {
    func authCoordinatorDidFinish(viewModel: AuthViewModel)
}

protocol AuthViewModelProtocol {
    var viewDelegate: AuthViewDelegate? { get set}
    var coordinatorDelegate: AuthCoordinationDelegate? { get set }
    func submit(authCredentials: AuthCredentials)
}

class AuthViewModel: AuthViewModelProtocol {
    
    weak var viewDelegate: AuthViewDelegate?
    weak var coordinatorDelegate: AuthCoordinationDelegate?
    var authValidator: AuthValidatorProtocol
    
    init(authValidator: AuthValidatorProtocol) {
        self.authValidator = authValidator
    }
    
    func submit(authCredentials: AuthCredentials) {
        if !authValidator.nameValid(name: authCredentials.name) {
            viewDelegate?.validationError(errorMessage: "Name should between 2 to 8 character ")
        } else if !authValidator.isValidEmailFormat(email: authCredentials.email) {
            viewDelegate?.validationError(errorMessage: "Email validation error")
        } else if !authValidator.isPasswordValid(password: authCredentials.password) {
            viewDelegate?.validationError(errorMessage: "Invalid password")
        } else if !authValidator.doPasswordsMatch(password: authCredentials.password, repeatPassword: authCredentials.confirmPassword) {
            viewDelegate?.validationError(errorMessage: "Password didn't match")
        } else {
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
            coordinatorDelegate?.authCoordinatorDidFinish(viewModel: self)
        }
    }
}
