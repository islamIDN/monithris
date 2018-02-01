//
//  alertExtension.swift
//  HRIS
//
//  Created by Muchammad Agung Laksana on 2/1/18.
//  Copyright © 2018 Muchammad Agung Laksana. All rights reserved.
//


import UIKit


extension UIViewController {
    
    func showAlert (alertTitle: String, alertMessage: String, actionTitle: String) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let alertAction1 = UIAlertAction(title: actionTitle, style: .default) { (action) in
            self.navigationController?.popToRootViewController(animated: true)
        }
        
        alert.addAction(alertAction1)
        present(alert, animated: true, completion: nil)
    }
    
}

