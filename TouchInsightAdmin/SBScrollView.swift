//
//  SBScrollView.swift
//  TouchInsightAdmin
//
//  Created by Touch on 2/8/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

import UIKit

class SBScrollView: UIScrollView {
    
    var scrollViewHeight: CGFloat = 0.0
    var scGrap: CGFloat = 0.0
    
  

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        if (UI_USER_INTERFACE_IDIOM() == .Pad) {
            scGrap = 150.0
        }
        else {
            scGrap = 15.0
        }
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        for view: UIView in self.subviews {
            if !view.hidden {
                let y: CGFloat = view.frame.origin.y
                let h: CGFloat = view.frame.size.height
                if y + h > scrollViewHeight {
                    scrollViewHeight = h + y
                }
            }
        }
        self.showsHorizontalScrollIndicator = true
        self.showsVerticalScrollIndicator = true
        self.contentSize = (CGSizeMake(self.frame.size.width, scrollViewHeight + scGrap))
    }


}
