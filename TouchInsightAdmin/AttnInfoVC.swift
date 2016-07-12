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

class AttnInfoVC: UIViewController, CustomIOS7AlertViewDelegate ,UITextFieldDelegate,UIPickerViewDelegate , UIPickerViewDataSource ,UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate ,UINavigationControllerDelegate ,UIAccelerometerDelegate {
    let width = UIScreen.mainScreen().bounds.size.width
    let height = UIScreen.mainScreen().bounds.size.height
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var provinceID = Int()
    let send = API_Model()
    var pickerPick = false
    var mediaKey:String!
    var facilitiesAttached:[[String:String]] = []

    var facilitiesHotelAttached = [String]()
    
    @IBOutlet var lblAddHotelfac: UILabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var hotelFacListView: UIView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var imgHotelLogo: UIImageView!
    @IBOutlet var txtHotelName: UITextField!
    @IBOutlet var HotelDesTxt: UITextView!
    @IBOutlet var phonNumberTxt: UITextField!
    @IBOutlet var emailTxt: UITextField!
    @IBOutlet var websiteTxt: UITextField!
    @IBOutlet var provinceTxt: UITextField!
    @IBOutlet var addressTxt: UITextView!
    @IBOutlet var totalRoomTxt: UITextField!
    @IBOutlet var totalFloorTxt: UITextField!
    @IBOutlet var checkInTxt: UITextField!
    @IBOutlet var checkInTitle: UILabel!
    @IBOutlet var checkOutTxt: UITextField!
    @IBOutlet var checkOutTitle: UILabel!
    @IBOutlet var checkInView: UIView!
    @IBOutlet var checkOutView: UIView!
    
    @IBOutlet var distanceCityTxt: UITextField!
    @IBOutlet var DistanceAirportTxt: UITextField!
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var checkinPicker: UIDatePicker!
    @IBOutlet var checkoutPicker: UIDatePicker!
    
    @IBOutlet var lblAirport: UILabel!
    
    
       var button = UIButton()
    
