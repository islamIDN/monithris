//
//  Endpoint.swift
//  HRIS
//
//  Created by Muchammad Agung Laksana on 2/1/18.
//  Copyright © 2018 Muchammad Agung Laksana. All rights reserved.
//

import Foundation


// this enum job is to compose an URLRequest

enum EndPoint {
    case login(loginUser: String, password: String, registrationID: String)
    case uploadImage
    case checkin(userID: String, notes: String, latitude: String, longitude: String, location: String, time:String, url:String,status: String)
  
    
    var baseURL : String {
        
        switch self {
        case .login : return "http://192.168.1.37"
        case .uploadImage : return "http://app10.pakubuwono6.com"
        case .checkin : return "http://app10.pakubuwono6.com"
        }
        
    }
    
    
    
    var path : String {
        switch self {
        case .login : return "/TeraHr/index.php/RestAttendance/Login"
        case .uploadImage : return "/hris/index.php/RestAttendance/UploadImage"
        case .checkin : return "/hris/index.php/RestAttendance/CheckIn"
        }
    }
    
    
    private struct ParameterKeys {
        static let key = "key"
        static let loginUser = "loginUser"
        static let password = "password"
        static let registrationId = "registrationId"
        static let userID = "userid"
        static let notes = "notes"
        static let latitude = "latin"
        static let longitude = "lngint"
        static let location = "locationIn"
        static let time = "timein"
        static let url = "url"
        static let status = "Status"
    }
    
    private struct DefaultValues {
        static let key = "@PakuAttendance20171207@"
        static let month = 1
    }
    
    
    
    var parameters : [String:Any] {
        
        switch self {
            
        case .login(let loginUser, let password, let registrationID) :
            let parameters : [String:Any] = [
                ParameterKeys.loginUser : loginUser,
                ParameterKeys.password : password,
                ParameterKeys.registrationId : registrationID,
                ParameterKeys.key : DefaultValues.key
            ]
            return parameters
            
            
        case .uploadImage :
            let parameters : [String:Any] = [
                ParameterKeys.key : DefaultValues.key
            ]
            return parameters
            
      
        case .checkin(let userID, let notes, let latitude, let longitude, let location, let time, let url, let status):
            let parameters : [String:Any] = [
                ParameterKeys.userID : userID,
                ParameterKeys.notes : notes,
                ParameterKeys.latitude : latitude,
                ParameterKeys.longitude : longitude,
                ParameterKeys.location : location,
                ParameterKeys.time : time,
                ParameterKeys.url : url,
                ParameterKeys.status : status,
                ParameterKeys.key : DefaultValues.key
            ]
            return parameters
            
     
        }
    }
    
    
    
    
    
    private var queryComponents : [URLQueryItem] {
        // to let swift handle url encoding like %20 for space
        
        var components = [URLQueryItem]()
        
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.append(queryItem)
        }
        
        return components
    }
    
    
    
    
    
    var request : URLRequest {
        
        var component = URLComponents(string: baseURL)!
        component.path = path
        component.queryItems = queryComponents
        
        let url = component.url!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        return request
        
    }
    
    
    
    
    
    
    
}














































