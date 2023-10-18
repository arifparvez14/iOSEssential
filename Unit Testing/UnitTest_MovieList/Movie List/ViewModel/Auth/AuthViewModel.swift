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
    func submit(authCredentials: AuthCredentials, onCompletion: (String?) -> ())
}


class AuthViewModel: AuthViewModelProtocol {
    
    weak var viewDelegate: AuthViewDelegate?
    weak var coordinatorDelegate: AuthCoordinationDelegate?
    var authValidator: AuthValidatorProtocol
    
    init(authValidator: AuthValidatorProtocol) {
        self.authValidator = authValidator
    }
    
    func submit(authCredentials: AuthCredentials, onCompletion: (String?) -> ()) {
        if !authValidator.nameValid(name: authCredentials.name) {
            onCompletion(AuthError.nameValidationError.rawValue)
        } else if !authValidator.isValidEmailFormat(email: authCredentials.email) {
            onCompletion(AuthError.emailValidationError.rawValue)
        } else if !authValidator.isPasswordValid(password: authCredentials.password) {
            onCompletion(AuthError.passwordValidationError.rawValue)
        } else if !authValidator.doPasswordsMatch(password: authCredentials.password, repeatPassword: authCredentials.confirmPassword) {
            onCompletion(AuthError.matchPasswordValidationError.rawValue)
        } else {
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
            coordinatorDelegate?.authCoordinatorDidFinish(viewModel: self)
            onCompletion(nil)
        }
    }
    
    func submit(authCredentials: AuthCredentials) {
        if !authValidator.nameValid(name: authCredentials.name) {
            viewDelegate?.validationError(errorMessage: AuthError.nameValidationError.rawValue)
        } else if !authValidator.isValidEmailFormat(email: authCredentials.email) {
            viewDelegate?.validationError(errorMessage: AuthError.emailValidationError
                .rawValue)
        } else if !authValidator.isPasswordValid(password: authCredentials.password) {
            viewDelegate?.validationError(errorMessage: AuthError.passwordValidationError.rawValue)
        } else if !authValidator.doPasswordsMatch(password: authCredentials.password, repeatPassword: authCredentials.confirmPassword) {
            viewDelegate?.validationError(errorMessage: AuthError.matchPasswordValidationError.rawValue)
        } else {
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
            coordinatorDelegate?.authCoordinatorDidFinish(viewModel: self)
        }
    }
}
