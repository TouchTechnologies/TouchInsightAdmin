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
    //var roomNameData:NSDictionary = ["":""]
    var editRoomTag = 0
    
    
    func initial(){
        
        //tableView.frame = CGRectMake(0, 0,UIScreen.mainScreen().bounds.size.width , UIScreen.mainScreen().bounds.size.height)
        //createButton.frame = CGRectMake(UIScreen.mainScreen().bounds.size.width - 90, UIScreen.mainScreen().bounds.size.height - 90, 64, 64)
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
    
    
    var dicProvider = NSDictionary()
    var imgIconTypeKey = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("room")
        print("viewDidLoad")
        self.initial()
        //tableView.frame = self.view.frame
        let nib = UINib(nibName: "customCouponList", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "Cell")
        
        
        guard let objProvider = appDelegate.providerData!["ListProviderInformationSummary"]! as? NSArray else {
            print("no objProvider")
            return
        }
        
        guard let objProviderDic = objProvider[appDelegate.providerIndex!] as? NSDictionary else {
            print("no objProviderDic")
            return
        }
        
        dicProvider = objProviderDic
        
        
        print("dicProvider")
        print("dicProvider")
        print("dicProvider")
        print(dicProvider)
        print("-----------------------------------------")
        print("-----------------------------------------")
        print("-----------------------------------------")
        
        
        switch String(dicProvider["provider_type_keyname"]!) {
        case "hotel":
            imgIconTypeKey = UIImage(named: "ic_hotel_hover.png")!
            break
        case "restaurant":
            imgIconTypeKey = UIImage(named: "ic_restaurant_hover.png")!
            break
        case "attraction":
            imgIconTypeKey = UIImage(named: "ic_attraction_hover.png")!
            break
        default :
            break
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
//        super.viewDidAppear(true)
        print("viewDidAppear")
        self.fetchData()
    }
    
    var dataLists = [[String:AnyObject]]()
    func fetchData(){
        
        guard let objProvider = appDelegate.providerData!["ListProviderInformationSummary"]! as? NSArray else {
            print("no objProvider")
            return
        }
        
        guard let objProviderDic = objProvider[appDelegate.providerIndex!] as? NSDictionary else {
            print("no objProviderDic")
            return
        }
        
        let provider_id = objProviderDic["provider_id"]! as! String
        
        let send = API_Model()
        send.getCoupon(provider_id, completionHandler:{data in
            if let objData:[[String:AnyObject]] = data {
                if objData.count > 0 {
                    self.tableView.hidden = false
                }else{
                    self.tableView.hidden = true
                }
                self.dataLists = objData
            }else{
                self.tableView.hidden = true
                self.dataLists = [[String:AnyObject]]()
            }
            print("======================= getCoupon =========================")
            print(self.dataLists)
            print("===========================================================")
            
            self.tableView.reloadData()
            
        })
        
        
        
        
        
        
//        let dataDic = [
//            "providerInformation" : [
//                "providerId" : appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["provider_id"]! as! String,
//                "providerTypeKeyname" : "hotel"
//            ],
//            "user" : [
//                "accessToken" : appDelegate.userInfo["accessToken"]!
//            ]
//        ]
//        let dataJson = send.Dict2JsonString(dataDic)
////        print("data Send Json :\(dataJson)")
//        print("Json Encode  fetchData:\(send.jsonEncode(dataJson))")
//        send.providerAPI(self.appDelegate.command["listRoom"]!, dataJson: dataJson){
//            data in
//
//            print("data(RoomType) : \(data)")
//            if(data["roomTypes"]!.count != 0)
//            {
//      //          print("data(RoomType) :\(data["roomTypes"]![0])")
//                print("data(CountRoom) : \(data["roomTypes"]!.count)")
//                
//                self.roomNameData = data
//                self.appDelegate.roomDic = data
//                self.tableView.hidden = false
//                self.tableView.reloadData()
//                
//                print("self.roomNameData.roomTypes")
//                print(self.roomNameData["roomTypes"]!)
//                print("================================================")
//            }else{
//                self.tableView.hidden = true
//            
//            }
//        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataLists.count
        
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
        appDelegate.couponIndex = indexPath.row
        //let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! customCouponList
        let cell:customCouponList = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! customCouponList
        
        cell.imgIconTitle.contentMode = .ScaleAspectFit
        cell.imgIconTitle.backgroundColor = UIColor.clearColor()
        
        if let objProvider = dataLists[appDelegate.couponIndex!] as Dictionary? {
            
            let discount = String(objProvider["coupongroupType"]!) == "percent" ? "\(String(objProvider["coupongroupValue"]!))%" : "\(String(objProvider["coupongroupValue"]!)) ฿"
            
            cell.lblTitle!.text = String(objProvider["coupongroupNameEn"]!)
            cell.lblDiscount!.text = discount
            cell.lblExpireDate!.text = String(objProvider["endPromotionDate"]!)
            cell.lblUsed!.text = ""
            
            cell.imgIconTitle.image = imgIconTypeKey
            print("objProvider")
            print(objProvider)
            print("-----------")
            
        }else{
            
            cell.lblTitle!.text = ""
            cell.lblDiscount!.text = ""
            cell.lblExpireDate!.text = ""
            cell.lblUsed!.text = ""
            
        }
        
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
                    self.fetchData()
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
