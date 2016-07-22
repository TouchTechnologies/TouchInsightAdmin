//
//  MainVC.swift
//  TouchInsightAdmin
//
//  Created by Touch on 11/26/2558 BE.
//  Copyright © 2558 weerapons suwanchatree. All rights reserved.
//

import UIKit
import PKHUD
import SCLAlertView

class MainVC: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate,UINavigationControllerDelegate{
    
    @IBOutlet var barButton: UIBarButtonItem!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet weak var imageMenu: UIImageView!
    
    //profile info
    @IBOutlet var imgProfile: UIImageView!
    @IBOutlet var lblProfileName: UILabel!
    @IBOutlet var lblEmail: UILabel!
    
    var loadCount = 0
    var menuList:[String] = ["Business Type","Team","Media","Live Stream"]
    var imageName :[String] = ["ic_provider_list","ic_team","ic_media","ic_livestream"]
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var alertView = SCLAlertView()
    
    @IBOutlet weak var viewUserInfo: UIView!
    @IBOutlet weak var mainScrollView: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        PKHUD.sharedHUD.dimsBackground = true
        //        PKHUD.sharedHUD.userInteractionOnUnderlyingViewsEnabled = false
        //        PKHUD.sharedHUD.contentView = PKHUDProgressView()
        //        PKHUD.sharedHUD.show()
        
        self.getProvince()
        self.getFacility()
        
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        imgProfile.frame.size = CGSizeMake(UIScreen.mainScreen().bounds.size.width/3.5, UIScreen.mainScreen().bounds.size.width/3.5)
        imgProfile.center.x = UIScreen.mainScreen().bounds.size.width/2
        
        imgProfile.layer.masksToBounds = true
        imgProfile.layer.cornerRadius = imgProfile.frame.size.height/2
        
        
        //        if let avatar = self.appDelegate.userInfo["avatarImage"] {
        //            print("has avatar : \(self.appDelegate.userInfo["avatarImage"])")
        //            dispatch_async(dispatch_get_main_queue()) {
        //                
        //                self.imgProfile.image = UIImage(data:NSData(contentsOfURL:NSURL(string:avatar)!)!)
        //            }
        //            
        //        }else{
        //            print("no avatar")
        //            imgProfile.image = UIImage(named: "ic_team.png")
        //        }
        
        
        print("FirstName : \(self.appDelegate.userInfo["firstName"])")
        print("proFile Name Maon :\(self.appDelegate.userInfo["profileName"])")
        //        let send  = API_Model()
        print(appDelegate.userInfo["userID"]! as String)
        
