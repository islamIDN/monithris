//
//  AppDelegate.swift
//  HRIS
//
//  Created by Muchammad Agung Laksana on 2/1/18.
//  Copyright © 2018 Muchammad Agung Laksana. All rights reserved.
//

import UIKit


// Superglobal variable for user, saved using NSUserDefault (username, password, loginStatus, registrationID)
var userData : [String: Any]?
var employee : Employee?

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        loginCheck()
        
        // to make status bar in the light mode (in info.plist has to be set 'View controller-based status bar appearance' to NO)
        UIApplication.shared.statusBarStyle = .lightContent
        
        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)
        
        return true
    }

    


}



extension AppDelegate {
    
    // MARK: - Helper Methods
    
    func loginCheck () {
        
        // retrieve user data from NSUserDefault
        userData = UserDefaults.standard.object(forKey: "userData") as? [String:Any]
        
        guard let user = userData else {
            // if NSUserDefault is not available then go to LoginVC
            goToLoginVC()
            return
        }
        
      
        if let userHasBeenLoggedIn = user["hasBeenLoggedIn"] as? Bool {
            if userHasBeenLoggedIn {
                goToMainMenu()
            } else {
                 goToLoginVC()
            }
        }
    }
    
    
    
    func goToMainMenu () {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let NavigationBarVC = storyboard.instantiateViewController(withIdentifier: "NavigationBarVC")
        window?.rootViewController = NavigationBarVC
        
    }
    
    func goToLoginVC () {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let login = storyboard.instantiateViewController(withIdentifier: "loginVC")
        window?.rootViewController = login
        
    }
    
}
















