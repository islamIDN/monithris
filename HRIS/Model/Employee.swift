//
//  user.swift
//  HRIS
//
//  Created by Muchammad Agung Laksana on 2/1/18.
//  Copyright © 2018 Muchammad Agung Laksana. All rights reserved.
//

import Foundation

struct Employee {
    
    var name : String
    var NIK : Int
    var department : String
    var level : String
    var imagePath : String?
    var company : String
    var superior : Int
    
    init(name: String, NIK: Int, department: String, level: String, company:String, superior: Int) {
        self.name = name
        self.NIK = NIK
        self.superior = superior
        self.department = department
        self.level = level
        self.company = company
    }
    
    
    init (dictionary: [String:Any]) {
        name = dictionary["NamaKaryawan"] as! String
        NIK = dictionary["NIK"] as! Int
        department = dictionary["Departmen"] as! String
        level = dictionary["Level"] as! String
        superior = dictionary["Superior"] as! Int
        company = dictionary["Company"] as! String
        imagePath = dictionary["Url"] as? String
    }
   
}



























