//
//  RoomInfoVC.swift
//  TouchInsightAdmin
//
//  Created by Touch on 12/9/2558 BE.
//  Copyright © 2558 weerapons suwanchatree. All rights reserved.
//

import UIKit
import Foundation
import SCLAlertView

class HotelCouponListVC: UIViewController,UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate {
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//     var editView = EditRoominfomationVC()
    @IBOutlet var tableView: UITableView!

    @IBOutlet var noRoomimage: UIImageView!
    @IBOutlet var noRoomTitle: UILabel!
    @IBOutlet var noRoomDesc: UILabel!
    @IBOutlet var noRoomLine: UIImageView!
    
    @IBOutlet var createButton: UIButton!
    var roomNameData:NSDictionary = ["":""]
    var editRoomTag = 0
    
    
    func initial(){
        
        tableView.frame = CGRectMake(0, 0,UIScreen.mainScreen().bounds.size.width , UIScreen.mainScreen().bounds.size.height)
        createButton.frame = CGRectMake(UIScreen.mainScreen().bounds.size.width - 90, UIScreen.mainScreen().bounds.size.height - 90, 64, 64)
        let width = UIScreen.mainScreen().bounds.size.width
        let height = UIScreen.mainScreen().bounds.size.height
        
        noRoomimage.frame = CGRectMake(width/2 - noRoomimage.frame.size.width/2, height/2 - 200, 100, 100)
        noRoomimage.center.x = width/2
        
        noRoomTitle.frame = CGRectMake(0,  height/2 - 80, width, 30)
        noRoomTitle.textAlignment = NSTextAlignment.Center
        //noRoomTitle.center.x = width/2
        noRoomDesc.frame = CGRectMake(0,  height/2 - 50, width, 30)
        noRoomDesc.textAlignment = NSTextAlignment.Center
        
        noRoomLine.frame = CGRectMake(width/2 - 70, height/2, 140,(height - 150) - noRoomLine.frame.origin.y )
        noRoomLine.center.x = width/2
    }
    
    @IBAction func creataRoomBtn(sender: AnyObject) {
        
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("HotelCreateCouponVC") as! HotelCreateCouponVC
        self.navigationController?.pushViewController(vc, animated:true)
      
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("room")
        print("viewDidLoad")
        self.initial()
        tableView.frame = self.view.frame
        let nib = UINib(nibName: "customCouponList", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "Cell")
        print("roomData2 didLoad :\(roomNameData)")
        
        
        
        
    }
    override func viewDidAppear(animated: Bool) {
//        super.viewDidAppear(true)
        print("viewDidAppear")
        self.getRoomType()
    }
    
