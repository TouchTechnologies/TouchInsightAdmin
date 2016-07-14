//
//  customMenuListTbl.swift
//  TouchInsightAdmin
//
//  Created by weerapons suwanchatree on 7/14/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

import UIKit

class customMenuListTbl: UITableViewCell ,UICollectionViewDataSource ,UICollectionViewDelegate{
    
    
    @IBOutlet weak var menuNameLbl: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var numOfRoom: UILabel!
    @IBOutlet var editBtn: UIButton!
    @IBOutlet var deleteBtn: UIButton!
    @IBOutlet var bgView: UIView!
    var menuGallery = [[String:AnyObject]]()
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    @IBAction func deleteBtn(sender: AnyObject) {
        print("delete Btn : \(sender)")
    }
    
    @IBAction func editBtn(sender: AnyObject) {
        print("Edit Btn : \(sender)")
    }
    
    
    @IBOutlet var vc: UIView!
    
    var imgRoom :[String] = ["bg_cctvdefault.png","bg_cctvdefault.png","bg_cctvdefault.png","bg_cctvdefault.png","bg_cctvdefault.png"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        print("customMenuListTbl")
        let nib = UINib(nibName: "customImgCell", bundle: nil)
        collectionView.registerNib(nib, forCellWithReuseIdentifier: "Cell")
        bgView.layer.cornerRadius = 5
//        getMenuGallery()
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
        return menuGallery.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) ->UICollectionViewCell {
        let Cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell",forIndexPath: indexPath) as! customImgCell
        print("imageGal \(self.menuGallery[indexPath.row]["thumbnail"])")
//        Cell.imgCell.image = UIImage(data: NSData(contentsOfURL: NSURL(string: (self.menuGallery[indexPath.row]["thumbnail"] as! String))!)!)
        return Cell
        
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    }
    
    func getMenuGallery()
    {
        let send = API_Model()
        print("appDelegate.menuGalleryIndex : \(appDelegate.roomGalleryIndex!)")
        //        print("Room Dic : \(appDelegate.roomDic!["roomTypes"]!)")
        send.getRoomGallery(appDelegate.menuDic!["menus"]![appDelegate.menuGalleryIndex!]!["room_type_id"] as! String){
            data in
            print("getRoomGallery(customRoomListTbl): \(data)")
            self.menuGallery = data
            self.collectionView.reloadData()
        }
        
    }
    
    // MARK: UICollectionViewDataSource
    
    
}

