//
//  AppDelegate.swift
//  HRIS
//
//  Created by Muchammad Agung Laksana on 2/1/18.
//  Copyright © 2018 Muchammad Agung Laksana. All rights reserved.
//

import UIKit


// Superglobal variable for user saved in the user default (email, password, loginStatus etc)
var userData : [String: Any]?

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        loginCheck()
        
        
        // show user default location in the debugging area
        print("user default location : ")
        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)
        
        return true
    }

    


}



extension AppDelegate {
    
    // MARK: - Helper Methods
    
    func loginCheck () {
        
        guard let user = userData else {
            goToLoginVC()
            print("user data in user default info.plist is not available")
            return
            
        }
        
        
        if let userHasBeenLoggedIn = user["hasBeenLoggedIn"] as? Bool {
            if userHasBeenLoggedIn {
                goToLoginVC()
            } else {
                goToMainMenu()
            }
        }
    }
    
    
    
    func goToMainMenu () {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainMenu = storyboard.instantiateViewController(withIdentifier: "MainMenu")
        window?.rootViewController = mainMenu
        
    }
    
    func goToLoginVC () {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let login = storyboard.instantiateViewController(withIdentifier: "login")
        window?.rootViewController = login
        
    }
    
}
