    var SCALING_Y = (1024.0/480.0)
    var SCALING_X = (768.0/360.0)
   
    
    @IBAction func addHotelFacilityBtn(sender: AnyObject) {
        
       self.initalertView()
        
    }
       override func viewDidLoad() {
        super.viewDidLoad()
        
        print("AttnInfoVC")
        self.view.bounds.size = CGSizeMake(UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height)

        
        checkinPicker.hidden = true
        checkinPicker.backgroundColor = UIColor.whiteColor()
        checkinPicker.addTarget(self, action: #selector(AttnInfoVC.checkinPickerChanged(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
        checkoutPicker.hidden = true
        checkoutPicker.backgroundColor = UIColor.whiteColor()
        checkoutPicker.addTarget(self, action: #selector(AttnInfoVC.checkoutPickerChanged(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.hidden = true

       
        self.setObject()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    //    checkOutTxt.delegate = self
        checkInTxt.delegate = self
//        print("province Data \(provinceData)")
//        print("province Delegate \(appDelegate.provinceName)")
        
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
   
func checkinPickerChanged(datePicker:UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.NoStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        let strCheckin = dateFormatter.stringFromDate(datePicker.date)
   //     let strCheckout = dateFormatter.stringFromDate(datePicker.date)
            checkInTxt.text = strCheckin
//            checkinPicker.hidden = true
    
}
    func checkoutPickerChanged(datePicker:UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.NoStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        let strCheckout = dateFormatter.stringFromDate(datePicker.date)
        //     let strCheckout = dateFormatter.stringFromDate(datePicker.date)
        checkOutTxt.text = strCheckout
//        checkoutPicker.hidden = true
        
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
        tableView.reloadData()
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
                "addressEn": addressTxt.text!,
                "addressTh": "",
                "provinceId": provinceID,
                "longitude": "",
                "latitude": "",
                "phone": phonNumberTxt.text!,
                "website": websiteTxt.text!,
                "email": emailTxt.text!,
                //Hotel
                "hotelPolicyEn": "",
                "hotelPolicyTh": "",
                "checkInTime": checkInTxt.text!,
                "checkOutTime": checkOutTxt.text!,
                "isBookable": "",
                "touchbookingpaymentMerchantAccountKeycode": "",
                "wifiAvailable": "",
                "parkingAvailable": "",
                "totalRoom": totalRoomTxt.text!,
                "openDaily": "",
                "distanceFromCityCenter": distanceCityTxt.text!,
                "distanceToAirport": DistanceAirportTxt.text!,
                "nonSmokingZone": "",
                "numberOfBar": "",
                "numberOfFloors": totalFloorTxt.text!,
                "numberOfRestaurants": "",
                "timeToAirport": ""
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
                self.tableView.reloadData()
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
        emailTxt.resignFirstResponder()
        websiteTxt.resignFirstResponder()
        provinceTxt.resignFirstResponder()
        totalRoomTxt.resignFirstResponder()
        totalFloorTxt.resignFirstResponder()
        checkInTxt.resignFirstResponder()
        checkOutTxt.resignFirstResponder()
        distanceCityTxt.resignFirstResponder()
        DistanceAirportTxt.resignFirstResponder()
        
        HotelDesTxt.resignFirstResponder()
        addressTxt.resignFirstResponder()
        phonNumberTxt.resignFirstResponder()
        pickerView.hidden = true
        checkinPicker.hidden = true
        checkoutPicker.hidden = true
        
    }
    
    func dismissKeyboard2() {
        print("dismissKeyboard2")
        provinceTxt.resignFirstResponder()
        
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
        
        emailTxt.borderStyle = UITextBorderStyle.RoundedRect
        emailTxt.layer.cornerRadius = 5
        emailTxt.center.x = width/2
        emailTxt.layer.bounds.size.width = width - 10
        emailTxt.layer.borderWidth = 1
        emailTxt.layer.borderColor = UIColor(red: 0.13, green: 0.14, blue: 0.18, alpha: 0.09).CGColor
        
        websiteTxt.borderStyle = UITextBorderStyle.RoundedRect
        websiteTxt.layer.cornerRadius = 5
        websiteTxt.center.x = width/2
        websiteTxt.layer.bounds.size.width = width - 10
        websiteTxt.layer.borderWidth = 1
        websiteTxt.layer.borderColor = UIColor(red: 0.13, green: 0.14, blue: 0.18, alpha: 0.09).CGColor
        
        provinceTxt.borderStyle = UITextBorderStyle.RoundedRect
        provinceTxt.layer.cornerRadius = 5
        provinceTxt.center.x = width/2
        provinceTxt.layer.bounds.size.width = width - 10
        provinceTxt.layer.borderWidth = 1
        provinceTxt.layer.borderColor = UIColor(red: 0.13, green: 0.14, blue: 0.18, alpha: 0.09).CGColor
        
        
        addressTxt.layer.cornerRadius = 5
        addressTxt.center.x = width/2
        addressTxt.layer.bounds.size.width = width - 10
        addressTxt.layer.borderWidth = 1
        addressTxt.layer.borderColor = UIColor(red: 0.13, green: 0.14, blue: 0.18, alpha: 0.2).CGColor
        
        
        hotelFacListView.layer.cornerRadius = 5
        hotelFacListView.center.x = width/2
        hotelFacListView.layer.bounds.size.width = width - 10
        hotelFacListView.layer.borderWidth = 1
        hotelFacListView.layer.borderColor = UIColor(red: 0.13, green: 0.14, blue: 0.18, alpha: 0.2).CGColor
        
        tableView.center.x = hotelFacListView.layer.bounds.size.width/2
        tableView.layer.bounds.size.width = hotelFacListView.layer.bounds.size.width - 10
        
        lblAddHotelfac.layer.bounds.size.width = 265
        lblAddHotelfac.center.x = hotelFacListView.layer.bounds.size.width/2 - 10
        
        totalRoomTxt.borderStyle = UITextBorderStyle.RoundedRect
        totalRoomTxt.layer.cornerRadius = 5
        totalRoomTxt.center.x = (width/2)/2
        totalRoomTxt.layer.bounds.size.width = width/2 - 10
        totalRoomTxt.layer.borderWidth = 1
        totalRoomTxt.layer.borderColor = UIColor(red: 0.13, green: 0.14, blue: 0.18, alpha: 0.09).CGColor
        
        totalFloorTxt.borderStyle = UITextBorderStyle.RoundedRect
        totalFloorTxt.layer.cornerRadius = 5
        totalFloorTxt.center.x = width - width/4
        totalFloorTxt.layer.bounds.size.width = width/2 - 10
        totalFloorTxt.layer.borderWidth = 1
        totalFloorTxt.layer.borderColor = UIColor(red: 0.13, green: 0.14, blue: 0.18, alpha: 0.09).CGColor
       
       // phonNumberTxt.borderStyle = UITextBorderStyle.RoundedRect
        checkInView.layer.cornerRadius = 5
        checkInView.center.x = (width/2)/2
        checkInView.layer.bounds.size.width = width/2 - 10
        checkInView.layer.borderWidth = 1
        checkInView.layer.borderColor = UIColor(red: 0.13, green: 0.14, blue: 0.18, alpha: 0.2).CGColor
        checkInTitle.center.x = (width/2)/2
        checkOutTitle.center.x = (width/2)/2

        
        
        checkInTxt.center.x = (width/2)/2
        checkOutTxt.center.x = (width/2)/2
        
       // phonNumberTxt.borderStyle = UITextBorderStyle.RoundedRect
        checkOutView.layer.cornerRadius = 5
        checkOutView.center.x =  width - width/4
        checkOutView.layer.bounds.size.width = width/2 - 10
        checkOutView.layer.borderWidth = 1
        checkOutView.layer.borderColor = UIColor(red: 0.13, green: 0.14, blue: 0.18, alpha: 0.2).CGColor
        
        distanceCityTxt.borderStyle = UITextBorderStyle.RoundedRect
        distanceCityTxt.layer.cornerRadius = 5
        distanceCityTxt.center.x = (width/2)/2+15
        distanceCityTxt.layer.bounds.size.width = width/2 - 60
        distanceCityTxt.layer.borderWidth = 1
        distanceCityTxt.layer.borderColor = UIColor(red: 0.13, green: 0.14, blue: 0.18, alpha: 0.09).CGColor
        
        lblAirport.frame = CGRectMake(distanceCityTxt.frame.origin.x + distanceCityTxt.frame.size.width + 5, distanceCityTxt.frame.origin.y, width/2 - 60, distanceCityTxt.frame.size.height)
        
        DistanceAirportTxt.borderStyle = UITextBorderStyle.RoundedRect
        DistanceAirportTxt.layer.cornerRadius = 5
        DistanceAirportTxt.center.x = width - width/5
        DistanceAirportTxt.layer.bounds.size.width = width/2 - 60
        DistanceAirportTxt.layer.borderWidth = 1
        DistanceAirportTxt.layer.borderColor = UIColor(red: 0.13, green: 0.14, blue: 0.18, alpha: 0.09).CGColor
      
        buttonsave.layer.cornerRadius = 5
//        buttonsave.center.x = width/2
//        buttonsave.layer.bounds.size.width = UIScreen.mainScreen().bounds.width - 20
        pickerView.center.y = UIScreen.mainScreen().bounds.height - 200
        checkinPicker.center.y = UIScreen.mainScreen().bounds.height - 200
        checkoutPicker.center.y = UIScreen.mainScreen().bounds.height - 200
       
    }
   
    override func viewWillAppear(animated: Bool) {
//        self.viewDidLoad()
//        self.viewDidAppear(true)
        
        
        self.setObject()
//        self.getFacility()
//        self.getProviderByID()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(AttnInfoVC.imageTapped(_:)))
        imgHotelLogo.userInteractionEnabled = true
        imgHotelLogo.addGestureRecognizer(tapGestureRecognizer)
        self.scrollView.addSubview(self.imgHotelLogo)
        
        scrollView.contentSize = CGSizeMake(width,2150)
        
        print("scrollwidth = \(scrollView.layer.bounds.size.width)")
        scrollView.layer.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1).CGColor

      
        //hide keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AttnInfoVC.dismissKeyboard))
        self.view!.addGestureRecognizer(tap)

        let pickerTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AttnInfoVC.dismissKeyboard2))
        provinceTxt.addGestureRecognizer(pickerTap)
//        provinceTxt.resignFirstResponder()
        //set picker view


      //  print("picker : \(pickerView.layer.bounds.size.height)")
        

        
      //  print("data All\(appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!])")
        txtHotelName.text = (appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["name_en"]! as! String)
    //    imgHotelLogo.image = (appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["images"]!!["logo_image"]! as! String)
        HotelDesTxt.text = (appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["short_description_en"]! as! String)
        phonNumberTxt.text = (appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["phone"]! as! String)
        emailTxt.text = (appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["email"]! as! String)
        websiteTxt.text = (appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["website"]! as! String)
        provinceTxt.text = (appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["province_name_en"]! as! String)
        provinceID = Int(appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["province_id"]! as! String)!
        addressTxt.text = (appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["address_en"]! as! String)
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
    
    func textFieldShouldBeginEditing(textField:UITextField) -> Bool {

        if(textField == provinceTxt){
            
            pickerView.hidden = false
            txtHotelName.resignFirstResponder()
            emailTxt.resignFirstResponder()
            websiteTxt.resignFirstResponder()
            provinceTxt.resignFirstResponder()
            totalRoomTxt.resignFirstResponder()
            totalFloorTxt.resignFirstResponder()
            checkInTxt.resignFirstResponder()
            checkOutTxt.resignFirstResponder()
            distanceCityTxt.resignFirstResponder()
            DistanceAirportTxt.resignFirstResponder()
            
            HotelDesTxt.resignFirstResponder()
            addressTxt.resignFirstResponder()
            phonNumberTxt.resignFirstResponder()

        return false
           
        }
        else if(textField == checkInTxt){
            
            checkinPicker.hidden = false
            checkoutPicker.hidden = true
            txtHotelName.resignFirstResponder()
            emailTxt.resignFirstResponder()
            websiteTxt.resignFirstResponder()
            provinceTxt.resignFirstResponder()
            totalRoomTxt.resignFirstResponder()
            totalFloorTxt.resignFirstResponder()
            checkInTxt.resignFirstResponder()
            checkOutTxt.resignFirstResponder()
            distanceCityTxt.resignFirstResponder()
            DistanceAirportTxt.resignFirstResponder()
            
            HotelDesTxt.resignFirstResponder()
            addressTxt.resignFirstResponder()
            phonNumberTxt.resignFirstResponder()
       
        return false
        }
        else if(textField == checkOutTxt){
            checkoutPicker.hidden = false
            checkinPicker.hidden = true
            txtHotelName.resignFirstResponder()
            emailTxt.resignFirstResponder()
            websiteTxt.resignFirstResponder()
            provinceTxt.resignFirstResponder()
            totalRoomTxt.resignFirstResponder()
            totalFloorTxt.resignFirstResponder()
            checkInTxt.resignFirstResponder()
            checkOutTxt.resignFirstResponder()
            distanceCityTxt.resignFirstResponder()
            DistanceAirportTxt.resignFirstResponder()
            
            HotelDesTxt.resignFirstResponder()
            addressTxt.resignFirstResponder()
            phonNumberTxt.resignFirstResponder()
         return false
        }
        
    
        return true
    
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if (textField != provinceTxt){
        
            textField.resignFirstResponder()

         return true
        }
        
            return true
    }

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return appDelegate.provinceName.count;
    }
    
