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
   
    
    var baseURL : String {
        
        switch self {
        case .login : return "http://192.168.1.37"
      
        }
        
    }
    
    
    
    var path : String {
        switch self {
        case .login : return "/TeraHr/index.php/RestAttendance/Login"
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
        static let key = "%40PakuAttendance20171207%40"
        static let date = 1
    }
    
    
    
    var requestBody : String {
        
        switch self {
        case .login(let loginUser, let password, let registrationID) :
            return "loginUser=\(loginUser)&password=\(password)&registrationid=\(registrationID)&key=\(DefaultValues.key)"
        }
    }
    
    var requestMethod : String {
        switch self {
        case .login : return "POST"
        }
    }
    
    
    
    
    var request : URLRequest {
        
        switch self {
       
        case .login :
            let url = URL(string: "\(baseURL)\(path)")
            
            var request = URLRequest(url: url!)
            request.httpMethod = requestMethod
            
            let body = requestBody
            request.httpBody = body.data(using: .utf8)
            
            return request
        }
        
        
    }
    
    
    
    
    
    
    
}














































