//
//  DesignableButton.swift
//  PakuHRIS
//
//  Created by Muchammad Agung Laksana on 2/2/18.
//  Copyright © 2018 Muchammad Agung Laksana. All rights reserved.
//

import UIKit

class DesignableButton: UIButton {

    @IBInspectable var cornerRadiusOfButton : CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadiusOfButton
        }
    }

}
