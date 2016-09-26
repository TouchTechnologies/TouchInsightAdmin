//
//  introPage4.swift
//  TouchInsightAdmin
//
//  Created by Touch Developer on 2/26/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

import UIKit

class introPage4: UIView {

    @IBOutlet var pagedetailView: UIView!
    
    
  
     //Only override drawRect: if you perform custom drawing.
     //An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
       pagedetailView.frame = CGRectMake(0, UIScreen.mainScreen().bounds.size.height/4 , UIScreen.mainScreen().bounds.size.width, 80)
    }
  

}