    func getRoomType()
    {
        let send = API_Model()
        let dataDic = [
            "providerInformation" : [
                "providerId" : appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["provider_id"]! as! String,
                "providerTypeKeyname" : "hotel"
            ],
            "user" : [
                "accessToken" : appDelegate.userInfo["accessToken"]!
            ]
        ]

        let dataJson = send.Dict2JsonString(dataDic)
//        print("data Send Json :\(dataJson)")
        print("Json Encode  getRoomType:\(send.jsonEncode(dataJson))")
        send.providerAPI(self.appDelegate.command["listRoom"]!, dataJson: dataJson){
            data in

            print("data(RoomType) : \(data)")
            if(data["roomTypes"]!.count != 0)
            {
      //          print("data(RoomType) :\(data["roomTypes"]![0])")
                print("data(CountRoom) : \(data["roomTypes"]!.count)")
                
                self.roomNameData = data
                self.appDelegate.roomDic = data
                self.tableView.hidden = false
                self.tableView.reloadData()
                
                
                
                print("self.roomNameData.roomTypes")
                print(self.roomNameData["roomTypes"]!)
                print("================================================")
            }
            
            else{
            self.tableView.hidden = true
            
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
        
    }
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let btnObject = UIButton()
//        btnObject.tag = indexPath.row
//        print("edit tag button : \(btnObject.tag)")
//        self.performSegueWithIdentifier("HotelEditCouponVC", sender: btnObject)
//        
        
        //self.performSegueWithIdentifier("HotelEditCouponVC", sender: sender)
        
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("HotelEditCouponVC") as! HotelEditCouponVC
        self.navigationController?.pushViewController(vc, animated:true)
//        self.presentViewController(vc, animated: true, completion: {a in
//        
//        })

    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        appDelegate.roomGalleryIndex = indexPath.row
        //let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! customCouponList
        let cell:customCouponList = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! customCouponList

        //cell.loadData()
//        if let roomName = self.roomNameData["roomTypes"]![indexPath.row]!["room_type_name_en"]! {
//            
//            
//        }else{
//            
//            
//        }
        
        //cell.backgroundColor = UIColor.yellowColor()
        
        cell.lblTitle!.text = "TESTTTTTT"
        cell.lblDiscount!.text = "9,999THB"
        cell.lblExpireDate!.text = "Expire 14/02/2017"
        
        cell.frame.size.width = self.view.frame.size.width - 20
        cell.frame.origin.x = 10
        
        return cell
    }
    func handleTap(sender: AnyObject) {
        var tag = Int()
        if sender.isKindOfClass(UIButton) {
            tag = sender.tag
            
        }else{
            tag = sender.view!.tag
        
        }
        
//        appDelegate.roomIndex = gestureRecognizer.view!.tag
       print("edit tag : \(tag)")
//
//         editView = self.storyboard!.instantiateViewControllerWithIdentifier("editRoom") as! EditRoominfomationVC
//        
//        self.presentViewController(editView, animated: true, completion: nil)
        
        
    }
    
    func deleteTap(gestureRecognizer: UIGestureRecognizer) {
        
        let tag = gestureRecognizer.view!.tag
        
        print("Delete tag button : \(tag)")
        
        let alertView = SCLAlertView()
        alertView.addButton("YES"){
            print("Yessssssssss")
            let send = API_Model()
            let dataDic = [
                "providerInformation" : [
                    "providerId" : self.appDelegate.providerData!["ListProviderInformationSummary"]![self.appDelegate.providerIndex!]["provider_id"]! as! String,
                ],
                //Room
                "roomType":[
                    "roomTypeId": (self.appDelegate.roomDic!["roomTypes"]![tag]!["room_type_id"] as! String)
                ],
                "user" : [
                    "accessToken" : self.appDelegate.userInfo["accessToken"]!
                ]
            ]
            
            let dataJson = send.Dict2JsonString(dataDic)
            
            print("data Send Json :\(dataJson)")
            print("Json Encode :\(send.jsonEncode(dataJson))")
            send.providerAPI(self.appDelegate.command["DeleteRoomType"]!, dataJson: dataJson){
                data in
                print("data(DeleteRoomType) :\(data)")
                
//                let alertViewSuccess = SCLAlertView()
//                alertViewSuccess.showTitle("Delete", subTitle: "Delete Success!", duration: 3.0, completeText: "Done", style: .Success, colorStyle: 0xDB3F42, colorTextButton: 0xffffff )

                let alert = SCLAlertView()
                alert.showCircularIcon = false
                alert.showCloseButton = false
                alert.addButton("Done", action: {action in
                    self.getRoomType()
                })
                alert.showError("Information", subTitle: "Delete Success!")
                
                //back to room list view
//                let vc = self.storyboard?.instantiateViewControllerWithIdentifier("ProviderInfoVC") as! ProviderInfoVC
//                self.appDelegate.pagecontrolIndex = 2
//                self.navigationController?.pushViewController(vc, animated:true)
                
              // self.appDelegate.viewWithTopButtons.hidden = false
              
            }
            
        }
        alertView.showCircularIcon = false
        alertView.showInfo("Delete Room", subTitle: "Are you sure?",closeButtonTitle: "NO",colorStyle:0xAC332F)
        
        
    }

    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        editRoomTag = indexPath.row
        print("aaaaaa")
    }
    func editRoomAction(sender : UIButton){
        print("Edit Room Action")
        
        //self.performSegueWithIdentifier("toEdit", sender: UIButton())

        
        //setTitle("Edit Room",forState: UIControlState.Normal)
        
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
