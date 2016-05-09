//
//  MainVC.swift
//  TouchInsightAdmin
//
//  Created by Touch on 11/26/2558 BE.
//  Copyright © 2558 weerapons suwanchatree. All rights reserved.
//

import UIKit
import PKHUD
class MainVC: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate,UINavigationControllerDelegate{

    @IBOutlet var barButton: UIBarButtonItem!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet weak var imageMenu: UIImageView!
    
    //profile info
    @IBOutlet var imgProfile: UIImageView!
    @IBOutlet var lblProfileName: UILabel!
    @IBOutlet var lblEmail: UILabel!
    
    var loadCount = 0
    var menuList:[String] = ["Provider List","Team","Media","Live Stream"]
    var imageName :[String] = ["ic_provider_list","ic_team","ic_media","ic_livestream"]
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
   


    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate.isLogin = true
        PKHUD.sharedHUD.dimsBackground = false
        PKHUD.sharedHUD.userInteractionOnUnderlyingViewsEnabled = false
        PKHUD.sharedHUD.contentView = PKHUDProgressView()
        PKHUD.sharedHUD.show()
        
        self.getProvince()
        self.getFacility()
        
        
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        imgProfile.frame.size = CGSizeMake(UIScreen.mainScreen().bounds.size.width/3.5, UIScreen.mainScreen().bounds.size.width/3.5)
        imgProfile.center.x = UIScreen.mainScreen().bounds.size.width/2

        imgProfile.layer.masksToBounds = true
        imgProfile.layer.cornerRadius = imgProfile.frame.size.height/2
        
    
        if let avatar = self.appDelegate.userInfo["avatarImage"] {
            print("has avatar : \(self.appDelegate.userInfo["avatarImage"])")
            imgProfile.image = UIImage(data:NSData(contentsOfURL:NSURL(string:avatar)!)!)
        }else
        {
            print("no avatar")
            imgProfile.image = UIImage(named: "ic_team.png")
        }
        
        
        print("FirstName : \(self.appDelegate.userInfo["firstName"])")
        print("proFile Name Maon :\(self.appDelegate.userInfo["profileName"])")
     
    }
    func getProvince(){
        let send = API_Model()
        send.providerAPI(appDelegate.command["listProvince"]!, dataJson: "{}"){
            data in
            if(self.loadCount == 1)
            {
                PKHUD.sharedHUD.hide(afterDelay: 0.1)
            }
            self.loadCount += 1
            print("=====================================================================================")
            //print("Province Data : \(data["ListProvince"]![0])")
            print("All Province data :\(data)")
            
            print("=====================================================================================")
            self.appDelegate.provinceDic = data
            for index in 0...self.appDelegate.provinceDic!["ListProvince"]!.count - 1
            {

//                print("index :\(index)")
//                print("Province Name ===== \(self.appDelegate.provinceDic!["ListProvince"]![index]["province_name_th"] as! String)")
//                print("Province ID ===== \(self.appDelegate.provinceDic!["ListProvince"]![index]["id_province"] as! String)")
                
                self.appDelegate.provinceID.append(self.appDelegate.provinceDic!["ListProvince"]![index]["id_province"] as! String)
                self.appDelegate.provinceName.append(self.appDelegate.provinceDic!["ListProvince"]![index]["province_name_en"] as! String)
                
            }
            print("Count: \(self.appDelegate.provinceDic!["ListProvince"]!.count)")
            
            print("ProvinceName :\(self.appDelegate.provinceName)")
        }
    }
    func getFacility()
    {
        let send = API_Model()
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
        print("dataJson(Facility) : \(dataHotelJson)")
        send.providerAPI(appDelegate.command["ListHotelFacility"]!, dataJson: dataHotelJson){
            data in
            if(self.loadCount == 1)
            {
                PKHUD.sharedHUD.hide(afterDelay: 0.1)
            }
            self.loadCount += 1
            self.appDelegate.facilityHotelDic = data
            print("=====================================================================================")
//            print("Data Facility :\(data)")
            print("facility(Hotel) : \(self.appDelegate.facilityHotelDic!["facilities"]! as! NSArray)")
            print("Hotel(Count) : \(self.appDelegate.facilityHotelDic!["facilities"]!.count as Int)")
            print("=====================================================================================")
            for _ in 0...self.appDelegate.facilityHotelDic!["facilities"]!.count - 1
            {
                self.appDelegate.facilityHotelStatus.append(false)
            }
            
            print("Facility Hotel Status :\(self.appDelegate.facilityHotelStatus.count)")
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
        print("dataJson(Facility) : \(dataRoomJson)")
        send.providerAPI(appDelegate.command["ListRoomFacility"]!, dataJson: dataRoomJson){
            data in
            self.appDelegate.facilityRoomDic = data
            print("=====================================================================================")
            print("Data Facility(Room) :\(data)")
            print("facility(room) : \(self.appDelegate.facilityRoomDic!["roomTypeFacilities"]! as! NSArray)")
            print("Room(Count) : \(self.appDelegate.facilityRoomDic!["roomTypeFacilities"]!.count as Int)")
            print("=====================================================================================")
            for _ in 0...self.appDelegate.facilityRoomDic!["roomTypeFacilities"]!.count - 1
            {
                self.appDelegate.facilityRoomStatus.append(false)
            }
            
            print("Facility Room Status :\(self.appDelegate.facilityRoomStatus.count)")
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        appDelegate.isLogin = true
        print("before")
        
       
//        let send  = API_Model()
        print(appDelegate.userInfo["userID"]! as String)
        
        if(appDelegate.isLogin){
            if let avatar = self.appDelegate.userInfo["avatarImage"] {
                print("has avatar : \(self.appDelegate.userInfo["avatarImage"])")
                imgProfile.image = UIImage(data:NSData(contentsOfURL:NSURL(string:avatar)!)!)
            }else
            {
                print("no avatar")
                imgProfile.image = UIImage(named: "ic_team.png")
            }
            
            self.lblProfileName.text = appDelegate.userInfo["profileName"]
            self.lblEmail.text = appDelegate.userInfo["email"]
        
        }
        
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
      performSegueWithIdentifier("loadprovider", sender: self)
        //let providerlist = self.storyboard?.instantiateViewControllerWithIdentifier("providerlist")
       // self.navigationController!.pushViewController(providerlist!, animated: true)
        print("You select Provider menu")
    }
    else if (indexPath.item == 1){
    
    }
    else if (indexPath.item == 2){
    
    }
    else if (indexPath.item == 3){
    
    }


}
override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
   if (segue.identifier == "loadprovider") {
    PKHUD.sharedHUD.dimsBackground = false
    PKHUD.sharedHUD.userInteractionOnUnderlyingViewsEnabled = false
    PKHUD.sharedHUD.contentView = PKHUDProgressView()
    PKHUD.sharedHUD.show()
    
            let nav = segue.destinationViewController as! UINavigationController
            let providerlist = self.storyboard?.instantiateViewControllerWithIdentifier("providerlist")
            nav.pushViewController(providerlist!, animated: true)
            
            // pass data to next view
        }
 
    }

   /* func collectionView(collectionView: UICollectionView!,
        layout collectionViewLayout: UICollectionViewLayout!,
        insetForSectionAtIndex section: Int) -&gt; UIEdgeInsets {
    return sectionInsets
    }*/
}