    func pickerView(provincePickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return appDelegate.provinceName[row]
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        provinceTxt.text = appDelegate.provinceName[row]
        provinceID = Int(appDelegate.provinceID[row])!
//        pickerView.hidden = true
        }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return facilitiesHotelAttached.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        if(facilitiesHotelAttached.count == 0){
         cell.textLabel?.text = ""
        }
        else{
       // var facilitiesAttached:[[String:String]] = []
       cell.textLabel?.text = facilitiesHotelAttached[indexPath.row]
        print("facilitiesHotelAttached(table) \(facilitiesHotelAttached[indexPath.row])")
        }
        
       //cell.textLabel?.text = "facility name"
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Select")
    }
    
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
            
            self.totalRoomTxt.text = (data["GetProviderInformationById"]!["total_room"]! === NSNull()) ? "" : data["GetProviderInformationById"]!["total_room"] as! String
            
            self.totalFloorTxt.text = (data["GetProviderInformationById"]!["number_of_floors"]! === NSNull()) ? "" : data["GetProviderInformationById"]!["number_of_floors"] as! String
            
            self.checkInTxt.text = (data["GetProviderInformationById"]!["check_in_time"]! === NSNull()) ? "" : data["GetProviderInformationById"]!["check_in_time"] as! String
            
            self.checkOutTxt.text = (data["GetProviderInformationById"]!["check_out_time"]! === NSNull()) ? "" : data["GetProviderInformationById"]!["check_out_time"] as! String
            
            self.distanceCityTxt.text = (data["GetProviderInformationById"]!["distance_from_city_center"]! === NSNull()) ? "" : data["GetProviderInformationById"]!["distance_from_city_center"] as! String
            
            self.DistanceAirportTxt.text = (data["GetProviderInformationById"]!["distance_to_airport"]! === NSNull()) ? "" : data["GetProviderInformationById"]!["distance_to_airport"] as! String
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
