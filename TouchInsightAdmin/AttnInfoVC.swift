//
//  ContentViewController.swift
//  TouchInsightAdmin
//
//  Created by Touch on 12/8/2558 BE.
//  Copyright © 2558 weerapons suwanchatree. All rights reserved.
//

import UIKit
import SCLAlertView
import PKHUD

class AttnInfoVC: UIViewController, CustomIOS7AlertViewDelegate ,UITextFieldDelegate, UIImagePickerControllerDelegate ,UINavigationControllerDelegate ,UIAccelerometerDelegate {
    let width = UIScreen.mainScreen().bounds.size.width
    let height = UIScreen.mainScreen().bounds.size.height
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var provinceID = Int()
    let send = API_Model()
    var pickerPick = false
    var mediaKey:String!
    var facilitiesAttached:[[String:String]] = []
    
    var facilitiesHotelAttached = [String]()
    
    //    @IBOutlet var lblAddHotelfac: UILabel!
    //    @IBOutlet var tableView: UITableView!
    //    @IBOutlet var hotelFacListView: UIView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var imgHotelLogo: UIImageView!
    @IBOutlet var txtHotelName: UITextField!
    @IBOutlet var HotelDesTxt: UITextView!
    @IBOutlet var phonNumberTxt: UITextField!
    //    @IBOutlet var emailTxt: UITextField!
    //    @IBOutlet var websiteTxt: UITextField!
    //    @IBOutlet var provinceTxt: UITextField!
    //    @IBOutlet var addressTxt: UITextView!
    //    @IBOutlet var totalRoomTxt: UITextField!
    //    @IBOutlet var totalFloorTxt: UITextField!
    //    @IBOutlet var checkInTxt: UITextField!
    //    @IBOutlet var checkInTitle: UILabel!
    //    @IBOutlet var checkOutTxt: UITextField!
    //    @IBOutlet var checkOutTitle: UILabel!
    //    @IBOutlet var checkInView: UIView!
    //    @IBOutlet var checkOutView: UIView!
    //
    //    @IBOutlet var distanceCityTxt: UITextField!
    //    @IBOutlet var DistanceAirportTxt: UITextField!
//    @IBOutlet var pickerView: UIPickerView!
//    @IBOutlet var checkinPicker: UIDatePicker!
//    @IBOutlet var checkoutPicker: UIDatePicker!
    
    //    @IBOutlet var lblAirport: UILabel!
    
    
    var button = UIButton()
    
    var SCALING_Y = (1024.0/480.0)
    var SCALING_X = (768.0/360.0)
    
    
    
    
    
    
    // Spicy Level
    
    @IBOutlet weak var viewSplMild: UIView!
    @IBOutlet weak var viewSplMiddle: UIView!
    @IBOutlet weak var viewSplHot: UIView!
    
    
    var selectedSpicyLevel = [
        "mild":"1",
        "middle":"0",
        "hot":"0",
        ]
    @IBOutlet weak var img_mild: UIImageView!
    @IBOutlet weak var img_middle: UIImageView!
    @IBOutlet weak var img_hot: UIImageView!
    
    @IBAction func btn_mild_click(sender: AnyObject) {
        
        selectedSpicyLevel["mild"] = "1"
        selectedSpicyLevel["middle"] = "0"
        selectedSpicyLevel["hot"] = "0"
        
        img_mild.image = UIImage(named: "mild_hover.png")
        img_middle.image = UIImage(named: "middle.png")
        img_hot.image = UIImage(named: "hot.png")
        
        displaySelectedData()
    }
    
    @IBAction func btn_middle_click(sender: AnyObject) {
        
        selectedSpicyLevel["mild"] = "0"
        selectedSpicyLevel["middle"] = "1"
        selectedSpicyLevel["hot"] = "0"
        
        img_mild.image = UIImage(named: "mild.png")
        img_middle.image = UIImage(named: "middle_hover.png")
        img_hot.image = UIImage(named: "hot.png")
        
        displaySelectedData()
    }
    
    @IBAction func btn_hot_click(sender: AnyObject) {
        
        selectedSpicyLevel["mild"] = "0"
        selectedSpicyLevel["middle"] = "0"
        selectedSpicyLevel["hot"] = "1"
        
        img_mild.image = UIImage(named: "mild.png")
        img_middle.image = UIImage(named: "middle.png")
        img_hot.image = UIImage(named: "hot_hover.png")
        
        displaySelectedData()
    }
    
