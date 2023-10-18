//
//  LoginVC.swift
//  TestingDemo
//
//  Created by BJIT on 22/8/23.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var statusField: UILabel!
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var repeatPassword: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        blurView.layer.cornerRadius = 20
        loginBtn.layer.cornerRadius = 10
    }
    
    @IBAction func loginBtnAction(_ sender: Any) {
        
        if isLoginSuccessful() {
            
            // Making network call
            let webService = SignupWebService(urlString: Constants.signupURLString)
            let signFormRequestModel = SignupFormRequestModel(firstName: firstName.text!, lastName: "Doe", email: emailField.text!, password: password.text!)
            
            webService.signup(withForm: signFormRequestModel) { (signupResponseModel, error) in
                if let result = signupResponseModel {
                    DispatchQueue.main.async {
                        self.statusField.text = "Successful"
                    }
                } else {
                    self.statusField.text = "Failed"
                }
            }
            
            
        } else {
            statusField.text = "Failed"
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
            self.statusField.text = ""
        }
    }
    
    func isLoginSuccessful() ->Bool {
        let validator = LoginValidator()
        
        let name = firstName.text
        let password = password.text
        let repeatPassword = repeatPassword.text
        let email = emailField.text
        
        if validator.isFirstNameValid(firstName: name!) && validator.isPasswordValid(password: password!) && validator.doPasswordsMatch(password: password!, repeatPassword: repeatPassword!) && validator.isValidEmailFormat(email: email!) {
            return true
        } else {
            return false
        }
    }
    

}
