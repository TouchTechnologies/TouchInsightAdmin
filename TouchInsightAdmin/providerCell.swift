//
//  providerCell.swift
//  TouchInsightAdmin
//
//  Created by Touch on 12/21/2558 BE.
//  Copyright © 2558 weerapons suwanchatree. All rights reserved.
//

import UIKit

class providerCell: UITableViewCell {

    @IBOutlet var providerImg: UIImageView!
    @IBOutlet var providerTypeLbl: UILabel!
    
    
    var scx = CGFloat()
    var scy = CGFloat()
    var imgRect = CGRect()
    var lblRect = CGRect()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.initialSize()
        // Initialization cod
        providerImg.frame = imgRect
        providerTypeLbl.frame = lblRect
    }
    func initialSize(){
    
        scy = (1024.0/480.0);
        scx = (768.0/360.0);
        
        
        if(UI_USER_INTERFACE_IDIOM() == .Pad){
            imgRect = CGRectMake(8*scx, 8*scy, 60*scx, 60*scy)
            lblRect = CGRectMake(86*scx, 24*scy, 197*scx, 25*scy)
           
        }
        else{
            imgRect = CGRectMake(8, 8, 60, 60)
            lblRect = CGRectMake(86, 24, 197, 25)
           
            
        }
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.backgroundColor = UIColor.whiteColor()
        // Configure the view for the selected state
    }

}
