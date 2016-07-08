//
//  Resfacility.swift
//  TouchInsightAdmin
//
//  Created by Touch on 1/6/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

import UIKit

class Resfacility: UIView {
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    @IBOutlet var closeAlert: UIButton!
    @IBOutlet var collectionView: UICollectionView!

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
*/
    override func drawRect(rect: CGRect) {
        // Drawing code
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        let nib = UINib(nibName: "roomfacilityCell", bundle: nil)
        collectionView.registerNib(nib, forCellWithReuseIdentifier: "Cell")
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return appDelegate.facilityResDic!["facilities"]!.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) ->UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell",forIndexPath: indexPath) as! roomfacCell
        print("index: \(indexPath.row)")
        print("Facility Image Url :\(appDelegate.facilityResDic!["facilities"]![indexPath.row]["images"]!!["icons"]!!["lighten"] as! String)")
        
        if(!appDelegate.facilityHotelStatus[indexPath.row])
        {
            if let url  = NSURL(string: appDelegate.facilityResDic!["facilities"]![indexPath.row]["images"]!!["icons"]!!["lighten"] as! String),
                data = NSData(contentsOfURL: url)
            {
                
                cell.roomfacImg.image = UIImage(data: data)
            }
            cell.roomfacLabel.textColor = UIColor.grayColor()
            cell.roomfacLabel.text = (appDelegate.facilityResDic!["facilities"]![indexPath.row]["facility_name_en"] as! String)
        }
        else
        {
            if let url  = NSURL(string: appDelegate.facilityResDic!["facilities"]![indexPath.row]["images"]!!["icons"]!!["darken"] as! String),
                data = NSData(contentsOfURL: url)
            {
                
                cell.roomfacImg.image = UIImage(data: data)
            }
            cell.roomfacLabel.textColor = UIColor.blackColor()
            cell.roomfacLabel.text = (appDelegate.facilityResDic!["facilities"]![indexPath.row]["facility_name_en"] as! String)
        }
        
        print("Reload index :\(indexPath.row)")
        cell.backgroundColor = UIColor.whiteColor()
        return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        collectionView.deselectItemAtIndexPath(indexPath, animated: true)
        
        appDelegate.facilityHotelStatus[indexPath.row] = (appDelegate.facilityHotelStatus[indexPath.row]) ? false:true
        collectionView.reloadItemsAtIndexPaths([indexPath])
        
    }
    
    // change background color when user touches cell
    func collectionView(collectionView: UICollectionView, didHighlightItemAtIndexPath indexPath: NSIndexPath) {
        //        let cell = collectionView.cellForItemAtIndexPath(indexPath)
        //        cell!.backgroundColor = UIColor.greenColor()
    }
    
    // change background color back when user releases touch
    func collectionView(collectionView: UICollectionView, didUnhighlightItemAtIndexPath indexPath: NSIndexPath) {
        //        let cell = collectionView.cellForItemAtIndexPath(indexPath)
        //        cell!.backgroundColor = UIColor.redColor()
    }
}
