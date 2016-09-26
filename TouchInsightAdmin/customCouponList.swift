//
//  customRoomListTbl.swift
//  TouchInsightAdmin
//
//  Created by Touch on 12/14/2558 BE.
//  Copyright © 2558 weerapons suwanchatree. All rights reserved.
//

import UIKit

class customCouponList: UITableViewCell{
    
    @IBOutlet var viewBG: UIView!
    
    @IBOutlet var imgBG: UIImageView!
    @IBOutlet var imgLogo: UIImageView!
    
    @IBOutlet var imgIconTitle: UIImageView!
    @IBOutlet var lblTitle: UILabel!
    
    @IBOutlet var lblDiscount: UILabel!
    
    @IBOutlet var lblUsed: UILabel!
    @IBOutlet var imgIconExpire: UIImageView!
    @IBOutlet var lblExpireDate: UILabel!
    
    
    
    //let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imgBG.image = UIImage.imageWithColor(UIColor.whiteColor())
        imgBG.highlightedImage = UIImage.imageWithColor(UIColor(red:0.98, green:0.98, blue:0.98, alpha:1.00))
        
        //imgLogo.layer.borderWidth = 0.5
        //imgLogo.layer.borderColor = UIColor.grayColor().CGColor
        
        
        viewBG.layer.borderWidth = 0.5
//        viewBG.layer.borderColor = UIColor.grayColor().CGColor
//        viewBG.backgroundColor = UIColor.whiteColor()
        
        /*let nib = UINib(nibName: "customImgCell", bundle: nil)
        self.subCollectionView.registerNib(nib , forCellWithReuseIdentifier: "customImgCell")
*/
        // Initialization code
    }
    
    

//    override func setSelected(selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//      
//         // Configure the view for the selected state
//    }

//    func loadData(){
//        
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
//                // do some task
////            let send = API_Model()
////            //        print("Room Dic : \(appDelegate.roomDic!["roomTypes"]!)")
////            send.getRoomGallery(self.appDelegate.roomDic!["roomTypes"]![self.appDelegate.roomGalleryIndex!]!["room_type_id"] as! String){
////                data in
////                
////                let countData = (data as NSArray).count
////                if countData > 0 {
////                    self.roomGallery = data
////                }else{
////                    
////                    self.roomGallery = []
////                }
////                
//////                print("-countData-")
//////                print(countData)
//////                print("-RoomGalleryIndex-")
//////                print(self.appDelegate.roomGalleryIndex!)
//////                print("-Room ID-")
//////                print(self.appDelegate.roomDic!["roomTypes"]![self.appDelegate.roomGalleryIndex!]!["room_type_id"])
//////                print("-Room Data-")
//////                print(self.appDelegate.roomDic!["roomTypes"]![self.appDelegate.roomGalleryIndex!]!)
//////                print("================================================")
////                
//                dispatch_async(dispatch_get_main_queue()) {
//                    // update some UI
//                    
//                }
////            }
////
//        }
//        
//        
//    }
    
    // MARK: UICollectionViewDataSource
    
}
