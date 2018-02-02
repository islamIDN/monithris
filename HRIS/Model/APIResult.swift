//
//  APIResult.swift
//  HRIS
//
//  Created by Muchammad Agung Laksana on 2/1/18.
//  Copyright © 2018 Muchammad Agung Laksana. All rights reserved.
//

import Foundation

enum APIResult<T> {
    case success(T)  
    case failure(Error)
}