    func displaySelectedData() {
        print(selectedSpicyLevel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("AttnInfoVC")
        self.view.bounds.size = CGSizeMake(UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height)
        
        
        self.setObject()
        
        //hide keybord when tap view
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AttnInfoVC.dismissKeyboard))
        self.view!.addGestureRecognizer(tap)
        
        
        
        self.initailLogoImage()
    }
    override func viewDidDisappear(animated: Bool) {
        print("viewDidDisappear(hotelInfo)")
        //        appDelegate.facilityHotelStatus.removeAll()
    }
    func initailLogoImage(){
        imgHotelLogo.backgroundColor = UIColor.whiteColor()
        imgHotelLogo.layer.cornerRadius = 10
        if let logo = self.appDelegate.userInfo["avatarImage"] {
            print("has avatar : \(self.appDelegate.userInfo["avatarImage"])")
            imgHotelLogo.image = UIImage(data:NSData(contentsOfURL:NSURL(string:logo)!)!)
        }else
        {
            print("no avatar")
            imgHotelLogo.image = UIImage(named: "ic_team.png")
        }
        
    }
    
    
    func initalertView(){
        let alertView = CustomIOS7AlertView()
        alertView.containerView = createContainerView()
        alertView.delegate = self
        alertView.buttonColor = UIColor.redColor()
        //  alertView.buttonHeight = 0
        alertView.show()
    }
    
    func customIOS7AlertViewButtonTouchUpInside(alertView: CustomIOS7AlertView, buttonIndex: Int) {
        alertView.close()
        
        self.facilitiesHotelAttached.removeAll()
        for i in 0...appDelegate.facilityHotelDic!["facilities"]!.count - 1
        {
            if (self.appDelegate.facilityHotelStatus[i] as Bool)
            {
                
                self.facilitiesHotelAttached.append(appDelegate.facilityHotelDic!["facilities"]![i]["facility_name_en"] as! String)
                
                
            }
            
        }
    }
    
    //    func closealert(alertView : CustomIOS7AlertView){
    //        alertView.close()
    //    tableView.reloadData()
    //    }
    // Create a custom container view
    func createContainerView() -> UIView {
        //let width = UIScreen.mainScreen().bounds.size.width
        let height = UIScreen.mainScreen().bounds.size.height
        let containerView = UIView(frame: CGRectMake(0, 0, 300 , height - 100))
        
        let subView1: hotelfacility = NSBundle.mainBundle().loadNibNamed("hotelfacility", owner: self, options: nil)[0] as! hotelfacility
        subView1.frame = containerView.bounds
        // subView1.closeAlert.addTarget(self, action: "closealert:", forControlEvents: .TouchUpInside)
        // sibview.frame = CGRectMake(0, 0, 300, 400)
        // sibview.backgroundColor = UIColor.greenColor()
        containerView.addSubview(subView1)
        
        return containerView
    }
    
    
    @IBOutlet var buttonsave: UIButton!
    @IBAction func btnSave(sender: AnyObject) {
        print("save")
        //  print ("Province ID : \(provinceID)")
        
        PKHUD.sharedHUD.dimsBackground = false
        PKHUD.sharedHUD.userInteractionOnUnderlyingViewsEnabled = false
        
        PKHUD.sharedHUD.contentView = PKHUDProgressView()
        //        PKHUD.sharedHUD.contentView = PKHUDStatusView(title: "Loading", subtitle: "Subtitle", image: nil)
        PKHUD.sharedHUD.show()
        PKHUD.sharedHUD.hide(afterDelay: 2.0)
        
        //        let send = API_Model()
        let dataDic = [
            "providerInformation" : [
                "providerId" : Int(appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["provider_id"]! as! String)!,
                "providerTypeKeyname" : "hotel",
                "nameEn": (txtHotelName.text! == "") ? "" : txtHotelName.text!,
                "shortDescriptionEn": HotelDesTxt.text!,
                "shortDescriptionTh": "",
//                "addressEn": addressTxt.text!,
                "addressTh": "",
                "provinceId": provinceID,
                "longitude": "",
                "latitude": "",
                "phone": phonNumberTxt.text!,
//                "website": websiteTxt.text!,
//                "email": emailTxt.text!,
                //Hotel
//                "hotelPolicyEn": "",
//                "hotelPolicyTh": "",
//                "checkInTime": checkInTxt.text!,
//                "checkOutTime": checkOutTxt.text!,
//                "isBookable": "",
//                "touchbookingpaymentMerchantAccountKeycode": "",
//                "wifiAvailable": "",
//                "parkingAvailable": "",
//                "totalRoom": totalRoomTxt.text!,
//                "openDaily": "",
//                "distanceFromCityCenter": distanceCityTxt.text!,
//                "distanceToAirport": DistanceAirportTxt.text!,
//                "nonSmokingZone": "",
//                "numberOfBar": "",
//                "numberOfFloors": totalFloorTxt.text!,
//                "numberOfRestaurants": "",
//                "timeToAirport": ""
            ],
            "user" : [
                "accessToken" : appDelegate.userInfo["accessToken"]!
            ]
        ]
        
        let dataJson = send.Dict2JsonString(dataDic)
        
        print("data Send Json(information) :\(dataJson)")
        print("Json Encode :\(send.jsonEncode(dataJson))")
        //Update Provider
        send.providerAPI(self.appDelegate.command["updateProvider"]!, dataJson: dataJson){
            data in
            print("data :\(data)")
            self.send.getUserInfo(self.appDelegate.userInfo["userID"]! as String)
            {
                data in
                print("data : \(data)")
                
                
                let dataJson = "{\"providerUser\":\"\(data["email"]!)\"}"
                //                    print("appDelegate :\(self.appDelegate.userInfo["email"])")
                print("dataSendJson : \(dataJson)")
                self.send.providerAPI(self.appDelegate.command["listProvider"]!, dataJson: dataJson){
                    data in
                    
                    print("listProvider :\(data["ListProviderInformationSummary"]!)")
                    
                    print("listProvider count:\(data["ListProviderInformationSummary"]!.count)")
                    self.appDelegate.providerData = data
                    print("Count: \(self.appDelegate.providerData!["ListProviderInformationSummary"]!.count)")
                    
                    PKHUD.sharedHUD.contentView = PKHUDSuccessView()
                    PKHUD.sharedHUD.hide(afterDelay: 1.0)
                    
                    // let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("providerlist")
                    // secondViewController?.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
                    //self.navigationController?.pushViewController(secondViewController!, animated: true)
                    self.dismissViewControllerAnimated(true, completion: nil)
                    
                    self.appDelegate.viewWithTopButtons.hidden = true
                }
                
            }
            
            
            
            
            
        }
        print("==============================================")
        self.setFacility()
        print("==============================================")
        
        //        print("Facility(status) : \(appDelegate.facilityHotelStatus)")
        for i in 0...appDelegate.facilityHotelDic!["facilities"]!.count - 1
        {
            //            print("faccccccc \(i)")
            if(self.appDelegate.facilityHotelStatus[i])
            {
                print("Facility :\(appDelegate.facilityHotelDic!["facilities"]![i]["facility_name_en"] as! String)")
            }
            
        }
    }
    func getFacility()
    {
        
        facilitiesHotelAttached.removeAll()
        
        let dataDic =
            [
                "providerInformation" :
                    [
                        "providerId" : Int(appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["provider_id"]! as! String)!,
                        "providerTypeKeyname" : "hotel"
                ]
        ]
        
        let dataJson = send.Dict2JsonString(dataDic)
        print("data Send Json :\(dataJson)")
        print("Json GetFacilityAttached :\(send.jsonEncode(dataJson))")
        //Update Provider
        send.providerAPI(self.appDelegate.command["GetFacilityAttached"]!, dataJson: dataJson)
        {
            data in
            print("data(GetFacilityAttached) :\(data)")
            print("Count \(data["facilitiesAttached"]!.count )")
            if(data["facilitiesAttached"]!.count != 0 )
            {
                for i in 0...data["facilitiesAttached"]!.count - 1
                {
                    print(data["facilitiesAttached"]![i]["facility_keyname"])
                    print("CountWTF : \(self.appDelegate.facilityHotelDic!["facilities"]!.count)")
                    for j in 0...self.appDelegate.facilityHotelDic!["facilities"]!.count - 1
                    {
                        //                    print("facilitiesAttachedID \(self.appDelegate.facilityHotelDic!["facilities"]![j]!["facility_id"])")
                        
                        if((data["facilitiesAttached"]![i]["facility_id"] as! String) == (self.appDelegate.facilityHotelDic!["facilities"]![j]!["facility_id"] as! String))
                        {
                            self.appDelegate.facilityHotelStatus[j] = true
                            print("index : \(j) \(data["facilitiesAttached"]![i]["facility_id"] as! String)")
                            print("index : \(j) \(self.appDelegate.facilityHotelDic!["facilities"]![j]!["facility_id"] as! String)")
                            
                        }
                        
                    }
                    self.facilitiesHotelAttached.append(data["facilitiesAttached"]![i]["facility_keyname"] as! String)
                }
            }
        }
        
        print("all Attc hotel \(appDelegate.facilityHotelDic)")
        
    }
    
    func setFacility()
    {
        var dataDic =
            [
                "providerInformation" :
                    [
                        "providerId" : Int(appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["provider_id"]! as! String)!,
                        "providerTypeKeyname" : "hotel"
                ],
                "facilitiesAttached" :[],
                
                "user" : [
                    "accessToken" : appDelegate.userInfo["accessToken"]!
                ]
        ]
        
        //var facilitiesAttached:[[String:String]] = []
        self.facilitiesHotelAttached.removeAll()
        for i in 0...appDelegate.facilityHotelDic!["facilities"]!.count - 1
        {
            if (self.appDelegate.facilityHotelStatus[i] as Bool)
            {
                facilitiesAttached.append(
                    ["facility_id": appDelegate.facilityHotelDic!["facilities"]![i]["facility_id"] as! String,
                        "facility_keyname": appDelegate.facilityHotelDic!["facilities"]![i]["facility_name_en"] as! String,
                        "quantity": "0", ])
                print("fac OK \(appDelegate.facilityHotelDic!["facilities"]![i]["facility_name_en"] as! String)")
                
                self.facilitiesHotelAttached.append(appDelegate.facilityHotelDic!["facilities"]![i]["facility_name_en"] as! String)
                
                
            }
            
        }
        
        dataDic["facilitiesAttached"] = facilitiesAttached
        let dataJson = send.Dict2JsonString(dataDic)
        //        print("facilitiesAttached : \(facilitiesAttached[1]["facility_keyname"])")
        //        print("facilitiesAttached(Count) : \(facilitiesAttached.count)")
        
        //        print("data Send Json :\(dataJson)")
        //        print("Json Encode :\(send.jsonEncode(dataJson))")
        //Update SetFacilityAttached
        
        send.providerAPI(self.appDelegate.command["SetFacilityAttached"]!, dataJson: dataJson){
            data in
            print("data(SetFacilityAttached) :\(data)")
            
        }
    }
    
    func dismissKeyboard() {
        txtHotelName.resignFirstResponder()
//        emailTxt.resignFirstResponder()
//        websiteTxt.resignFirstResponder()
//        provinceTxt.resignFirstResponder()
//        totalRoomTxt.resignFirstResponder()
//        totalFloorTxt.resignFirstResponder()
//        checkInTxt.resignFirstResponder()
//        checkOutTxt.resignFirstResponder()
//        distanceCityTxt.resignFirstResponder()
//        DistanceAirportTxt.resignFirstResponder()
        
        HotelDesTxt.resignFirstResponder()
//        addressTxt.resignFirstResponder()
        phonNumberTxt.resignFirstResponder()
//        pickerView.hidden = true
//        checkinPicker.hidden = true
//        checkoutPicker.hidden = true
        
    }
    
    func dismissKeyboard2() {
        print("dismissKeyboard2")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("didReseive")
        // Dispose of any resources that can be recreated.
    }
    func setObject(){
        
        imgHotelLogo.layer.cornerRadius = 5
        imgHotelLogo.layer.borderWidth = 1
        imgHotelLogo.layer.borderColor = UIColor(red: 0.13, green: 0.14, blue: 0.18, alpha: 0.2).CGColor
        
        txtHotelName.borderStyle = UITextBorderStyle.RoundedRect
        txtHotelName.layer.cornerRadius = 5
        txtHotelName.center.x = width/2
        txtHotelName.layer.bounds.size.width = width - 10
        txtHotelName.layer.borderWidth = 1
        txtHotelName.layer.borderColor = UIColor(red: 0.13, green: 0.14, blue: 0.18, alpha: 0.09).CGColor
        
        HotelDesTxt.layer.cornerRadius = 5
        HotelDesTxt.center.x = width/2
        HotelDesTxt.layer.bounds.size.width = width - 10
        HotelDesTxt.layer.borderWidth = 1
        HotelDesTxt.layer.borderColor = UIColor(red: 0.13, green: 0.14, blue: 0.18, alpha: 0.2).CGColor
        
        phonNumberTxt.borderStyle = UITextBorderStyle.RoundedRect
        phonNumberTxt.layer.cornerRadius = 5
        phonNumberTxt.center.x = width/2
        phonNumberTxt.layer.bounds.size.width = width - 10
        phonNumberTxt.layer.borderWidth = 1
        phonNumberTxt.layer.borderColor = UIColor(red: 0.13, green: 0.14, blue: 0.18, alpha: 0.09).CGColor
        
        buttonsave.layer.cornerRadius = 5
//        buttonsave.center.x = width/2
//        buttonsave.layer.bounds.size.width = UIScreen.mainScreen().bounds.width - 20
        
        var frmButtonSave = buttonsave.frame
        frmButtonSave.size.width = self.view.frame.size.width - 20
        frmButtonSave.origin.x = 10
        buttonsave.frame = frmButtonSave
        
        
        
//        pickerView.center.y = UIScreen.mainScreen().bounds.height - 200
//        checkinPicker.center.y = UIScreen.mainScreen().bounds.height - 200
//        checkoutPicker.center.y = UIScreen.mainScreen().bounds.height - 200
//        
//        
//        pickerView.frame.origin.x = 0
//        checkinPicker.frame.origin.x = 0
//        checkoutPicker.frame.origin.x = 0
        
        self.scrollView.frame.origin.y = 0
        
        let splitWidth = self.view.frame.size.width / 3
        viewSplMild.frame.origin.x = splitWidth * 0
        viewSplMild.frame.size.width = splitWidth
        
        viewSplMiddle.frame.origin.x = splitWidth * 1
        viewSplMiddle.frame.size.width = splitWidth
        
        viewSplHot.frame.origin.x = splitWidth * 2
        viewSplHot.frame.size.width = splitWidth
//        
//        @IBOutlet weak var viewSplMild: UIView!
//        @IBOutlet weak var viewSplMiddle: UIView!
//        @IBOutlet weak var viewSplHot: UIView!
//        
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        //        self.viewDidLoad()
        //        self.viewDidAppear(true)
        
        
        //self.setObject()
        //        self.getFacility()
        //        self.getProviderByID()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(AttnInfoVC.imageTapped(_:)))
        imgHotelLogo.userInteractionEnabled = true
        imgHotelLogo.addGestureRecognizer(tapGestureRecognizer)
        self.scrollView.addSubview(self.imgHotelLogo)
        
        scrollView.contentSize = CGSizeMake(width,810)
        
        print("scrollwidth = \(scrollView.layer.bounds.size.width)")
        scrollView.layer.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1).CGColor
        
        //hide keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AttnInfoVC.dismissKeyboard))
        self.view!.addGestureRecognizer(tap)
        
        //        provinceTxt.resignFirstResponder()
        //set picker view
        
        
        //  print("picker : \(pickerView.layer.bounds.size.height)")
        
        
        
        //  print("data All\(appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!])")
        txtHotelName.text = (appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["name_en"]! as! String)
        //    imgHotelLogo.image = (appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["images"]!!["logo_image"]! as! String)
        HotelDesTxt.text = (appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["short_description_en"]! as! String)
        phonNumberTxt.text = (appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["phone"]! as! String)
