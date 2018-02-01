//
//  MainMenuVC.swift
//  HRIS
//
//  Created by Muchammad Agung Laksana on 2/1/18.
//  Copyright © 2018 Muchammad Agung Laksana. All rights reserved.
//

import UIKit

class MainMenuVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    
    @IBAction func logOutMenuDidPressed(_ sender: Any) {
        
        // update login status in the user default
        var updateUserDefault  = UserDefaults.standard.object(forKey: "userData") as? [String:Any]
        updateUserDefault?["hasBeenLoggedIn"] = false
        UserDefaults.standard.set(updateUserDefault, forKey: "userData")
        UserDefaults.standard.synchronize()
        
        //go to loginVC
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = storyboard.instantiateViewController(withIdentifier: "loginVC")
        present(loginVC, animated: true, completion: nil)
        
    }
    


}
