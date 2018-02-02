//
//  DesignableTextField.swift
//  HRIS
//
//  Created by Muchammad Agung Laksana on 2/2/18.
//  Copyright © 2018 Muchammad Agung Laksana. All rights reserved.
//

import UIKit

@IBDesignable


class DesignableTextField: UITextField {
    
    @IBInspectable var leftImage : UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var leftPadding : CGFloat = 0 {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var cornerRadiusOfField : CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadiusOfField
        }
    }
    
    
    
    func updateView() {
        if let image = leftImage {
            leftViewMode = .always
            
            // assigning image
            let imageView = UIImageView(frame: CGRect(x: leftPadding, y: 0, width: 20, height: 20))
            imageView.image = image
            
            var width = leftPadding + 20
            
            if borderStyle == UITextBorderStyle.none || borderStyle == UITextBorderStyle.line {
                width += 5
            }
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 20)) // has 5 point higher in width in imageView
            view.addSubview(imageView)
            
            
            leftView = view
            
        } else {
            // image is nill
            leftViewMode = .never
        }
    }
    
    
    
}

