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
    var editMenuTag = 0
    
    
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
        
        let btnObject = UIButton()
        btnObject.tag = indexPath.row
        print("edit tag button : \(btnObject.tag)")
        self.performSegueWithIdentifier("toEditMenu", sender: btnObject)
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        appDelegate.roomGalleryIndex = indexPath.row
        let cell:customMenuListTbl = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! customMenuListTbl
        print("Menuuuuuuuuuu")
        print(self.menuNameData["menus"]![indexPath.row]!)
        
        let gestureDelete = UITapGestureRecognizer(target: self, action: #selector(ResMenuInfoVC.deleteTap(_:)))
        gestureDelete.numberOfTouchesRequired = 1
        cell.deleteBtn.userInteractionEnabled = true
        cell.deleteBtn.tag = indexPath.row
        cell.deleteBtn.addGestureRecognizer(gestureDelete)
        
        if let roomName = self.menuNameData["menus"]![indexPath.row]!["menu_name_en"]!
        {
            cell.menuNameLbl.text = (roomName as! String)
            
        }else{
            cell.menuNameLbl.text = ""
        }
        
        if let menu_price = self.menuNameData["menus"]![indexPath.row]!["menu_price"]!{
            cell.lblPrice.text = menu_price as? String
            
        }else{
            cell.lblPrice.text = "..."
        
        }
        
        if let spicy_level = self.menuNameData["menus"]![indexPath.row]!["spicy_level"]! as? String{
            switch spicy_level {
            case "0","mild":
                cell.imgLevel.image = UIImage(named: "mild_hover.png")
                cell.lblLevel.text = "Mild"
            case "1","middle":
                cell.imgLevel.image = UIImage(named: "middle_hover.png")
                cell.lblLevel.text = "Middle"
            case "2","hot":
                cell.imgLevel.image = UIImage(named: "hot_hover.png")
                cell.lblLevel.text = "Hot"
            default:
                cell.imgLevel.image = UIImage(named: "mild.png")
                cell.lblLevel.text = "Mild"
            }
        }else{
            cell.imgLevel.image = UIImage(named: "mild.png")
        }
        
        if let logo_image = self.menuNameData["menus"]![indexPath.row]!["images"]!!["logo_image"]!!["extra-small"] as? String{
            cell.imgLogo.hnk_setImageFromURL(NSURL(string: logo_image)!)
            
        }else{
            cell.imgLogo.image = UIImage(named: "ic_no_image.png")
            
        }
        
        
        //
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
                //Menu
                "menu":[
                    "menuId": (self.appDelegate.menuDic!["menus"]![tag]!["menu_id"] as! String)
                ],
                "user" : [
                    "accessToken" : self.appDelegate.userInfo["accessToken"]!
                ]
            ]
            
            let dataJson = send.Dict2JsonString(dataDic)
            
            print("data Send Json :\(dataJson)")
            print("Json Encode :\(send.jsonEncode(dataJson))")
            send.providerAPI(self.appDelegate.command["DeleteMenu"]!, dataJson: dataJson){
                data in
                print("data(DeleteRoomType) :\(data)")
                SCLAlertView().showTitle("Delete", subTitle: "ลบ Menu สำเร็จ", duration: 1.0, completeText: "Done", style: .Success, colorStyle: 0xDB3F42, colorTextButton: 0xffffff )
                self.navigationController?.popViewControllerAnimated(true)
//                self.tableView.reloadData()
              
            }
            
        }
        alertView.showCircularIcon = false
        alertView.showInfo("Delete", subTitle: "คุณต้องการลบข้อมูล Menu ใช่หรือไม่?",closeButtonTitle: "NO",colorStyle:0xAC332F)
        
        
    }

    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        editMenuTag = indexPath.row
        print("aaaaaa")
    }
    func editRoomAction(sender : UIButton){
        print("Edit Menu Action")
        
        //self.performSegueWithIdentifier("toEdit", sender: UIButton())

        
        //setTitle("Edit Room",forState: UIControlState.Normal)
        
    
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toCreateMenu"{
            
//            appDelegate.roomIndex = sender!.tag
        }else if segue.identifier == "toEditMenu"{
            var _tag = 0
            if sender?.classForCoder == UIButton.self {
                _tag = sender!.tag
            }else{
                _tag = sender!.view!.tag
            }
            
            print("Sender_tag: \(_tag)")
            
//            appDelegate.menuIndex = sender!.view!.tag
            appDelegate.menuIndex = _tag
            
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
