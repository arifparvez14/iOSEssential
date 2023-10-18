//
//  LoginVC.swift
//  BasicApp_UnitTest
//
//  Created by Faiaz Rahman on 9/7/23.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var namefield: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var password2Field: UITextField!
    @IBOutlet weak var signupBtn: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signupBtn.layer.cornerRadius = 10

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func signUpBtnAction(_ sender: Any) {
        
        let validator = LoginValidator()
        
        let name = namefield.text
        let password = passwordField.text
        let repeatPassword = password2Field.text
        let email = emailField.text
        
        if validator.isFirstNameValid(firstName: name!) && validator.isPasswordValid(password: password!) && validator.doPasswordsMatch(password: password!, repeatPassword: repeatPassword!) && validator.isValidEmailFormat(email: email!) {
            
            if let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "BasketBall") as? BasketBall {
                self.navigationController?.pushViewController(destinationVC, animated: true)
            }
        }
        
        
    }
    
    func checkCredentials(name: String?, password: String?) -> Bool{
        
        if name?.count != 0 && password?.count != 0 {
            return true
        }
        print("Out")
        return false
    }
    
}
