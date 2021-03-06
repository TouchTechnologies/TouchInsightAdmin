//
//  ResCreateMenuVC.swift
//  TouchInsightAdmin
//
//  Created by Touch on 12/9/2558 BE.
//  Copyright © 2558 weerapons suwanchatree. All rights reserved.
//

import UIKit
import SCLAlertView
import PKHUD


class ResCreateMenuVC: UIViewController,UITextFieldDelegate,UIScrollViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIGestureRecognizerDelegate,CustomIOS7AlertViewDelegate {
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let send = API_Model()
    @IBOutlet weak var scrollView: UIScrollView!
//    @IBOutlet var collectionView: UICollectionView!
//    @IBOutlet var facilityView: UIView!
    @IBOutlet var addButton: UIButton!
    
    var facilitiesRoomAttached = [String]()
    
    @IBOutlet weak var menuNameTxt: UITextField!
    @IBOutlet weak var shotDescTxt: UITextView!
    @IBOutlet weak var priceTxt: UITextField!
//    @IBOutlet weak var numOfRoomTxt: UITextField!
//    @IBOutlet weak var bedTxt: UITextField!
//    @IBOutlet weak var maxOccupTxt: UITextField!
//    @IBOutlet weak var tableView: UITableView!
    var navunderlive = UIView()
    var width = CGFloat()
    var heigth = CGFloat()
    var occupencyNum = Int32()
//    var roomImageUpload = [UIImage()]
//    var roomGallery = [UIImage()]
    
//    var Cell = RoomGalleryCell()
    
    
    @IBOutlet var imgMenuLogo: UIImageView!
    var imageDataForUpload = [UIImage()]
    var imageNameForUpload:String?
    
    
    
    // Spicy Level
    
    @IBOutlet weak var viewSplMild: UIView!
    @IBOutlet weak var viewSplMiddle: UIView!
    @IBOutlet weak var viewSplHot: UIView!
    
    
//    var selectedSpicyLevel = [
//        "mild":"1",
//        "middle":"0",
//        "hot":"0",
//        ]
    @IBOutlet weak var img_mild: UIImageView!
    @IBOutlet weak var img_middle: UIImageView!
    @IBOutlet weak var img_hot: UIImageView!
    var strSpiciLevel = ""
    @IBAction func btn_mild_click(sender: AnyObject) {
        
        strSpiciLevel = "0"
        img_mild.image = UIImage(named: "mild_hover.png")
        img_middle.image = UIImage(named: "middle.png")
        img_hot.image = UIImage(named: "hot.png")
        
        displaySelectedData()
    }
    
    @IBAction func btn_middle_click(sender: AnyObject) {
        
        strSpiciLevel = "1"
        
        img_mild.image = UIImage(named: "mild.png")
        img_middle.image = UIImage(named: "middle_hover.png")
        img_hot.image = UIImage(named: "hot.png")
        
        displaySelectedData()
    }
    
    @IBAction func btn_hot_click(sender: AnyObject) {
        
        strSpiciLevel = "2"
        
        img_mild.image = UIImage(named: "mild.png")
        img_middle.image = UIImage(named: "middle.png")
        img_hot.image = UIImage(named: "hot_hover.png")
        
        displaySelectedData()
    }
    
    func displaySelectedData() {
        print(strSpiciLevel)
    }
    
    
    
    
    
    
    func imageTapped(img: AnyObject){
        print("Upload Cover Img")
        
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(myPickerController, animated: true, completion: nil)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        
        print("viewWillAppear")
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        width = UIScreen.mainScreen().bounds.size.width
        heigth = UIScreen.mainScreen().bounds.size.height
//        let contentscrollheight = self.scrollView.layer.bounds.size.height
//        scrollView.contentSize = CGSizeMake(width,contentscrollheight+300);
        self.appDelegate.viewWithTopButtons.hidden = true
        
        let ggTapImage: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ResCreateMenuVC.imageTapped(_:)))
        ggTapImage.delegate = self
        ggTapImage.cancelsTouchesInView = false
        imgMenuLogo.userInteractionEnabled = true
        self.imgMenuLogo!.addGestureRecognizer(ggTapImage)
        self.scrollView.addSubview(imgMenuLogo)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = false
        self.initialSize()
        
        print("viewDidLoad")
        
        menuNameTxt.delegate = self
        priceTxt.delegate = self
