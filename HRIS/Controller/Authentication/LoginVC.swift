//
//  ViewController.swift
//  HRIS
//
//  Created by Muchammad Agung Laksana on 2/1/18.
//  Copyright © 2018 Muchammad Agung Laksana. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var userEmail : String?
    var hasBeenLoggedIn = false
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Assign Delegate
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        // login Button is initially disabled
        loginButton.alpha = 0.4
        loginButton.isEnabled = false
        
        // add target selector, in order to make loginButton enable when all text field is filled out
        emailTextField.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        
        // update UI Display
        loginButton.layer.cornerRadius = 5
        
        getUserData()
        fillEmailTextField()
        
    }
    
    @IBAction func loginButtonDidPressed(_ sender: Any) {
        
        
        // email shall be in the correct format
        guard ((emailTextField.text?.contains("@"))!) else {
            showAlert(alertTitle: "Sorry", alertMessage: "Your email should be in the correct format", actionTitle: "Back")
            return
        }
       
        
        activityIndicator.startAnimating()
        
        
        // save user data persistence using user default
        var userData : [String:Any] = [
            "email" : emailTextField.text!,
            "hasBeenLoggedIn" : true
        ]
        
        UserDefaults.standard.set(userData, forKey: "userData")
        userData = UserDefaults.standard.object(forKey: "userData") as! [String:Any]
        
         print("login successfully")
        activityIndicator.stopAnimating()
        
        
        performSegue(withIdentifier: "goToMainMenu", sender: self)
    }
    


}


extension LoginVC {
    
    // MARK: - Helper Methods
    
    func getUserData() {
        
        userData = UserDefaults.standard.object(forKey: "userData") as? [String:Any]
        
        if let userInformation = userData {
            userEmail = userInformation["email"] as? String
            hasBeenLoggedIn = userInformation["hasBeenLoggedIn"] as! Bool
        } else {
            print("user data in User Default is not available i.e user first time login")
        }

    }
    
    
    func fillEmailTextField() {
        guard let emailUser = userEmail else {return}
        
        // fill email textfield only if in the correct format
        if emailUser.contains("@") {
            emailTextField.text = emailUser
        }
    }
    
    
    
}




extension LoginVC  : UITextFieldDelegate {
    // MARK: - TextFieldDelegate
    
    @objc func editingChanged(_ textField: UITextField) {
        // to make signUpButton enable when all text field is filled out
       
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
        
        guard
            let email = emailTextField.text, !email.isEmpty,
            let password = passwordTextField.text, !password.isEmpty
            else {
                loginButton.alpha = 0.4
                loginButton.isEnabled = false
                return
        }
        loginButton.isEnabled = true
        loginButton.alpha = 1
        loginButton.backgroundColor = UIColor(red: 0/255, green: 117/255, blue: 38/255, alpha: 1)
        loginButton.titleLabel?.textColor = UIColor.white
    }
    
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // to move the cursor in the next textField after we pressed 'enter' in the keyboard
        
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
           passwordTextField.resignFirstResponder()
        }
        
        return true
    }
    
}




extension LoginVC {
    
    // to remove keyboard if we touch other area
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(false)
    }
    
}




extension LoginVC {
    
    // to make light color status bar
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    
}

