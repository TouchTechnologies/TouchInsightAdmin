//
//  customProviderView.swift
//  TouchInsightAdmin
//
//  Created by Touch on 12/8/2558 BE.
//  Copyright © 2558 weerapons suwanchatree. All rights reserved.
//

import UIKit

class customProviderView: UITableViewCell {

    @IBOutlet var imgProvider: UIImageView!
    @IBOutlet weak var lblProviderName: UILabel!
    @IBOutlet weak var lblProviderType: UILabel!
    
    @IBOutlet var teamDetailView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.teamDetailView.layer.cornerRadius = 5
        self.imgProvider.layer.cornerRadius = 5
        
        //lblProviderType.text = "AAAAAA"
        //lblProviderName.text = "BBBBB"
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
