//
//  MainVC.swift
//  TouchInsightAdmin
//
//  Created by Touch on 11/26/2558 BE.
//  Copyright © 2558 weerapons suwanchatree. All rights reserved.
//

import UIKit
//import PKHUD
import SCLAlertView
import Firebase
import FirebaseCrash
import SVProgressHUD

class MainVC: UIViewController,UINavigationControllerDelegate, UIGestureRecognizerDelegate{
    
//    @IBOutlet var barButton: UIBarButtonItem!
//    @IBOutlet var collectionView: UICollectionView!
//    @IBOutlet weak var imageMenu: UIImageView!
    
    
    //profile info
    @IBOutlet var imgProfile: UIImageView!
    @IBOutlet var lblProfileName: UILabel!
    @IBOutlet var lblEmail: UILabel!
    @IBOutlet weak var btnSetting: UIButton!
    
    @IBOutlet weak var viewDetail: UIView!
    @IBOutlet var imgFooterText: UIImageView!
    
    var loadCount = 0
    var menuList:[String] = ["Business Type","Team","Media","Live Stream"]
    var imageName :[String] = ["ic_provider_list","ic_team","ic_media","ic_livestream"]
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var alertView = SCLAlertView()
    
    @IBOutlet weak var viewUserInfo: UIView!
    @IBOutlet weak var mainScrollView: UIScrollView!
    
    @IBOutlet weak var btnBusiness: UIButton!
    @IBAction func btnBusinessClick(sender: AnyObject) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let _nextView = storyBoard.instantiateViewControllerWithIdentifier("providerlist") as! ProviderListVC
        self.navigationController?.pushViewController(_nextView, animated: true)
        
    }
    
    @IBOutlet weak var btnCoupon: UIButton!
    @IBAction func btnCouponClick(sender: AnyObject) {
   
        let alert = SCLAlertView()
        alert.showCloseButton = false
        alert.showCircularIcon = false
        alert.addButton("OK", action: {action in
            
        })
        alert.showError("Information", subTitle: "Coming Soon!")
        
        
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let _nextView = storyBoard.instantiateViewControllerWithIdentifier("QRScanVC") as! QRScanVC
//        self.navigationController?.pushViewController(_nextView, animated: true)
        
        //QRScanVC
        
    }
    
    
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
    
