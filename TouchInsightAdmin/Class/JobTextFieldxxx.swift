//
//  JobTextField.swift
//  JOBBKK
//
//  Created by Thirawat Phannet on 11/14/2558 BE.
//  Copyright © 2558 Thirawat Phannet. All rights reserved.
//

import Foundation
import UIKit

class JobTextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 5);
    
    func setTextFieldLogin(){
        
        let textPadding = UIEdgeInsets(top: 0, left: 80, bottom: 0, right: 6);
        
        var newBounds = bounds
        newBounds.origin.x += textPadding.left
        newBounds.origin.y += textPadding.top
        newBounds.size.height -= textPadding.top + textPadding.bottom
        newBounds.size.width -= textPadding.left + textPadding.right
        
        print(self.frame)
        print(newBounds)
        //self.bounds = newBounds
        self.backgroundColor = UIColor.whiteColor()
        
        self.layer.borderColor = UIColor.redColor().CGColor
        self.layer.borderWidth = 1.6
        self.layer.cornerRadius = 16
        
    }
    
    func setTextFieldLoginPlaceholder(setString:String){
        
        self.attributedPlaceholder = NSAttributedString(string:setString,attributes:[NSForegroundColorAttributeName: UIColor(red:0.57, green:0.57, blue:0.57, alpha:1)])
        
    }
    
    
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return self.newBounds(bounds)
    }
    
    override func placeholderRectForBounds(bounds: CGRect) -> CGRect {
        return self.newBounds(bounds)
    }
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return self.newBounds(bounds)
    }
    
    
    private func newBounds(bounds: CGRect) -> CGRect {
        
        var newBounds = bounds
        newBounds.origin.x += padding.left
        newBounds.origin.y += padding.top
        newBounds.size.height -= padding.top + padding.bottom
        newBounds.size.width -= padding.left + padding.right
        return newBounds
    }
}