//
//  MainMenuVC.swift
//  HRIS
//
//  Created by Muchammad Agung Laksana on 2/1/18.
//  Copyright © 2018 Muchammad Agung Laksana. All rights reserved.
//

import UIKit
import SwiftyJSON

class MainMenuVC: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var checkinStatusLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let dateFormatter = DateFormatter()
    var time : String?
    var date : String?
    var dateTime : String?
    var hasBeenCheckedin = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkEmployeeData()
        getDateTimeFromServer()
    }
    
    
    
    
    @IBAction func checkinButtonDidPressed(_ sender: Any) {
        
        
        if hasBeenCheckedin {
            
        } else {
            getDateTimeFromServer()
            performSegue(withIdentifier: "goToCheckin", sender: self)
            
            // TODO: - Please write Prepare for segue for this action
            // carry employee data and date time data
        }
        
        
    }
    
    
    
    @IBAction func logOut(_ sender: Any) {
        
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









extension MainMenuVC {
    
    // Helper Methods
    
    func updateUI() {
        guard let timeString = time,
            let dateString = date else { return }
       
        timeLabel.text = timeString
        dateLabel.text = dateString
    }
    
    func activateTimer() {
        // to update timeLabel in every 60 seconds
        Timer.scheduledTimer(timeInterval: 60 , target: self, selector: #selector(MainMenuVC.updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        guard let timeDate = dateTime else  {return}
        let currentDateTime = dateFormatter.date(from: timeDate)
        
        let secondsToAdd = 60
        var dateComponent = DateComponents()
        dateComponent.second = secondsToAdd
        let calculatedDate = Calendar.current.date(byAdding: dateComponent, to: currentDateTime!)
        
        let calculatedTimeDate = dateFormatter.string(from: calculatedDate!)
        timeLabel.text = parsingDateTime(from: calculatedTimeDate).timeOnly
    }
    
    
    
    func parsingDateTime(from dateTimeServer: String) -> (timeOnly: String, dateOnly: String) {
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateTimeData = dateFormatter.date(from: dateTimeServer)
        
        // parse the date component, and update the property
        dateFormatter.dateFormat = "HH:mm"
        let timeOnly = dateFormatter.string(from: dateTimeData!)
        
        dateFormatter.dateFormat = "EEEE, d MMMM yyyy"
        let dateOnly = dateFormatter.string(from: dateTimeData!)
        
        return(timeOnly,dateOnly)
    }
    
    
    
    func getDateTimeFromServer() {
        
        activityIndicator.startAnimating()
        
        let timeEndpoint = EndPoint.timeServer
        NetworkingService.fetchJSONData(endPoint: timeEndpoint) { (result) in
            
            switch result {
            case .failure(let error) :
                self.activityIndicator.stopAnimating()
                self.showAlert(alertTitle: "Sorry", alertMessage: error.localizedDescription, actionTitle: "Back")
            case .success(let jsonFromServer) :
                let json = jsonFromServer as! JSON
                let stringDateTimeServer = json["data"].stringValue
                self.dateTime = stringDateTimeServer
                
                let dateTimeString = self.parsingDateTime(from: stringDateTimeServer)
                self.time = dateTimeString.timeOnly
                self.date = dateTimeString.dateOnly
                
                self.updateUI()
                self.activateTimer()
                
                self.activityIndicator.stopAnimating()
            }
        }
      
    }
    
    
    
    func checkEmployeeData() {
        
        if employee == nil {
            // it means user directly enter to MainMenuVC, not through loginVC. then we have to get employee data
            
            guard let dataOfUser = userData else {return}
            let username = dataOfUser["username"] as? String
            let password = dataOfUser["password"] as? String
            let registrationID = dataOfUser["registrationID"] as? String
            
            
            // send request to the server to get employee data
            let loginEndPoint = EndPoint.login(loginUser: username!, password: password!, registrationID: registrationID!)
            
            NetworkingService.fetchJSONData(endPoint: loginEndPoint, completion: { (result) in
                
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
                        
                        guard let dataOfTheUser = json["data"].dictionaryObject else {return}
                        employee = Employee(dictionary: dataOfTheUser)
                        self.activityIndicator.stopAnimating()
                    }
                    
                }
                
            })
           
        }
    }
    
    
    
    
}