        if(appDelegate.isLogin){
            if let avatar = self.appDelegate.userInfo["avatarImage"] where avatar != "" {
                print("has avatar : \(self.appDelegate.userInfo["avatarImage"])")
                dispatch_async(dispatch_get_main_queue()) {
                    //                    var imgProfile: UIImage? = UIImage(data:NSData(contentsOfURL:NSURL(string:avatar)!)!)
                    //                    if imgProfile == nil {
                    //                        imgProfile = UIImage(named: "ic_team.png")
                    //                    }
                    var imgProfile = UIImage()
                    if let _img = UIImage(data:NSData(contentsOfURL:NSURL(string:avatar)!)!) {
                        imgProfile = _img
                    }else{
                        imgProfile = UIImage(named: "ic_team.png")!
                    }
                    
                    UIView.animateWithDuration(1.0, animations: {
                        self.imgProfile.image = imgProfile
                    })
                }
                
            }else{
                print("no avatar")
                imgProfile.image = UIImage(named: "ic_team.png")
            }
            
            self.lblProfileName.text = appDelegate.userInfo["profileName"]
            self.lblEmail.text = appDelegate.userInfo["email"]
            
        }
        
        
        
        
        //        let device = DeviceDetail()
        //        print(device)     // prints for example "iPhone 6 Plus"
        //        if device == .iPhone4 || device == .iPhone4s {
        //            print("OK iPhone4s")
        //            // Do something
        //        } else {
        //            // Do something else
        //            print("OK i'm not iPhone4s")
        //        }
        
        
        let deviceH = self.view.bounds.height
        print("deviceH = \(deviceH)")
        if deviceH <= 480.0 {
            //            self.viewUserInfo.frame.size.height = 180.0
            //            self.mainScrollView.contentSize = CGSizeMake(self.view.frame.width, 667)
        }
    }
    
    
    func getProvince(){
        
        var dataIsLoaded = false
        if let dicData = self.appDelegate.provinceDic as NSDictionary? {
            
            let arrData = dicData["ListProvince"] as! NSArray
            //            print(arrData.count)
            if(arrData.count > 0){
                dataIsLoaded = true
            }
        }
        
        if(!dataIsLoaded){
            
            let send = API_Model()
            send.providerAPI(appDelegate.command["listProvince"]!, dataJson: "{}"){
                data in
                if(self.loadCount == 1){
                    //PKHUD.sharedHUD.hide(animated: true, completion: nil)
                }
                self.loadCount += 1
                //                print("=====================================================================================")
                //                //print("Province Data : \(data["ListProvince"]![0])")
                //                print("All Province data :\(data)")
                //                
                //                print("=====================================================================================")
                
                
                self.appDelegate.provinceDic = data
                for index in 0...self.appDelegate.provinceDic!["ListProvince"]!.count - 1{
                    
                    //                print("index :\(index)")
                    //                print("Province Name ===== \(self.appDelegate.provinceDic!["ListProvince"]![index]["province_name_th"] as! String)")
                    //                print("Province ID ===== \(self.appDelegate.provinceDic!["ListProvince"]![index]["id_province"] as! String)")
                    
                    self.appDelegate.provinceID.append(self.appDelegate.provinceDic!["ListProvince"]![index]["id_province"] as! String)
                    self.appDelegate.provinceName.append(self.appDelegate.provinceDic!["ListProvince"]![index]["province_name_en"] as! String)
                    
                }
                //                print("Count: \(self.appDelegate.provinceDic!["ListProvince"]!.count)")
                //                
                //                print("ProvinceName :\(self.appDelegate.provinceName)")
            
                
            
            }
            
        }
        
    }
    
    func getFacility(){
        PKHUD.sharedHUD.dimsBackground = false
        PKHUD.sharedHUD.userInteractionOnUnderlyingViewsEnabled = false
        
        //PKHUD.sharedHUD.contentView = PKHUDStatusView(title: "Loading", subtitle: "Subtitle", image: nil)
        PKHUD.sharedHUD.contentView = PKHUDProgressView()
        PKHUD.sharedHUD.show()
        
        var dataIsLoaded = false
        if let dicData = self.appDelegate.facilityHotelDic as NSDictionary? {
            
            let arrData = dicData["facilities"] as! NSArray
            //print(arrData.count)
            if(arrData.count > 0){
                dataIsLoaded = true
            }
        }
        
        
        if(!dataIsLoaded){
            
            
            let send = API_Model()
            
            /////////////////////// HOTEL /////////////////////////////////////
            let dataHotelDic =
                [
                    "providerInformation" : [
                        "providerTypeKeyname" : "hotel",
                    ],
                    "user" : [
                        "accessToken" : self.appDelegate.userInfo["accessToken"]!
                    ]
            ]
            
            let dataHotelJson = send.Dict2JsonString(dataHotelDic)
            //            print("dataJson:Hotel(Facility) : \(dataHotelJson)")
            send.providerAPI(appDelegate.command["ListFacility"]!, dataJson: dataHotelJson){
                data in
                
                self.loadCount += 1
                self.appDelegate.facilityHotelDic = data
                
                print("========== Data Facility hotel ==========")
                print(send.Dict2JsonString(data as! [String : AnyObject]))
                print("---------- Data Facility hotel ----------")
                
                
//                print("=====================================================================================")
//                //            print("Data Facility :\(data)")
//                print("facility(Hotel) : \(self.appDelegate.facilityHotelDic!["facilities"]! as! NSArray)")
//                print("Hotel(Count) : \(self.appDelegate.facilityHotelDic!["facilities"]!.count as Int)")
//                print("=====================================================================================")
                for _ in 0...self.appDelegate.facilityHotelDic!["facilities"]!.count - 1{
                    self.appDelegate.facilityHotelStatus.append(false)
                }
                if(self.loadCount == 2){
                    PKHUD.sharedHUD.hide(animated: true, completion: nil)
                }
                
//                print("Facility Hotel Status :\(self.appDelegate.facilityHotelStatus.count)")
            }
            
            let dataRoomDic =
                [
                    "providerInformation" : [
                        "providerTypeKeyname" : "hotel",
                    ],
                    "user" : [
                        "accessToken" : self.appDelegate.userInfo["accessToken"]!
                    ]
            ]
            
            
            let dataRoomJson = send.Dict2JsonString(dataRoomDic)
//            print("dataJson(Facility) : \(dataRoomJson)")
            send.providerAPI(appDelegate.command["ListRoomFacility"]!, dataJson: dataRoomJson){
                data in
                
                self.appDelegate.facilityRoomDic = data
                
                print("========== Data Facility hotel room ==========")
                print(send.Dict2JsonString(data as! [String : AnyObject]))
                print("---------- Data Facility hotel room ----------")
                
//                print("=====================================================================================")
//                print("Data Facility(Room) :\(data)")
//                print("facility(room) : \(self.appDelegate.facilityRoomDic!["roomTypeFacilities"]! as! NSArray)")
//                print("Room(Count) : \(self.appDelegate.facilityRoomDic!["roomTypeFacilities"]!.count as Int)")
//                print("=====================================================================================")
                for _ in 0...self.appDelegate.facilityRoomDic!["roomTypeFacilities"]!.count - 1
                {
                    self.appDelegate.facilityRoomStatus.append(false)
                }
                if(self.loadCount == 2)
                {
                    PKHUD.sharedHUD.hide(animated: true, completion: nil)
                }
//                print("Facility Room Status :\(self.appDelegate.facilityRoomStatus.count)")
            }
            
            
            /////////////////////// Restuarant /////////////////////////////////////
            let dataResDic =
                [
                    "providerInformation" : [
                        "providerTypeKeyname" : "restaurant",
                    ],
                    "user" : [
                        "accessToken" : self.appDelegate.userInfo["accessToken"]!
                    ]
            ]
            
            let dataResJson = send.Dict2JsonString(dataResDic)
//            print("dataJson:Restuarant(Facility) : \(dataResDic)")
            send.providerAPI(appDelegate.command["ListFacility"]!, dataJson: dataResJson){
                data in
                
                self.loadCount += 1
                self.appDelegate.facilityResDic = data
                
                print("========== Data Facility restaurant ==========")
                print(send.Dict2JsonString(data as! [String : AnyObject]))
                print("---------- Data Facility restaurant ----------")
                
//                print("=====================================================================================")
//                //                print("Data restuarant Facility :\(data)")
//                print("facility(restuarant) : \(self.appDelegate.facilityResDic!["facilities"]! as! NSArray)")
//                print("Hotel(Count) : \(self.appDelegate.facilityResDic!["facilities"]!.count as Int)")
//                print("=====================================================================================")
                for _ in 0...self.appDelegate.facilityResDic!["facilities"]!.count - 1
                {
                    self.appDelegate.facilityResStatus.append(false)
                }
                if(self.loadCount == 2)
                {
                    PKHUD.sharedHUD.hide(animated: true, completion: nil)
                }
                
//                print("Facility restuarant Status :\(self.appDelegate.facilityResStatus.count)")
            }
            
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        print("before")
        //        self.navigationController?.navigationController?.navigationBarHidden = true
        
        
        
        
        //        send.getUserInfo(appDelegate.userInfo["userID"]! as String)
        //            {
        //                data in
        //                print("data : \(data)")
        //                self.lblProfileName.text = (data["profileName"] as! String)
        //                self.lblEmail.text = (data["email"] as! String)
        //
        //                let dataJson = "{\"providerUser\":\"\(data["email"]!)\"}"
        //                //print("appDelegate :\(appDelegate.userInfo["email"])")
        //                print("dataSendJson : \(dataJson)")
        //                send.providerAPI(self.appDelegate.command["listProvider"]!, dataJson: dataJson){
        //                    data in
        //
        //                    print("listProvider :\(data["ListProviderInformationSummary"]!)")
        //                    self.appDelegate.providerData = data
        //                    print("Count: \(self.appDelegate.providerData!["ListProviderInformationSummary"]!.count)")
        //
        //                }
        //
        //        }
        
        //        let dataJson = "{\"providerUser\":\"\(appDelegate.userInfo["email"]!)\"}"
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        //        if appDelegate.isDisplayLoginSuccess != true {
        //            appDelegate.isDisplayLoginSuccess = true
        //            
        //            let titleMessage = "Login Success"
        //            let message = "ยินดีต้อนรับเข้าสู่ระบบ"
        //            
        //            alertView.showCircularIcon = false
        //            self.alertView.showTitle(titleMessage, subTitle: message, style: SCLAlertViewStyle.Success, closeButtonTitle: "OK" , duration: 5.0, colorStyle: 0xAC332F, colorTextButton: 0xFFFFFF)
        //            
        //            
        //            print("appDelegate.isDisplayLoginSuccess = true")
        //        }
        
        
    }
    
    override func viewWillDisappear(animated: Bool) {
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
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView)->Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        return CGSize(width: collectionView.frame.size.width/2 - 1, height: collectionView.frame.size.width/2-20)
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return self.menuList.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) ->UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell",forIndexPath: indexPath) as! MyCollectionViewCell
        
        //   let imgsName = "\(imageName)"
        
        cell.lblMenu.text = self.menuList[indexPath.item]
        cell.imgMenu.image = UIImage(named: self.imageName[indexPath.item])
        
        return cell
        
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        if(indexPath.item == 0){
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let _nextView = storyBoard.instantiateViewControllerWithIdentifier("providerlist") as! ProviderListVC
            self.navigationController?.pushViewController(_nextView, animated: true)
            
            
            
            //            performSegueWithIdentifier("loadprovider", sender: self)
            //let providerlist = self.storyboard?.instantiateViewControllerWithIdentifier("providerlist")
            // self.navigationController!.pushViewController(providerlist!, animated: true)
            print("You select Provider menu")
        } else if (indexPath.item == 1){
            
        } else if (indexPath.item == 2){
            
        } else if (indexPath.item == 3){
            
        }
        
    }
    
    @IBAction func btnSettingClick(sender: AnyObject) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let _nextView = storyBoard.instantiateViewControllerWithIdentifier("settingVC") as! SettingAccountVC
        self.navigationController?.pushViewController(_nextView, animated: true)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        print("---------prepareForSegue---------")
        print(segue.identifier)
        if (segue.identifier == "loadprovider") {
            //            PKHUD.sharedHUD.dimsBackground = false
            //            PKHUD.sharedHUD.userInteractionOnUnderlyingViewsEnabled = false
            //            PKHUD.sharedHUD.contentView = PKHUDProgressView()
            //            PKHUD.sharedHUD.show()
            
            //            let nav = segue.destinationViewController as! UINavigationController
            //            let providerlist = self.storyboard?.instantiateViewControllerWithIdentifier("providerlist")
            ////            nav.pushViewController(providerlist!, animated: true)
            //            self.navigationController?.pushViewController(providerlist!, animated: true)
            //            
            
            
            
            
            //            let mainView = self.storyboard?.instantiateViewControllerWithIdentifier("MainVC")
            //            self.navigationController?.pushViewController(mainView!, animated: true)
            
            
            
            // pass data to next view
        }
        
    }
    
    /* func collectionView(collectionView: UICollectionView!,
     layout collectionViewLayout: UICollectionViewLayout!,
     insetForSectionAtIndex section: Int) -&gt; UIEdgeInsets {
     return sectionInsets
     }*/
}
