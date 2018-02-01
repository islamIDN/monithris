//
//  AppDelegate.swift
//  HRIS
//
//  Created by Muchammad Agung Laksana on 2/1/18.
//  Copyright © 2018 Muchammad Agung Laksana. All rights reserved.
//

import UIKit


// Superglobal variable for user, saved in the NS user default (email, password, loginStatus etc)
var userData : [String: Any]?

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        loginCheck()
        
        return true
    }

    


}



extension AppDelegate {
    
    // MARK: - Helper Methods
    
    func loginCheck () {
        
        userData = UserDefaults.standard.object(forKey: "userData") as? [String:Any]
        guard let user = userData else { return }
      
        if let userHasBeenLoggedIn = user["hasBeenLoggedIn"] as? Bool {
            if userHasBeenLoggedIn == true {
                goToMainMenu()
            } else {
                 goToLoginVC()
            }
        }
    }
    
    
    
    func goToMainMenu () {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainMenu = storyboard.instantiateViewController(withIdentifier: "MainMenuVC")
        window?.rootViewController = mainMenu
        
    }
    
    func goToLoginVC () {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let login = storyboard.instantiateViewController(withIdentifier: "loginVC")
        window?.rootViewController = login
        
    }
    
}
















