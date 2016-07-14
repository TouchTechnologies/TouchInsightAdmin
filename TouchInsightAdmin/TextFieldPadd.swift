//
//  TextFieldPadd.swift
//  TouchInsightAdmin
//
//  Created by Thirawat Phannet on 14/7/59.
//  Copyright © พ.ศ. 2559 weerapons suwanchatree. All rights reserved.
//

import Foundation
class TextFieldPadd: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5);
    
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func placeholderRectForBounds(bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
}