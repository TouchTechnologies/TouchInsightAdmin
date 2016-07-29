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
       

        print("customRoomListTbl")
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
        let send = API_Model()
        print("appDelegate.roomGalleryIndex : \(appDelegate.roomGalleryIndex!)")
//        print("Room Dic : \(appDelegate.roomDic!["roomTypes"]!)")
        send.getRoomGallery(appDelegate.roomDic!["roomTypes"]![appDelegate.roomGalleryIndex!]!["room_type_id"] as! String){
            data in
            print("getRoomGallery(customRoomListTbl): \(data)")
            self.roomGallery = data
            self.collectionView.reloadData()
        }
        
    }
    
    // MARK: UICollectionViewDataSource
    
}