//    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
//        return false
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getProvince()
        self.getFacility()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        imgProfile.frame.size = CGSizeMake(UIScreen.mainScreen().bounds.size.width/3.5, UIScreen.mainScreen().bounds.size.width/3.5)
        imgProfile.center.x = UIScreen.mainScreen().bounds.size.width/2
        
        imgProfile.layer.masksToBounds = true
        imgProfile.layer.cornerRadius = imgProfile.frame.size.height/2
        
        
        self.viewDetail.frame.size.height = self.view.frame.size.height - self.viewUserInfo.frame.size.height - 20
        
        imgFooterText.frame.origin.x = 0
        imgFooterText.frame.size.width = self.view.frame.size.width
        imgFooterText.frame.size.height = 34
        imgFooterText.frame.origin.y = self.viewDetail.frame.size.height - imgFooterText.frame.size.height// - 12
        
        btnBusiness.center.x = UIScreen.mainScreen().bounds.size.width/2
        btnCoupon.center.x = UIScreen.mainScreen().bounds.size.width/2
        
        btnBusiness.frame.origin.y = 10
        btnCoupon.frame.origin.y = btnBusiness.frame.size.height + btnBusiness.frame.origin.y + 10
        
        
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
        
        print("User Data : \(self.appDelegate.userInfo)")
        print("FirstName : \(self.appDelegate.userInfo["firstName"])")
        print("proFile Name Maon :\(self.appDelegate.userInfo["profileName"])")
        //        let send  = API_Model()
        print(appDelegate.userInfo["userID"]! as String)
        
        
        print("self.appDelegate.userInfo main = \((self.appDelegate.userInfo as Dictionary))")
        
        if(appDelegate.isLogin){
            if let avatar = self.appDelegate.userInfo["avatarImage"] where avatar != "" {
                print("has avatar : \(self.appDelegate.userInfo["avatarImage"])")
                
                //var imgProfile: UIImage? = UIImage(data:NSData(contentsOfURL:NSURL(string:avatar)!)!)
                if let imgData = NSData(contentsOfURL:NSURL(string:avatar )!) as NSData? {
                    self.imgProfile.image = UIImage(data:imgData)
                }else{
                    self.imgProfile.image = UIImage(named: "ic_team.png")
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
        
        let timeIntervalStart = NSDate().timeIntervalSince1970

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
            
                
                let timeIntervalEnded = NSDate().timeIntervalSince1970
                
                print("getProvince -------------------")
                print("timeIntervalStart = \(timeIntervalStart)")
                print("timeIntervalEnded = \(timeIntervalEnded)")
                print("getProvince -------------------")
            
            }
            
        }
        
    }
    
    func getFacility(){
        
        //let timeIntervalStart = NSDate().timeIntervalSince1970
        
        var dataIsLoaded = false
        if let dicData = self.appDelegate.facilityHotelDic as NSDictionary? {
            
            let arrData = dicData["facilities"] as! NSArray
            //print(arrData.count)
            if(arrData.count > 0){
                dataIsLoaded = true
            }
        }
        
        print("dataIsLoaded = \(dataIsLoaded)")
        
        
        if(!dataIsLoaded){
            
            var facilityHotelDic_isLoaded = false
            var facilityRoomDic_isLoaded = false
            var facilityResDic_isLoaded = false
            
            SVProgressHUD.show()
            
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
                
                
                //facilityHotelDic_isLoaded
                //facilityRoomDic_isLoaded
                //facilityResDic_isLoaded
                facilityHotelDic_isLoaded = true
                if (facilityRoomDic_isLoaded && facilityResDic_isLoaded){
                    
                    SVProgressHUD.dismiss()
                
                }
                
                
//                if(self.loadCount == 2){
//                    PKHUD.sharedHUD.hide(animated: true, completion: nil)
//                }
                
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
                self.loadCount += 1
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
                
                
                //facilityHotelDic_isLoaded
                //facilityRoomDic_isLoaded
                //facilityResDic_isLoaded
                facilityRoomDic_isLoaded = true
                if (facilityHotelDic_isLoaded && facilityResDic_isLoaded){
                    SVProgressHUD.dismiss()
                    
                }
                
                
                
//                if(self.loadCount == 2)
//                {
//                    PKHUD.sharedHUD.hide(animated: true, completion: nil)
//                }
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
                
                
                
                //facilityHotelDic_isLoaded
                //facilityRoomDic_isLoaded
                //facilityResDic_isLoaded
                facilityResDic_isLoaded = true
                if (facilityHotelDic_isLoaded && facilityResDic_isLoaded){
                    
                    SVProgressHUD.dismiss()
                    
                }
                
                
//                if(self.loadCount == 2)
//                {
//                    PKHUD.sharedHUD.hide(animated: true, completion: nil)
//                }
                
//                print("Facility restuarant Status :\(self.appDelegate.facilityResStatus.count)")
            }
            
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        //print("before")
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
        
        self.navigationController?.navigationBarHidden = true
    }
    
    override func viewDidAppear(animated: Bool) {
        
//        self.navigationController?.navigationBarHidden = true
        
//        self.navigationController?.setToolbarHidden(true, animated: true)
        //self.navigationController?.navigationController?.setToolbarHidden(true, animated: true)

        
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
        
        if let dicData = self.appDelegate.facilityHotelDic as NSDictionary? {
            let arrData = dicData["facilities"] as! NSArray
            if(arrData.count > 0){
                
                SVProgressHUD.dismiss()
                
            }
        }
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        self.navigationController?.navigationBarHidden = false
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
    
//    func numberOfSectionsInCollectionView(collectionView: UICollectionView)->Int {
//        //#warning Incomplete method implementation -- Return the number of sections
//        return 1
//    }
//    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
//    {
//        return CGSize(width: collectionView.frame.size.width/2 - 1, height: collectionView.frame.size.width/2-20)
//    }
//    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        //#warning Incomplete method implementation -- Return the number of items in the section
//        return self.menuList.count
//    }
//    
//    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) ->UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell",forIndexPath: indexPath) as! MyCollectionViewCell
//        
//        //   let imgsName = "\(imageName)"
//        
//        cell.lblMenu.text = self.menuList[indexPath.item]
//        cell.imgMenu.image = UIImage(named: self.imageName[indexPath.item])
//        
//        return cell
//        
//    }
//    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        
//        if(indexPath.item == 0){
//            
//            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//            let _nextView = storyBoard.instantiateViewControllerWithIdentifier("providerlist") as! ProviderListVC
//            self.navigationController?.pushViewController(_nextView, animated: true)
//            
//            
//            
//            //            performSegueWithIdentifier("loadprovider", sender: self)
//            //let providerlist = self.storyboard?.instantiateViewControllerWithIdentifier("providerlist")
//            // self.navigationController!.pushViewController(providerlist!, animated: true)
//            print("You select Provider menu")
//        } else if (indexPath.item == 1){
//            
//        } else if (indexPath.item == 2){
//            
//        } else if (indexPath.item == 3){
//            
//        }
//        
//    }
    
    @IBAction func btnSettingClick(sender: AnyObject) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let _nextView = storyBoard.instantiateViewControllerWithIdentifier("settingVC") as! SettingAccountVC
        self.navigationController?.pushViewController(_nextView, animated: true)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        print("---------prepareForSegue---------")
        print(segue.identifier)
        if (segue.identifier == "loadprovider") {
            
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
