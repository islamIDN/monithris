//
//  ViewController.swift
//  HRIS
//
//  Created by Muchammad Agung Laksana on 2/1/18.
//  Copyright © 2018 Muchammad Agung Laksana. All rights reserved.
//

import UIKit
import SwiftyJSON


class LoginVC: UIViewController {
    

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var usernameOfUser : String?
    var registrationID : String?
    var hasBeenLoggedIn = false
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initial Value for LoginVC
        loginButton.alpha = 0.4
        loginButton.isEnabled = false
        
       
        addFunctionalityToTextField()
        getUserData()
        fillTextField()
        
    }
    
    @IBAction func loginButtonDidPressed(_ sender: Any) {
  
        
        // TODO: - Generate FCM Token as registrationID
        registrationID = "123" // this shall be generated from FCM
        guard let regID = registrationID else {return}
        
        
        
        
        self.activityIndicator.startAnimating()
        
        // send request to the server
        let loginEndPoint = EndPoint.login(loginUser: usernameTextField.text!, password: passwordTextField.text!, registrationID: regID)
        NetworkingService.fetchJSONData(endPoint: loginEndPoint) { (result) in
            
            
            
            switch result {
            case .failure(let error) :
                self.activityIndicator.stopAnimating()
                self.showAlert(alertTitle: "Sorry", alertMessage: error.localizedDescription, actionTitle: "Back")
            case .success(let jsonFromServer) :
                
                let json = jsonFromServer as! JSON
                let validity = json["valid"].intValue
                
                
                if validity == 0 {
                    guard let messageFromServer = json["message"].string else {return}
                    self.activityIndicator.stopAnimating()
                    self.showAlert(alertTitle: "Sorry", alertMessage: messageFromServer, actionTitle: "Back")
                } else {
                    
                    guard let dataOfEmployee = json["data"].dictionaryObject else {return}
                    
                    // create Employee Object
                    employee = Employee(dictionary: dataOfEmployee)
         
                    self.saveDataUserUsingUserDefault()
                    self.activityIndicator.stopAnimating()
                    self.performSegue(withIdentifier: "goToMainMenu", sender: self)
                }
         
            }
            
        }
        
        
        
    }
    
 
    

}








extension LoginVC {
    
    // MARK: - Helper Methods
    
    func getUserData() {
        
        userData = UserDefaults.standard.object(forKey: "userData") as? [String:Any]
        
        if let userInformation = userData {
            usernameOfUser = userInformation["username"] as? String
            hasBeenLoggedIn = userInformation["hasBeenLoggedIn"] as! Bool
        } else {
            print("user data in User Default is not available i.e user first time login")
        }

    }
    
    
    func fillTextField() {
        guard let username = usernameOfUser else {return}
        usernameTextField.text = username
    }
    
    
    func saveDataUserUsingUserDefault() {
        // save data persistence using user default
        let dataOfUser : [String:Any] = [
            "username" : self.usernameTextField.text!,
            "password" : self.passwordTextField.text!,
            "registrationID" : self.registrationID!,
            "hasBeenLoggedIn" : true
        ]
        
        UserDefaults.standard.set(dataOfUser, forKey: "userData")
        userData = UserDefaults.standard.object(forKey: "userData") as? [String:Any]
    }
    
    
    
    func addFunctionalityToTextField() {
        
        // Assign Delegate
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        
        // add target selector, in order to make loginButton enable when all text field is filled out
        usernameTextField.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        
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
            let username = usernameTextField.text, !username.isEmpty,
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
        
        if textField == usernameTextField {
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




