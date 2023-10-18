//
//  AuthViewController.swift
//  Movie List
//
//  Created by Muhammad Ariful islam on 18/10/23.
//

import UIKit

class AuthViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    var viewModel: AuthViewModelProtocol? {
        willSet {
            viewModel?.viewDelegate = nil
        } didSet {
            viewModel?.viewDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorMessageLabel.isHidden = true
    }
    
    @IBAction func loginBtnTapped(_ sender: Any) {
        let credentials = AuthCredentials(
            name: nameField.text,
            email: emailField.text,
            password: passwordField.text,
            confirmPassword: confirmPasswordField.text)
        
        //viewModel?.submit(authCredentials: credentials)
        viewModel?.submit(authCredentials: credentials) { (error) in
            if let error = error {
                errorMessageLabel.isHidden = false
                errorMessageLabel.text = error
            }
        }
        
    }
}

extension AuthViewController: AuthViewDelegate {
    func validationError(errorMessage: String) {
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = errorMessage
    }
}

