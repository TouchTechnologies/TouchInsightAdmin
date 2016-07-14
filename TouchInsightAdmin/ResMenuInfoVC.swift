//
//  ResMenuInfoVC.swift
//  TouchInsightAdmin
//
//  Created by Touch on 12/9/2558 BE.
//  Copyright © 2558 weerapons suwanchatree. All rights reserved.
//

import UIKit
import Foundation
import SCLAlertView

class ResMenuInfoVC: UIViewController,UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate {
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
     var editView = EditRoominfomationVC()
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var tableView: UITableView!

    @IBOutlet var noRoomimage: UIImageView!
    @IBOutlet var noRoomTitle: UILabel!
    @IBOutlet var noRoomDesc: UILabel!
    @IBOutlet var noRoomLine: UIImageView!
    
    @IBOutlet var createButton: UIButton!
    var menuNameData:NSDictionary = ["":""]
    var editRoomTag = 0
    
    
    func initial(){
    
    lblTitle.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, 30)
    tableView.frame = CGRectMake(0, 30,UIScreen.mainScreen().bounds.size.width , UIScreen.mainScreen().bounds.size.height)
    createButton.frame = CGRectMake(UIScreen.mainScreen().bounds.size.width - 90, UIScreen.mainScreen().bounds.size.height - 90, 80, 80)
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
        
         self.performSegueWithIdentifier("toCreateMenu", sender: UIButton())

//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let targetVC = storyBoard.instantiateViewControllerWithIdentifier("ResCreateMenuVC") as! ResCreateMenuVC
//        self.navigationController?.pushViewController(targetVC, animated: true)
//        
        print("info add Room")
      
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("menu")
        print("viewDidLoad")
        self.initial()
//        tableView.frame = self.view.frame
        let nib = UINib(nibName: "customMenuList", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "Cell")
        print("Menu Data2 didLoad :\(menuNameData)")
    }
    override func viewDidAppear(animated: Bool) {
//        super.viewDidAppear(true)
        print("viewDidAppear")
        self.getMenuType()
    }
    
    func getMenuType()
    {
        
        print("getMenuType")
        
        let send = API_Model()
        let dataDic = [
            "providerInformation" : [
                "providerId" : appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["provider_id"]! as! String,
                "providerTypeKeyname" : "restaurant"
            ],
            "user" : [
                "accessToken" : appDelegate.userInfo["accessToken"]!
            ]
        ]

        let dataJson = send.Dict2JsonString(dataDic)
//        print("data Send Json :\(dataJson)")
        print("Json Encode  getRoomType:\(send.jsonEncode(dataJson))")
        send.providerAPI(self.appDelegate.command["ListMenu"]!, dataJson: dataJson){
            data in

            print("data(MenuType) : \(data)")
            if(data["menus"]!.count != 0)
            {
                print("data(CountRoom) : \(data["menus"]!.count)")
                
                self.menuNameData = data
                self.appDelegate.menuDic = data
                self.tableView.hidden = false
                self.tableView.reloadData()
                
            }
            
            else{
            self.tableView.hidden = true
            
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let countMenu = self.menuNameData["menus"]
        {
            print("Count Menu : \(countMenu.count)")
            return countMenu.count
        }
        else
        {
            print("else")
            return 0
        }
        
    }
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
//        self.performSegueWithIdentifier("toEditMenu", sender: indexPath)
//        print(" Index Path : \(indexPath.row)")
//
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let targetVC = storyBoard.instantiateViewControllerWithIdentifier("ResEditMenuVC") as! ResEditMenuVC
//        self.navigationController?.pushViewController(targetVC, animated: true)
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        appDelegate.roomGalleryIndex = indexPath.row
        let cell:customMenuListTbl = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! customMenuListTbl
        print("Menuuuuuuuuuu")
        if let roomName = self.menuNameData["menus"]![indexPath.row]!["menu_name_en"]!
        {
            cell.menuNameLbl.text = (roomName as! String)
//            cell.numOfRoom.text = "\(self.menuNameData["menus"]![indexPath.row]["room_type_description_th"] as! String) rooms"
            let gestureEdit = UITapGestureRecognizer(target: self, action: #selector(ResMenuInfoVC.handleTap(_:)))
            gestureEdit.numberOfTouchesRequired = 1
            cell.editBtn.userInteractionEnabled = true
            cell.editBtn.tag = indexPath.row
            cell.editBtn.addGestureRecognizer(gestureEdit)
            
            let gestureDelete = UITapGestureRecognizer(target: self, action: #selector(ResMenuInfoVC.deleteTap(_:)))
            gestureDelete.numberOfTouchesRequired = 1
            cell.deleteBtn.userInteractionEnabled = true
            cell.deleteBtn.tag = indexPath.row
            cell.deleteBtn.addGestureRecognizer(gestureDelete)
            

        }
        else
        {
            cell.menuNameLbl.text = ""
            cell.numOfRoom.text = ""
        }
        
        return cell
    }
    func handleTap(gestureRecognizer: UIGestureRecognizer) {
        
        let tag = gestureRecognizer.view!.tag
//        appDelegate.roomIndex = gestureRecognizer.view!.tag
       print("edit tag button : \(tag)")
//
//         editView = self.storyboard!.instantiateViewControllerWithIdentifier("editRoom") as! EditRoominfomationVC
//        
//        self.presentViewController(editView, animated: true, completion: nil)
        
     self.performSegueWithIdentifier("toEditMenu", sender: gestureRecognizer)
        
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
                SCLAlertView().showTitle("Delete", subTitle: "ลบ Room สำเร็จ", duration: 1.0, completeText: "Done", style: .Success, colorStyle: 0xDB3F42, colorTextButton: 0xffffff )
                
                //self.navigationController?.popViewControllerAnimated(true)
                
                //back to room list view
//                let vc = self.storyboard?.instantiateViewControllerWithIdentifier("providerinfo") as! ProviderInfoVC
//                self.appDelegate.pagecontrolIndex = 2
//                self.navigationController?.pushViewController(vc, animated:true)
                
              // self.appDelegate.viewWithTopButtons.hidden = false
              
            }
            
        }
        alertView.showCircularIcon = false
        alertView.showInfo("Delete", subTitle: "คุณต้องการลบข้อมูล Room ใช่หรือไม่?",closeButtonTitle: "NO",colorStyle:0xAC332F)
        
        
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
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toCreateMenu"{
            
//            appDelegate.roomIndex = sender!.tag
        }else if segue.identifier == "toEditMenu"{
            
            print("Sender : \(sender!.view!.tag)")
            
            appDelegate.menuIndex = sender!.view!.tag
            
//            editView = self.storyboard!.instantiateViewControllerWithIdentifier("editRoom") as! EditRoominfomationVC
//            editView.modalTransitionStyle = .CrossDissolve
//            
//            self.presentViewController(editView, animated: true, completion: nil)
        }
        
        
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