//        emailTxt.text = (appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["email"]! as! String)
//        websiteTxt.text = (appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["website"]! as! String)
//        provinceTxt.text = (appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["province_name_en"]! as! String)
        provinceID = Int(appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["province_id"]! as! String)!
//        addressTxt.text = (appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["address_en"]! as! String)
        print("Logooooo \((appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["images"]!!["logo_image"]))");
        self.imgHotelLogo.image = UIImage(named: "bg_cctvdefault.png")
        
        
        //                    if(pickerPick == false){
        //
        //                    }
        //                    else{
        //
        //                         self.imgHotelLogo.image = UIImage(named: "bg_cctvdefault.png")
        //                     self.imgHotelLogo.image = UIImage(data: NSData(contentsOfURL: NSURL(string: self.appDelegate.providerData!["ListProviderInformationSummary"]![self.appDelegate.providerIndex!]["images"]!!["logo_image"]!!["small"] as! String)!)!)
        //                    }
        
        if let logo = self.appDelegate.providerData!["ListProviderInformationSummary"]![self.appDelegate.providerIndex!]["images"]!!["logo_image"]!!["small"]
        {
            
            
            print("has LOGO : \(self.appDelegate.providerData!["ListProviderInformationSummary"]![self.appDelegate.providerIndex!]["images"]!!["logo_image"]!)")
            
            
            self.imgHotelLogo.image = UIImage(data:NSData(contentsOfURL:NSURL(string:logo as! String)!)!)
        }
        else
        {
            print("no logo")
            self.imgHotelLogo.image = UIImage(named: "bg_cctvdefault.png")
        }
        
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func getProviderByID()
    {
        PKHUD.sharedHUD.dimsBackground = false
        PKHUD.sharedHUD.userInteractionOnUnderlyingViewsEnabled = false
        
        //        PKHUD.sharedHUD.contentView = PKHUDStatusView(title: "Loading", subtitle: "Subtitle", image: nil)
        PKHUD.sharedHUD.contentView = PKHUDProgressView()
        PKHUD.sharedHUD.show()
        PKHUD.sharedHUD.hide(afterDelay: 1.0)
        
        let send = API_Model()
        print("providerId:::\(appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["provider_id"])")
        
        let dataJson = "{\"providerId\":\"\(appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["provider_id"] as! String)\"}"
        send.providerAPI(self.appDelegate.command["GetProviderInformationById"]!, dataJson: dataJson) {
            data in
            print("getProviderByID \(data)")
            PKHUD.sharedHUD.contentView = PKHUDSuccessView()
            PKHUD.sharedHUD.hide(afterDelay: 1.0)
            //            print("providerDataID \(data["GetProviderInformationById"]!["total_room"])")
            
        }
        
    }
    func imageTapped(img: AnyObject)
    {
        
        print("Upload Logo Img")
        
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(myPickerController, animated: true, completion: nil)
        
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        print("ImagePicker")
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        imgHotelLogo.contentMode = .ScaleAspectFit //3
        self.imgHotelLogo.image = chosenImage //4
        
        
        let imageURL = info[UIImagePickerControllerReferenceURL] as! NSURL
        let imageName = imageURL.pathComponents![1];
        print("imageName : \(imageName)")
        pickerPick = true
        //        imgHotelLogo.reloadInputViews()
        
        let send = API_Model()
        
        
        send.getUploadKey(Int(appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["provider_id"]! as! String)!,imageType: "logoImage",imageName: imageName){
            data in
            PKHUD.sharedHUD.dimsBackground = false
            PKHUD.sharedHUD.userInteractionOnUnderlyingViewsEnabled = false
            PKHUD.sharedHUD.contentView = PKHUDProgressView()
            PKHUD.sharedHUD.show()
            
            print("UPLOAD DATA ::: \(data)")
            self.mediaKey = data
            
            send.uploadImage(self.mediaKey, image: chosenImage, imageName: imageName)
            {
                data in
                //                PKHUD.sharedHUD.contentView = PKHUDSuccessView()
                
                let vc = self.storyboard?.instantiateViewControllerWithIdentifier("providerinfo") as! ProviderInfoVC
                self.navigationController?.pushViewController(vc, animated:true)
                self.dismissViewControllerAnimated(true, completion:
                    {
                        PKHUD.sharedHUD.hide(afterDelay: 1.0)
                        self.imgHotelLogo.image = chosenImage
                        self.imgHotelLogo.reloadInputViews()
                    }
                )
            }
            
            
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        print("imagePickerControllerDidCancel")
        // self.dismissViewControllerAnimated(true, completion: nil)
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("providerinfo") as! ProviderInfoVC
        self.navigationController?.pushViewController(vc, animated:true)
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
}
