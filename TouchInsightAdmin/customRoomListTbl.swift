//
//  customRoomListTbl.swift
//  TouchInsightAdmin
//
//  Created by Touch on 12/14/2558 BE.
//  Copyright © 2558 weerapons suwanchatree. All rights reserved.
//

import UIKit

class customRoomListTbl: UITableViewCell ,UICollectionViewDataSource ,UICollectionViewDelegate{

    
    @IBOutlet weak var roomnameLbl: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var numOfRoom: UILabel!
    @IBOutlet var editBtn: UIButton!
    @IBOutlet var deleteBtn: UIButton!
    @IBOutlet var bgView: UIView!
    var roomGallery = [[String:AnyObject]]()
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    @IBAction func deleteBtn(sender: AnyObject) {
        
    }
    
    @IBAction func editBtn(sender: AnyObject) {
//        print("Edit btn : \(sender)")
        
    }
    
    
    @IBOutlet var vc: UIView!
   
    var imgRoom :[String] = ["bg_cctvdefault.png","bg_cctvdefault.png","bg_cctvdefault.png","bg_cctvdefault.png","bg_cctvdefault.png"]

    override func awakeFromNib() {
        super.awakeFromNib()
       
        print("=======customRoomListTbl========")
        let nib = UINib(nibName: "customImgCell", bundle: nil)
        collectionView.registerNib(nib, forCellWithReuseIdentifier: "Cell")
        bgView.layer.cornerRadius = 5
        getRoomGallery()
        /*let nib = UINib(nibName: "customImgCell", bundle: nil)
        self.subCollectionView.registerNib(nib , forCellWithReuseIdentifier: "customImgCell")
*/
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
      
         // Configure the view for the selected state
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return roomGallery.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) ->UICollectionViewCell {
        let Cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell",forIndexPath: indexPath) as! customImgCell
        print("imageGal \(self.roomGallery[indexPath.row]["thumbnail"])")
        Cell.imgCell.image = UIImage(data: NSData(contentsOfURL: NSURL(string: (self.roomGallery[indexPath.row]["thumbnail"] as! String))!)!)
        return Cell
        
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }

    func getRoomGallery()
    {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                // do some task
            let send = API_Model()
            //        print("Room Dic : \(appDelegate.roomDic!["roomTypes"]!)")
            send.getRoomGallery(self.appDelegate.roomDic!["roomTypes"]![self.appDelegate.roomGalleryIndex!]!["room_type_id"] as! String){
                data in
                
                let countData = (data as NSArray).count
                if countData > 0 {
                    self.roomGallery = data
                }else{
                    
                    self.roomGallery = []
                }
                
                print("-countData-")
                print(countData)
                print("-RoomGalleryIndex-")
                print(self.appDelegate.roomGalleryIndex!)
                print("-Room ID-")
                print(self.appDelegate.roomDic!["roomTypes"]![self.appDelegate.roomGalleryIndex!]!["room_type_id"])
                print("-Room Data-")
                print(self.appDelegate.roomDic!["roomTypes"]![self.appDelegate.roomGalleryIndex!]!)
                print("================================================")
                
                dispatch_async(dispatch_get_main_queue()) {
                    // update some UI
                    
                    self.collectionView.reloadData()
                }
            }

        }
        
        
    }
    
    // MARK: UICollectionViewDataSource
    
}
