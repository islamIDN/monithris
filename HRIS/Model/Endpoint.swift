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
    case login(username: String, password: String)
   
    
    var baseURL : String {
        return "http://localhost"
    }
    
    
    
    var path : String {
        switch self {
        case .login : return "/twitter/register.php"
        }
    }
    
    
    
    
    private struct ParameterKeys {
        static let email = "email"
        static let password = "password"
    }
    
    
    var parameters : [String:Any] {
        
        switch self {
            
        case .login(let email, let password) :
            let parameters : [String:Any] = [
                ParameterKeys.email : email,
                ParameterKeys.password : password
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














































