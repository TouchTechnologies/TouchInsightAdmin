//
//  customProviderView.swift
//  TouchInsightAdmin
//
//  Created by Touch on 12/8/2558 BE.
//  Copyright © 2558 weerapons suwanchatree. All rights reserved.
//

import UIKit
import Haneke

class customProviderView: UITableViewCell {

    @IBOutlet var imgProvider: UIImageView!
    @IBOutlet weak var lblProviderName: UILabel!
    @IBOutlet weak var lblProviderType: UILabel!
    @IBOutlet weak var bgProviderName: UIView!
    
    @IBOutlet var teamDetailView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        self.teamDetailView.layer.cornerRadius = 5
//        self.imgProvider.layer.cornerRadius = 5
//        let frm = self.maskView?.superview?.frame
//        print("---------- view size ----------")
//        print(frm)
//        print("-------------------------------")
        self.imgProvider.image = UIImage(named: "ic_no_image.png")
        
        //lblProviderType.text = "AAAAAA"
        //lblProviderName.text = "BBBBB"
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