//        bedTxt.delegate = self
//        maxOccupTxt.delegate = self
       
        occupencyNum = 1
//        maxOccupTxt.text = "\(occupencyNum)"
        
//        numOfRoomTxt.delegate = self
//        tableView.delegate = self
//        tableView.dataSource = self
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        numOfRoomTxt.text = "0"
        priceTxt.text = "0.00"
//        roomGallery.removeAll()
//        imageDataForUpload.removeAll()
        

        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ResCreateMenuVC.dismissKeyboard))
        tap.delegate = self
        tap.cancelsTouchesInView = false
        self.view!.addGestureRecognizer(tap)
        
        
        
        self.initNavUnderline()
        self.initialObject()
        // Do any additional setup after loading the view.
    }
    func initialObject(){
        
        menuNameTxt.borderStyle = UITextBorderStyle.RoundedRect
        menuNameTxt.layer.cornerRadius = 5
        menuNameTxt.layer.borderWidth = 1
        menuNameTxt.layer.borderColor = UIColor(red: 0.13, green: 0.14, blue: 0.18, alpha: 0.09).CGColor
        menuNameTxt.layer.bounds.size.width = (self.view.frame.size.width) - 10
        menuNameTxt.center.x = (self.view.frame.size.width)/2
        
       // shotDescTxt.borderStyle = UITextBorderStyle.RoundedRect
        shotDescTxt.layer.cornerRadius = 5
        shotDescTxt.layer.borderWidth = 1
        shotDescTxt.layer.borderColor = UIColor(red: 0.13, green: 0.14, blue: 0.18, alpha: 0.2).CGColor
        shotDescTxt.layer.bounds.size.width = (self.view.frame.size.width) - 10
        shotDescTxt.center.x = (self.view?.frame.size.width)!/2

        priceTxt.borderStyle = UITextBorderStyle.RoundedRect
        priceTxt.layer.cornerRadius = 5
        priceTxt.layer.borderWidth = 1
        priceTxt.layer.borderColor = UIColor(red: 0.13, green: 0.14, blue: 0.18, alpha: 0.09).CGColor

        addButton.layer.cornerRadius = 5
        addButton.layer.bounds.size.width = (self.view.frame.size.width) - 10
        addButton.center.x = (self.view?.frame.size.width)!/2
        
        
        self.scrollView.frame.origin.y = 0
        self.scrollView.frame.origin.x = 0
        self.scrollView.frame.size.height = self.view.frame.size.height
        self.scrollView.frame.size.width = self.view.frame.size.width
        self.scrollView.contentSize.height = 612
        //self.scrollView.backgroundColor = UIColor.greenColor()
        
        let splitWidth = self.view.frame.size.width / 3
        viewSplMild.frame.origin.x = splitWidth * 0
        viewSplMild.frame.size.width = splitWidth
        
        viewSplMiddle.frame.origin.x = splitWidth * 1
        viewSplMiddle.frame.size.width = splitWidth
        
        viewSplHot.frame.origin.x = splitWidth * 2
        viewSplHot.frame.size.width = splitWidth
        
    }
    
    func initialSize(){
    width = UIScreen.mainScreen().bounds.size.width
    heigth = UIScreen.mainScreen().bounds.size.height
    
    
    }
    func initNavUnderline(){
        navunderlive.frame = CGRectMake(self.view.frame.size.width/3, (self.navigationController?.navigationBar.frame.size.height)! - 3, self.view.frame.size.width/3, 3)
        navunderlive.backgroundColor = UIColor.redColor()
        
        self.navigationController?.navigationBar.addSubview(navunderlive)
        
    }
    override func viewDidDisappear(animated: Bool) {
        print("viewDidDisappear(Create)")
    }
    @IBAction func addFacilityBtn(sender: AnyObject) {
        let alertView = CustomIOS7AlertView()
        alertView.containerView = createContainerView()
      //  alertView.frame = CGRectMake(25, 25, width-50 , heigth-100)
        alertView.delegate = self
        alertView.buttonColor = UIColor.redColor()
        alertView.buttonHeight = 50 
        alertView.show()
    }
    func customIOS7AlertViewButtonTouchUpInside(alertView: CustomIOS7AlertView, buttonIndex: Int) {
        alertView.close()
        print("customIOS7AlertViewButtonTouchUpInside")
        
        self.facilitiesRoomAttached.removeAll()
        for i in 0...appDelegate.facilityRoomDic!["roomTypeFacilities"]!.count - 1
        {
            if (self.appDelegate.facilityRoomStatus[i] as Bool)
            {
                self.facilitiesRoomAttached.append(appDelegate.facilityRoomDic!["roomTypeFacilities"]![i]["facility_name_en"] as! String)
            }
            
        }
//        tableView.reloadData()
    }
    func closealert(sender: UIButton, alertView: CustomIOS7AlertView) {
        alertView.close()
    }
    // Create a custom container view
    func createContainerView() -> UIView {
        width = UIScreen.mainScreen().bounds.size.width
        heigth = UIScreen.mainScreen().bounds.size.height
        let containerView = UIView(frame: CGRectMake(0, 0, 300 , heigth - 100))
        let subView1: UIView = NSBundle.mainBundle().loadNibNamed("roomfacility", owner: self, options: nil)[0] as! UIView
        subView1.frame = containerView.bounds

        containerView.addSubview(subView1)
        
        return containerView
    }

    @IBAction func btnBack(sender: AnyObject) {
        
        appDelegate.pagecontrolIndex = 2
        self.navigationController?.popViewControllerAnimated(true)
        
//       print("Back")
//        let nev = self.storyboard?.instantiateViewControllerWithIdentifier("navCon")
//        self.navigationController?.presentViewController(nev!, animated: true, completion: { () -> Void in
//            self.appDelegate.viewWithTopButtons.hidden = false
//            self.navunderlive.hidden = true
//            
//        })
        
    }


    @IBAction func btnAddRoom(sender: AnyObject) {
        
        if(menuNameTxt.text != "")
        {
            print("Create Room")
            PKHUD.sharedHUD.dimsBackground = false
            PKHUD.sharedHUD.userInteractionOnUnderlyingViewsEnabled = false
            
            PKHUD.sharedHUD.contentView = PKHUDProgressView()
            //        PKHUD.sharedHUD.contentView = PKHUDStatusView(title: "Loading", subtitle: "Subtitle", image: nil)
            PKHUD.sharedHUD.show()
            
            let send = API_Model()
           
            let dataDic = [
                "providerInformation" : [
                    "providerId" : Int(appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["provider_id"]! as! String)!,
                    "providerTypeKeyname" : "restaurant"
                ],
                //Room
                "menu":[
                    "menuNameEn": menuNameTxt.text!,
                    "menuNameTh": "",
                    "menuDescriptionEn": shotDescTxt.text,
                    "menuDescriptionTh": "",
                    "menuPrice":priceTxt.text,
                    "spicyLevel": strSpiciLevel
                ],
                "user" : [
                    "accessToken" : appDelegate.userInfo["accessToken"]!
                ]
            ]
            
            let dataJson = send.Dict2JsonString(dataDic)
            
            print("data Send Json :\(dataJson)")
            print("Json Encode :\(send.jsonEncode(dataJson))")
            send.providerAPI(self.appDelegate.command["CreateMenu"]!, dataJson: dataJson){
                data in
                print("data(addMenu) :\(data)")
                 print("data(menu) :\(data["menu"]!)")
                 print("data(menuID) :\(data["menu"]!["menu_id"]!)")
//                XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
//                XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                
                if(self.imageDataForUpload.count != 0)
                {
                    send.getUploadMenuKey(Int(data["providerId"] as! String)!, menuID: (data["menu"]!["menu_id"] as! Int), imageType: "logoImage", imageName: self.imageNameForUpload!)
                    {
                        data in
                        PKHUD.sharedHUD.dimsBackground = false
                        PKHUD.sharedHUD.userInteractionOnUnderlyingViewsEnabled = false
                        PKHUD.sharedHUD.contentView = PKHUDProgressView()
                        PKHUD.sharedHUD.show()
                        
                        print("UPLOAD DATA ::: \(data)")
                        
                        send.uploadImage(data, image: self.imageDataForUpload[0], imageName: self.imageNameForUpload!)
                        {
                            data in
//                            PKHUD.sharedHUD.contentView = PKHUDSuccessView()
                            print("DataUpload : \(data)")
//                            PKHUD.sharedHUD.hide(afterDelay: 0.1)
//                            let alert = SCLAlertView()
//                            alert.showCircularIcon = false
//                            alert.showInfo("Information", subTitle: "Create Menu Success", colorStyle:0xAC332F ,duration: 2.0)
//                            self.navigationController?.popViewControllerAnimated(true)
//                            
                            PKHUD.sharedHUD.hide(false, completion: {action in
                                let alert = SCLAlertView()
                                alert.showCircularIcon = false
                                alert.showCloseButton = false
                                alert.addButton("Done", action: {action in
                                    self.navigationController?.popViewControllerAnimated(true)
                                })
                                //alert.showError(, subTitle: )
                                alert.showError("Information", subTitle: "Create Menu Success!")
                            })
                            
                            
                        }
                        
                        
                    }
                    
                }else{
//                    PKHUD.sharedHUD.hide(afterDelay: 0.1)
//                    let alert = SCLAlertView()
//                    alert.showCircularIcon = false
//                    alert.showInfo("Information", subTitle: "Create Menu Success", colorStyle:0xAC332F , closeButtonTitle : "OK")
                    
                    //self.navigationController?.popViewControllerAnimated(true)
                
                    
                    PKHUD.sharedHUD.hide(false, completion: {action in
                        let alert = SCLAlertView()
                        alert.showCircularIcon = false
                        alert.showCloseButton = false
                        alert.addButton("Done", action: {action in
                            self.navigationController?.popViewControllerAnimated(true)
                        })
                        //alert.showError(, subTitle: )
                        alert.showError("Information", subTitle: "Create Menu Success!")
                    })
                    
                }
            }
        }else{
            print("No Data")
            let alert = SCLAlertView()
            alert.showCircularIcon = false
            alert.showInfo("Alert", subTitle: "กรุณากรอกข้อมูล", colorStyle:0xAC332F , closeButtonTitle : "OK")
        }

        appDelegate.pagecontrolIndex = 2
        
    }
    
    func getFacility()
    {
        //print("roomDataALL : \(self.appDelegate.roomDic!["roomTypes"])")  7288
        let dataDic =
        [
            "roomType": [
                "roomTypeId": self.appDelegate.roomDic!["roomTypes"]![self.appDelegate.roomIndex!]!["room_type_id"] as! String
            ]
        ]
        
        let dataJson = send.Dict2JsonString(dataDic)
        print("data Send Json :\(dataJson)")
        print("Json Get(Room)FacilityAttached :\(send.jsonEncode(dataJson))")
        //Update Provider
        send.providerAPI(self.appDelegate.command["GetRoomTypeFacilityAttached"]!, dataJson: dataJson)
            {
                data in
                print("data(Get(Room)FacilityAttached) :\(data)")
                print("Count \(data["roomTypeFacilitiesAttached"]!.count )")
                if(data["roomTypeFacilitiesAttached"]!.count != 0 )
                {
                    for i in 0...data["roomTypeFacilitiesAttached"]!.count - 1
                    {
                        print(data["roomTypeFacilitiesAttached"]![i]["facility_keyname"])
                        print("Fac Room Dic WTF : \(self.appDelegate.facilityRoomDic!)")
                        print("CountWTF : \(self.appDelegate.facilityRoomDic!["roomTypeFacilities"]!.count)")
                        for j in 0...self.appDelegate.facilityRoomDic!["roomTypeFacilities"]!.count - 1
                        {
                            //                    print("facilitiesAttachedID \(self.appDelegate.facilityHotelDic!["facilities"]![j]!["facility_id"])")
                            
                            if((data["roomTypeFacilitiesAttached"]![i]["room_type_facility_id"] as! String) == (self.appDelegate.facilityRoomDic!["roomTypeFacilities"]![j]!["room_type_facility_id"] as! String))
                            {
                                self.appDelegate.facilityRoomStatus[j] = true
                                print("index : \(j) \(data["roomTypeFacilitiesAttached"]![i]["room_type_facility_id"] as! String)")
                                print("index : \(j) \(self.appDelegate.facilityRoomDic!["roomTypeFacilities"]![j]!["room_type_facility_id"] as! String)")
                                
                            }
                            
                        }
                        self.facilitiesRoomAttached.append(data["roomTypeFacilitiesAttached"]![i]["facility_keyname"] as! String)
                    }
                }
//                self.tableView.reloadData()
                print("============facilitiesRoomAttached.count\(self.facilitiesRoomAttached.count)")
                
        }
        
    }

    
    func setFacility(roomTypeId:Int)
    {
        
        print("RoomID \(roomTypeId)")
        var dataDic =
        [
            "roomType" :
                [
                    "roomTypeId" : roomTypeId,
            ],
            "roomTypeFacilitiesAttached" :[],
            
            "user" : [
                "accessToken" : appDelegate.userInfo["accessToken"]!
            ]
        ]
        
        print("RoomFacility : \(appDelegate.facilityRoomDic)")
        var facilitiesAttached:[[String:String]] = []
        for i in 0...appDelegate.facilityRoomDic!["roomTypeFacilities"]!.count - 1
        {
            if (self.appDelegate.facilityRoomStatus[i] as Bool)
            {
                //                "room_type_facility_id": "1",
                //                "facility_keyname": "air",
                //                "quantity": "0",
                facilitiesAttached.append(
                    ["room_type_facility_id": appDelegate.facilityRoomDic!["roomTypeFacilities"]![i]["room_type_facility_id"] as! String,
                        "facility_keyname": appDelegate.facilityRoomDic!["roomTypeFacilities"]![i]["facility_name_en"] as! String,
                        "quantity": "0", ])
        //        print("fac OK \(appDelegate.facilityRoomDic!["roomTypeFacilities"]![i])")
            }
            
        }
        
        dataDic["roomTypeFacilitiesAttached"] = facilitiesAttached
        let dataJson = send.Dict2JsonString(dataDic)
        
        print("data Send Json(setFac) :\(dataJson)")
        print("Json Encode :\(send.jsonEncode(dataJson))")
        //Update SetFacilityAttached
        send.providerAPI(self.appDelegate.command["SetRoomTypeFacilityAttached"]!, dataJson: dataJson){
            data in
            print("data(SetRoomFacilityAttached) :\(data)")
            
        }
    }
    func buttonTapped(btn:SCLButton) {
//        self.navigationController!.dismissViewControllerAnimated(true, completion: nil)
    }
    func dismissKeyboard()
    {
        menuNameTxt.resignFirstResponder()
        priceTxt.resignFirstResponder()
//        numOfRoomTxt.resignFirstResponder()
//        bedTxt.resignFirstResponder()
//        maxOccupTxt.resignFirstResponder()
        shotDescTxt.resignFirstResponder()
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
        func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        print("ImagePicker")
        var chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
            
            chosenImage = FileMan().resizeImage(chosenImage, maxSize: 1500)
            
            imageDataForUpload[0] = chosenImage
            imgMenuLogo.image = chosenImage
            let imageURL = info[UIImagePickerControllerReferenceURL] as! NSURL
            imageNameForUpload = imageURL.pathComponents![1];
            print("imageName : \(imageNameForUpload)")
        dismissViewControllerAnimated(true, completion: nil)

    }
    
    //gestureRecognizer
//
//    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
////        if(self.view.isDescendantOfView(self.collectionView))
////        {
////            print("if gestureRecognizer")
////            return false
////        }
////        else
////        {
////            print("else gestureRecognizer")
////            return true
////        }
//    }

    
}
