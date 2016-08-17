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

class InformationVC: UIViewController, CustomIOS7AlertViewDelegate ,UITextFieldDelegate,UIPickerViewDelegate , UIPickerViewDataSource ,UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate ,UINavigationControllerDelegate ,UIAccelerometerDelegate {
    let width = UIScreen.mainScreen().bounds.size.width
    let height = UIScreen.mainScreen().bounds.size.height
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var provinceID = Int()
    let send = API_Model()
    //var pickerPick = false
    //var mediaKey:String!
    var facilitiesAttached:[[String:String]] = []
    
    var facilitiesHotelAttached = [String]()
    var selectedBookable = "0"
    
    @IBOutlet var lblTitleHeader: UILabel!
    @IBOutlet var lblAddHotelfac: UILabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var hotelFacListView: UIView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var imgHotelCover: UIImageView!
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
    
    @IBOutlet var totalResTxt: UITextField!
    @IBOutlet var totalBarTxt: UITextField!
    
    @IBOutlet var checkInTxt: UITextField!
    @IBOutlet var checkInTitle: UILabel!
    @IBOutlet var checkOutTxt: UITextField!
    @IBOutlet var checkOutTitle: UILabel!
    @IBOutlet var checkInView: UIView!
    @IBOutlet var checkOutView: UIView!
    
    @IBOutlet var btnAddFac: UIButton!
    
    @IBOutlet var distanceCityTxt: UITextField!
    @IBOutlet var DistanceAirportTxt: UITextField!
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var checkinPicker: UIDatePicker!
    @IBOutlet var checkoutPicker: UIDatePicker!
    @IBOutlet var timetoairportPicker: UIDatePicker!
    
    @IBOutlet var lblAirport: UILabel!
    @IBOutlet var txtTimeToAirport: UITextField!
    
    @IBOutlet var _viewEmptyCover: UIView!
    @IBOutlet var _viewEmptyLogo: UIView!
    
    // Bookable
    @IBOutlet weak var btnBookableYes: UIButton!
    @IBOutlet weak var btnBookableNo: UIButton!
    @IBOutlet weak var imgBookableYes: UIImageView!
    @IBOutlet weak var imgBookableNo: UIImageView!
    @IBOutlet weak var lblBookableYes: UILabel!
    @IBOutlet weak var lblBookableNo: UILabel!
    
    @IBAction func btnBookableYesClick(sender: AnyObject) {
        selectedBookable = "1"
        print("selectedBookable : \(selectedBookable)")
        UIView.animateWithDuration(0.25, animations: {_ in
            
            self.lblBookableYes.textColor = UIColor.blackColor()
            self.lblBookableNo.textColor = UIColor.grayColor()
            self.imgBookableYes.image = UIImage(named: "check.png")
            self.imgBookableNo.image = UIImage(named: "uncheck.png")

        })
    }
    
    @IBAction func btnBookableNoClick(sender: AnyObject) {
        selectedBookable = "0"
        print("selectedBookable : \(selectedBookable)")
        UIView.animateWithDuration(0.25, animations: {_ in
            
            self.lblBookableYes.textColor = UIColor.grayColor()
            self.lblBookableNo.textColor = UIColor.blackColor()
            self.imgBookableYes.image = UIImage(named: "uncheck.png")
            self.imgBookableNo.image = UIImage(named: "check.png")
            
        })
        
    }
    
    
    var button = UIButton()
    
    var SCALING_Y = (1024.0/480.0)
    var SCALING_X = (768.0/360.0)
    
    let myPickerController = UIImagePickerController()
    
    @IBAction func addHotelFacilityBtn(sender: AnyObject) {
        
        self.initalertView()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("View Did Load")
        self.view.bounds.size = CGSizeMake(UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height)
        
        myPickerController.delegate = self
        
        checkinPicker.hidden = true
        checkinPicker.backgroundColor = UIColor.whiteColor()
        checkinPicker.addTarget(self, action: #selector(InformationVC.checkinPickerChanged(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
        checkoutPicker.hidden = true
        checkoutPicker.backgroundColor = UIColor.whiteColor()
        checkoutPicker.addTarget(self, action: #selector(InformationVC.checkoutPickerChanged(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
        timetoairportPicker.hidden = true
        timetoairportPicker.backgroundColor = UIColor.whiteColor()
        timetoairportPicker.addTarget(self, action: #selector(InformationVC.timeToAirportPickerChanged(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.hidden = true
        
        
        self.setObject()
        self.getFacility()
        self.getProviderByID()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        checkOutTxt.delegate = self
        checkInTxt.delegate = self
        txtTimeToAirport.delegate = self
        
        checkinPicker.datePickerMode = UIDatePickerMode.Time
        checkinPicker.locale = NSLocale(localeIdentifier: "TH")
        checkoutPicker.datePickerMode = UIDatePickerMode.Time
        checkoutPicker.locale = NSLocale(localeIdentifier: "TH")
        timetoairportPicker.datePickerMode = UIDatePickerMode.Time
        timetoairportPicker.locale = NSLocale(localeIdentifier: "TH")
        
        //
        
        //        print("province Data \(provinceData)")
        print("province Delegate \(appDelegate.provinceName)")
        
        //hide keybord when tap view
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(InformationVC.dismissKeyboard))
        self.view!.addGestureRecognizer(tap)
        
        self.initailLogoImage()
    }
    override func viewDidDisappear(animated: Bool) {
        print("viewDidDisappear(hotelInfo)")
    }
    func initailLogoImage(){
        
        self._viewEmptyCover.userInteractionEnabled = false
        self._viewEmptyLogo.userInteractionEnabled = false
        
        if let logo = self.appDelegate.providerData!["ListProviderInformationSummary"]![self.appDelegate.providerIndex!]["images"]!!["logo_image"]!!["extra-small"]{
            print("has LOGO : \(self.appDelegate.providerData!["ListProviderInformationSummary"]![self.appDelegate.providerIndex!]["images"]!!["logo_image"]!)")
            
            if let imgData = NSData(contentsOfURL:NSURL(string:logo as! String)!) as NSData? {
                self.imgHotelLogo.image = UIImage(data:imgData)
                self._viewEmptyLogo.hidden = true
            }else{
                self.imgHotelLogo.image = UIImage()
                self._viewEmptyLogo.hidden = false
            }
            
//            self.imgHotelLogo.image = UIImage(data:NSData(contentsOfURL:NSURL(string:logo as! String)!)!)
//            self._viewEmptyLogo.hidden = true
        }else{
            print("no logo")
            self.imgHotelLogo.image = UIImage()
            self._viewEmptyLogo.hidden = false
        }
        
        
        if let cover = self.appDelegate.providerData!["ListProviderInformationSummary"]![self.appDelegate.providerIndex!]["images"]!!["cover_image"]!!["small"]{
            print("has cover : \(self.appDelegate.providerData!["ListProviderInformationSummary"]![self.appDelegate.providerIndex!]["images"]!!["cover_image"]!)")
            
            if let imgData = NSData(contentsOfURL:NSURL(string:cover as! String)!) as NSData? {
                self.imgHotelCover.image = UIImage(data:imgData)
                self._viewEmptyCover.hidden = true
            }else{
                self.imgHotelCover.image = UIImage()
                self._viewEmptyCover.hidden = false
            }
//            self.imgHotelCover.image = UIImage(data:NSData(contentsOfURL:NSURL(string:cover as! String)!)!)
//            self._viewEmptyCover.hidden = true
        }else{
            print("no cover")
            self.imgHotelCover.image = UIImage()
            self._viewEmptyCover.hidden = false
        }
        
    }
    
    func checkinPickerChanged(datePicker:UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        print("checkinPickerChanged")
        dateFormatter.dateStyle = NSDateFormatterStyle.NoStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        dateFormatter.dateFormat = "HH:mm"
        let strCheckin = dateFormatter.stringFromDate(datePicker.date)
        // let strCheckout = dateFormatter.stringFromDate(datePicker.date)
        checkInTxt.text = strCheckin
        // checkinPicker.hidden = true
        
    }
    
    func checkoutPickerChanged(datePicker:UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.NoStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        dateFormatter.dateFormat = "HH:mm"
        let strCheckout = dateFormatter.stringFromDate(datePicker.date)
        // let strCheckout = dateFormatter.stringFromDate(datePicker.date)
        checkOutTxt.text = strCheckout
        // checkoutPicker.hidden = true
        
    }
    
    func timeToAirportPickerChanged(datePicker:UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.NoStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        dateFormatter.dateFormat = "HH:mm"
        let str = dateFormatter.stringFromDate(datePicker.date)
        // let strCheckout = dateFormatter.stringFromDate(datePicker.date)
        txtTimeToAirport.text = str
        // checkoutPicker.hidden = true
        
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
        //        PKHUD.sharedHUD.hide(afterDelay: 2.0)
        
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
                "isBookable": selectedBookable,
                "touchbookingpaymentMerchantAccountKeycode": "",
                "wifiAvailable": "",
                "parkingAvailable": "",
                "totalRoom": totalRoomTxt.text!,
                "openDaily": "",
                "distanceFromCityCenter": distanceCityTxt.text!,
                "distanceToAirport": DistanceAirportTxt.text!,
                "nonSmokingZone": "",
                "numberOfBar": totalBarTxt.text!,
                "numberOfFloors": totalFloorTxt.text!,
                "numberOfRestaurants": totalResTxt.text!,
                "timeToAirport": txtTimeToAirport.text!
            ],
            "user" : [
                "accessToken" : appDelegate.userInfo["accessToken"]!
            ]
        ]
        
        let dataJson = send.Dict2JsonString(dataDic)
        
        print("dataDic:\(dataDic)")
        print("\n-----------------------------\n")
        print("data Send Json(information) :\(dataJson)")
        print("\n-----------------------------\n")
        print("Json Encode :\(send.jsonEncode(dataJson))")
        print("\n-----------------------------\n")
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
                    //PKHUD.sharedHUD.hide(afterDelay: 0.5)
                    //                        PKHUD.sharedHUD.hide(animated: false, completion: nil)
                    
                    // let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("providerlist")
                    // secondViewController?.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
                    //self.navigationController?.pushViewController(secondViewController!, animated: true)
                    //self.dismissViewControllerAnimated(true, completion: nil)
                    
                    self.appDelegate.viewWithTopButtons.hidden = true
                    
                    
                    PKHUD.sharedHUD.hide(false, completion: {action in
                        let alert = SCLAlertView()
                        alert.showCircularIcon = false
                        alert.showCloseButton = false
                        alert.addButton("Done", action: {action in
//                            self.navigationController?.popViewControllerAnimated(true)
//                            self.dismissViewControllerAnimated(true, completion: nil)

                        })
                        //alert.showError(, subTitle: )
                        alert.showError("Information", subTitle: "Update Success!")
                    })
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
                    
                    
                    // HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH
                    print(data["facilitiesAttached"]![i]["facility_keyname"])
                    //print("CountWTF : \(self.appDelegate.facilityHotelDic!["facilities"]!.count)")
                    
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
                    // HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH
                    
                    print("==========  facilitiesAttached  =========")
                    print("=========================================")
                    //print(data["facilitiesAttached"]![i])
                    print("=========================================")
                    
                    
                    //self.facilitiesHotelAttached.append(data["facilitiesAttached"]![i]["facility_keyname"] as! String)
                    self.facilitiesHotelAttached.append(data["facilitiesAttached"]![i]["facility_keyname"] as! String)
                }
            }
            self.tableView.reloadData()
        }
        
        print("all facility hotel \(appDelegate.facilityHotelDic)")
        
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
        txtTimeToAirport.resignFirstResponder()
        distanceCityTxt.resignFirstResponder()
        DistanceAirportTxt.resignFirstResponder()
        
        HotelDesTxt.resignFirstResponder()
        addressTxt.resignFirstResponder()
        phonNumberTxt.resignFirstResponder()
        pickerView.hidden = true
        checkinPicker.hidden = true
        checkoutPicker.hidden = true
        timetoairportPicker.hidden = true
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
        
        let borderColorCG = UIColor(red: 0.13, green: 0.14, blue: 0.18, alpha: 0.2).CGColor
        
        self.scrollView.frame.size.width = self.view.frame.size.width
        
        lblTitleHeader.layer.bounds.size.width = width
        lblTitleHeader.center.x = width/2
        
        imgHotelCover.layer.cornerRadius = 0
        imgHotelCover.layer.borderWidth = 1
        imgHotelCover.layer.borderColor = borderColorCG
        imgHotelCover.layer.bounds.size.width = width - 10
        imgHotelCover.center.x = width/2
        
        _viewEmptyCover.center.x = width/2
        
        imgHotelLogo.layer.cornerRadius = 0
        imgHotelLogo.layer.borderWidth = 1
        imgHotelLogo.layer.borderColor = borderColorCG
        
        txtHotelName.borderStyle = UITextBorderStyle.None
        txtHotelName.center.x = width/2
        txtHotelName.layer.bounds.size.width = width - 10
        txtHotelName.layer.borderWidth = 1
        txtHotelName.layer.borderColor = borderColorCG
        
        HotelDesTxt.center.x = width/2
        HotelDesTxt.layer.bounds.size.width = width - 10
        HotelDesTxt.layer.borderWidth = 1
        HotelDesTxt.layer.borderColor = borderColorCG
        
        
        phonNumberTxt.borderStyle = UITextBorderStyle.None
        phonNumberTxt.center.x = width/2
        phonNumberTxt.layer.bounds.size.width = width - 10
        phonNumberTxt.layer.borderWidth = 1
        phonNumberTxt.layer.borderColor = borderColorCG
        
        emailTxt.borderStyle = UITextBorderStyle.None
        emailTxt.center.x = width/2
        emailTxt.layer.bounds.size.width = width - 10
        emailTxt.layer.borderWidth = 1
        emailTxt.layer.borderColor = borderColorCG
        
        websiteTxt.borderStyle = UITextBorderStyle.None
        websiteTxt.center.x = width/2
        websiteTxt.layer.bounds.size.width = width - 10
        websiteTxt.layer.borderWidth = 1
        websiteTxt.layer.borderColor = borderColorCG
        
        provinceTxt.borderStyle = UITextBorderStyle.None
        provinceTxt.center.x = width/2
        provinceTxt.layer.bounds.size.width = width - 10
        provinceTxt.layer.borderWidth = 1
        provinceTxt.layer.borderColor = borderColorCG
        
        addressTxt.center.x = width/2
        addressTxt.layer.bounds.size.width = width - 10
        addressTxt.layer.borderWidth = 1
        addressTxt.layer.borderColor = borderColorCG
        
        hotelFacListView.center.x = width/2
        hotelFacListView.layer.bounds.size.width = width - 10
        hotelFacListView.layer.borderWidth = 1
        hotelFacListView.layer.borderColor = borderColorCG
        
        tableView.center.x = hotelFacListView.layer.bounds.size.width/2
        tableView.layer.bounds.size.width = hotelFacListView.layer.bounds.size.width - 10
        
        lblAddHotelfac.layer.bounds.size.width = 265
        lblAddHotelfac.frame.origin.x = 10
        
        totalRoomTxt.borderStyle = UITextBorderStyle.None
        totalRoomTxt.layer.bounds.size.width = width/2 - 10
        totalRoomTxt.center.x = (width/2)/2
        totalRoomTxt.layer.borderWidth = 1
        totalRoomTxt.layer.borderColor = borderColorCG
        
        totalFloorTxt.borderStyle = UITextBorderStyle.None
        totalFloorTxt.layer.bounds.size.width = width/2 - 10
        totalFloorTxt.center.x = width - width/4
        totalFloorTxt.layer.borderWidth = 1
        totalFloorTxt.layer.borderColor = borderColorCG
        
        totalResTxt.borderStyle = UITextBorderStyle.None
        totalResTxt.layer.bounds.size.width = width/2 - 10
        totalResTxt.center.x = (width/2)/2
        totalResTxt.layer.borderWidth = 1
        totalResTxt.layer.borderColor = borderColorCG
        
        
        totalBarTxt.borderStyle = UITextBorderStyle.None
        totalBarTxt.layer.bounds.size.width = width/2 - 10
        totalBarTxt.center.x = width - width/4
        totalBarTxt.layer.borderWidth = 1
        totalBarTxt.layer.borderColor = borderColorCG
        
        checkInView.center.x = (width/2)/2
        checkInView.layer.bounds.size.width = width/2 - 10
        checkInView.layer.borderWidth = 1
        checkInView.layer.borderColor = borderColorCG
        checkInTitle.center.x = (width/2)/2
        checkOutTitle.center.x = (width/2)/2
        
        checkInTxt.center.x = (width/2)/2
        checkOutTxt.center.x = (width/2)/2
        
        checkInTxt.layer.borderWidth = 0
        checkOutTxt.layer.borderWidth = 0
        
        checkOutView.center.x =  width - width/4
        checkOutView.layer.bounds.size.width = width/2 - 10
        checkOutView.layer.borderWidth = 1
        checkOutView.layer.borderColor = borderColorCG
        
        distanceCityTxt.borderStyle = UITextBorderStyle.None
        distanceCityTxt.center.x = (width/2)/2+15
        distanceCityTxt.layer.bounds.size.width = width/2 - 60
        distanceCityTxt.layer.borderWidth = 1
        distanceCityTxt.layer.borderColor = borderColorCG
        
        lblAirport.frame = CGRectMake(distanceCityTxt.frame.origin.x + distanceCityTxt.frame.size.width + 5, distanceCityTxt.frame.origin.y, width/2 - 60, distanceCityTxt.frame.size.height)
        
        DistanceAirportTxt.borderStyle = UITextBorderStyle.None
        DistanceAirportTxt.center.x = width - width/5
        DistanceAirportTxt.layer.bounds.size.width = width/2 - 60
        DistanceAirportTxt.layer.borderWidth = 1
        DistanceAirportTxt.layer.borderColor = borderColorCG
        
        
        var frmBtnAddFac = btnAddFac.frame
        frmBtnAddFac.origin.x = hotelFacListView.frame.size.width - frmBtnAddFac.size.width
        btnAddFac.frame = frmBtnAddFac
        
        
        var frmButtonSave = buttonsave.frame
        frmButtonSave.size.width = self.view.frame.size.width //  - 12
        frmButtonSave.origin.x = 0
        frmButtonSave.origin.y = self.view.frame.size.height - frmButtonSave.size.height
        buttonsave.frame = frmButtonSave
        
        
        pickerView.center.y = UIScreen.mainScreen().bounds.height - 250
        checkinPicker.center.y = UIScreen.mainScreen().bounds.height - 250
        checkoutPicker.center.y = UIScreen.mainScreen().bounds.height - 250
        timetoairportPicker.center.y = UIScreen.mainScreen().bounds.height - 250
        
        pickerView.frame.origin.x = 0
        checkinPicker.frame.origin.x = 0
        checkoutPicker.frame.origin.x = 0
        timetoairportPicker.frame.origin.x = 0
        
        pickerView.frame.size.width = self.view.frame.size.width
        checkinPicker.frame.size.width = self.view.frame.size.width
        checkoutPicker.frame.size.width = self.view.frame.size.width
        timetoairportPicker.frame.size.width = self.view.frame.size.width
        
        let navBarHeight:CGFloat = 44.0
        var frmScrollView = scrollView.frame
        frmScrollView.origin.y = 0
        frmScrollView.size.height = UIScreen.mainScreen().bounds.height - (navBarHeight + 54 + 46) // - 10
        scrollView.frame = frmScrollView
        
        self.scrollView.frame.origin.y = 0
        self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 1544)
        
        print("statusBarFrame = \(UIApplication.sharedApplication().statusBarFrame.height)")
        print("nav = \(self.navigationController?.navigationBar.frame.size.height)")
        print("view = \(self.view.frame.size.height)")
        print("UIScreen = \(UIScreen.mainScreen().applicationFrame)")
        print("scrollView = \(self.scrollView.frame.size.height)")
        
    }
    
    override func viewWillAppear(animated: Bool) {
        //self.viewDidLoad()
        //self.viewDidAppear(true)
        super.viewWillAppear(true)
        
        //self.setObject()
        
        
        let tapAddCover = UITapGestureRecognizer(target:self, action:#selector(InformationVC.imageTapped(_:)))
        imgHotelCover.userInteractionEnabled = true
        imgHotelCover.tag = 1
        imgHotelCover.addGestureRecognizer(tapAddCover)
        
        let tapAddLogo = UITapGestureRecognizer(target:self, action:#selector(InformationVC.imageTapped(_:)))
        imgHotelLogo.userInteractionEnabled = true
        imgHotelLogo.tag = 2
        imgHotelLogo.addGestureRecognizer(tapAddLogo)
        //self.scrollView.addSubview(self.imgHotelLogo)
        
        
        
        //        scrollView.contentSize = CGSizeMake(width,2180)
        
        print("scrollwidth = \(scrollView.layer.bounds.size.width)")
        // scrollView.layer.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1).CGColor
        
        
        //hide keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(InformationVC.dismissKeyboard))
        self.view!.addGestureRecognizer(tap)
        
        let pickerTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(InformationVC.dismissKeyboard2))
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
        //print("Logooooo \((appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["images"]!!["logo_image"]))");
        //self.imgHotelLogo.image = UIImage(named: "bg_cctvdefault.png")
        
        
        
        
        
//        totalRoomTxt.text = (appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["total_room"]! as! String)
//        
//        
//        totalFloorTxt.text = (appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["number_of_floors"]! as! String)
//        
//        totalResTxt.text =  (appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["number_of_restaurants"]! as! String)
//        
//        
//        totalBarTxt.text = (appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["number_of_bar"]! as! String)
//        
//        
//        checkInTxt.text =  (appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["checkInTime"]! as! String)
//        
//        checkOutTxt.text =  (appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["checkOutTime"]! as! String)
//        
//        distanceCityTxt.text = (appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["distanceFromCityCenter"]! as! String)
//        
//        DistanceAirportTxt.text =  (appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["address_en"]! as! String)
//        
//        txtTimeToAirport.text = (appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["distanceToAirport"]! as! String)

        
        
        
        
        
        
    
    
        
        
        
        //                    if(pickerPick == false){
        //
        //                    }
        //                    else{
        //
        //                         self.imgHotelLogo.image = UIImage(named: "bg_cctvdefault.png")
        //                     self.imgHotelLogo.image = UIImage(data: NSData(contentsOfURL: NSURL(string: self.appDelegate.providerData!["ListProviderInformationSummary"]![self.appDelegate.providerIndex!]["images"]!!["logo_image"]!!["small"] as! String)!)!)
        //                    }
        
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    func textFieldShouldBeginEditing(textField:UITextField) -> Bool {
        
        if(textField == provinceTxt){
            
            self.view.endEditing(true)
            pickerView.hidden = false
            txtHotelName.resignFirstResponder()
            emailTxt.resignFirstResponder()
            websiteTxt.resignFirstResponder()
            provinceTxt.resignFirstResponder()
            totalRoomTxt.resignFirstResponder()
            totalFloorTxt.resignFirstResponder()
            checkInTxt.resignFirstResponder()
            checkOutTxt.resignFirstResponder()
            txtTimeToAirport.resignFirstResponder()
            distanceCityTxt.resignFirstResponder()
            DistanceAirportTxt.resignFirstResponder()
            
            HotelDesTxt.resignFirstResponder()
            addressTxt.resignFirstResponder()
            phonNumberTxt.resignFirstResponder()
            
            return false
            
        }
        else if(textField == checkInTxt){
            self.view.endEditing(true)
            checkinPicker.hidden = false
            checkoutPicker.hidden = true
            timetoairportPicker.hidden = true
            txtHotelName.resignFirstResponder()
            emailTxt.resignFirstResponder()
            websiteTxt.resignFirstResponder()
            provinceTxt.resignFirstResponder()
            totalRoomTxt.resignFirstResponder()
            totalFloorTxt.resignFirstResponder()
            checkInTxt.resignFirstResponder()
            checkOutTxt.resignFirstResponder()
            txtTimeToAirport.resignFirstResponder()
            distanceCityTxt.resignFirstResponder()
            DistanceAirportTxt.resignFirstResponder()
            
            HotelDesTxt.resignFirstResponder()
            addressTxt.resignFirstResponder()
            phonNumberTxt.resignFirstResponder()
            
            return false
        }
        else if(textField == checkOutTxt){
            
            self.view.endEditing(true)
            checkoutPicker.hidden = false
            checkinPicker.hidden = true
            timetoairportPicker.hidden = true
            txtHotelName.resignFirstResponder()
            emailTxt.resignFirstResponder()
            websiteTxt.resignFirstResponder()
            provinceTxt.resignFirstResponder()
            totalRoomTxt.resignFirstResponder()
            totalFloorTxt.resignFirstResponder()
            checkInTxt.resignFirstResponder()
            checkOutTxt.resignFirstResponder()
            txtTimeToAirport.resignFirstResponder()
            distanceCityTxt.resignFirstResponder()
            DistanceAirportTxt.resignFirstResponder()
            
            HotelDesTxt.resignFirstResponder()
            addressTxt.resignFirstResponder()
            phonNumberTxt.resignFirstResponder()
            return false
        }
        else if(textField == txtTimeToAirport){
            
            self.view.endEditing(true)
            checkoutPicker.hidden = true
            checkinPicker.hidden = true
            timetoairportPicker.hidden = false
            txtHotelName.resignFirstResponder()
            emailTxt.resignFirstResponder()
            websiteTxt.resignFirstResponder()
            provinceTxt.resignFirstResponder()
            totalRoomTxt.resignFirstResponder()
            totalFloorTxt.resignFirstResponder()
            checkInTxt.resignFirstResponder()
            checkOutTxt.resignFirstResponder()
            txtTimeToAirport.resignFirstResponder()
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
                //PKHUD.sharedHUD.contentView = PKHUDProgressView()
                PKHUD.sharedHUD.show()
                //PKHUD.sharedHUD.hide(afterDelay: 1.0)
        
                let send = API_Model()
                print("providerId:::\(appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["provider_id"])")
        
                let dataJson = "{\"providerId\":\"\(appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["provider_id"] as! String)\"}"
                send.providerAPI(self.appDelegate.command["GetProviderInformationById"]!, dataJson: dataJson) {
                    data in
                    print("getProviderByID \(data)")
//                    PKHUD.sharedHUD.contentView = PKHUDSuccessView()
                    //PKHUD.sharedHUD.hide(afterDelay: 1.0)
                    PKHUD.sharedHUD.hide(false)
                    
        //            print("providerDataID \(data["GetProviderInformationById"]!["total_room"])")
        
                    self.totalRoomTxt.text = (data["GetProviderInformationById"]!["total_room"]! === NSNull()) ? "" : data["GetProviderInformationById"]!["total_room"] as! String
                    self.totalFloorTxt.text = (data["GetProviderInformationById"]!["number_of_floors"]! === NSNull()) ? "" : data["GetProviderInformationById"]!["number_of_floors"] as! String
                    self.distanceCityTxt.text = (data["GetProviderInformationById"]!["distance_from_city_center"]! === NSNull()) ? "" : data["GetProviderInformationById"]!["distance_from_city_center"] as! String
                    self.DistanceAirportTxt.text = (data["GetProviderInformationById"]!["distance_to_airport"]! === NSNull()) ? "" : data["GetProviderInformationById"]!["distance_to_airport"] as! String
                    self.totalResTxt.text = (data["GetProviderInformationById"]!["number_of_restaurants"]! === NSNull()) ? "" : data["GetProviderInformationById"]!["number_of_restaurants"] as! String
                    self.totalBarTxt.text = (data["GetProviderInformationById"]!["number_of_bar"]! === NSNull()) ? "" : data["GetProviderInformationById"]!["number_of_bar"] as! String
                    self.txtTimeToAirport.text = (data["GetProviderInformationById"]!["time_to_airport"]! === NSNull()) ? "" : data["GetProviderInformationById"]!["time_to_airport"] as! String
                    
                    
//                    self.checkInTxt.text = (data["GetProviderInformationById"]!["check_in_time"]! === NSNull()) ? "" : data["GetProviderInformationById"]!["check_in_time"] as! String
//                    
//                    self.checkOutTxt.text = (data["GetProviderInformationById"]!["check_out_time"]! === NSNull()) ? "" : data["GetProviderInformationById"]!["check_out_time"] as! String

                    if var checkIn = data["GetProviderInformationById"]!["check_in_time"]{
                        let myNSString = checkIn as! NSString
                        
                        checkIn = myNSString.substringWithRange(NSRange(location: 0, length: 5))
                    
                        self.checkInTxt.text = checkIn as? String
                        let dateFormatter = NSDateFormatter()
                        dateFormatter.dateStyle = NSDateFormatterStyle.NoStyle
                        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
                        dateFormatter.dateFormat = "HH:mm"
                        let date = dateFormatter.dateFromString(checkIn as! String)
                        if let unwrappedDate = date {
                            self.checkoutPicker.setDate(unwrappedDate, animated: false)
                        }
                        
                    }else{
                        self.checkInTxt.text = "00:00"
                    }
                    
                    if var checkOut = data["GetProviderInformationById"]!["check_out_time"]{
                        let myNSString = checkOut as! NSString
                        
                        checkOut = myNSString.substringWithRange(NSRange(location: 0, length: 5))
                        
                        self.checkOutTxt.text = checkOut as? String
                        let dateFormatter = NSDateFormatter()
                        dateFormatter.dateStyle = NSDateFormatterStyle.NoStyle
                        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
                        dateFormatter.dateFormat = "HH:mm"
                        let date = dateFormatter.dateFromString(checkOut as! String)
                        if let unwrappedDate = date {
                            self.checkoutPicker.setDate(unwrappedDate, animated: false)
                        }
                        
                    }else{
                        self.checkOutTxt.text = "00:00"
                    }

                    print("Booooook \(data["GetProviderInformationById"]!["is_bookable"] as! String)")
                    
                    if let isBookable = data["GetProviderInformationById"]!["is_bookable"]{
                        if(isBookable === NSNull()){
                            self.selectedBookable = "0"
                            self.lblBookableYes.textColor = UIColor.grayColor()
                            self.lblBookableNo.textColor = UIColor.blackColor()
                            self.imgBookableYes.image = UIImage(named: "uncheck.png")
                            self.imgBookableNo.image = UIImage(named: "check.png")
                        }else{
                            if ((isBookable as! String) == "1" || (isBookable as! String) == "yes"){
                                print("Yesssssssssss")
                                self.selectedBookable = "1"
                                self.lblBookableYes.textColor = UIColor.blackColor()
                                self.lblBookableNo.textColor = UIColor.grayColor()
                                self.imgBookableYes.image = UIImage(named: "check.png")
                                self.imgBookableNo.image = UIImage(named: "uncheck.png")
                                
                            }else{
                                self.selectedBookable = "0"
                                self.lblBookableYes.textColor = UIColor.grayColor()
                                self.lblBookableNo.textColor = UIColor.blackColor()
                                self.imgBookableYes.image = UIImage(named: "uncheck.png")
                                self.imgBookableNo.image = UIImage(named: "check.png")
                                
                                
                            }
                            
                        }

                    }

                    PKHUD.sharedHUD.hide(false)
                    
                }
        
    }
    
    var _pickerType = ""
    func imageTapped(sender: AnyObject){
        //        print("Upload Logo Img")
        let _gg = sender as! UITapGestureRecognizer
        let tag = Int((_gg.view?.tag)!)
        print(tag)
        
        if(tag == 1){
            _pickerType = "cover"
        }else if(tag == 2){
            _pickerType = "logo"
        }
        //        print("---------")
        
        myPickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        myPickerController.allowsEditing = false
        self.presentViewController(myPickerController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        PKHUD.sharedHUD.dimsBackground = false
        PKHUD.sharedHUD.userInteractionOnUnderlyingViewsEnabled = false
        PKHUD.sharedHUD.contentView = PKHUDProgressView()
        
        print("ImagePicker")
        var chosenImage = (info[UIImagePickerControllerOriginalImage] as? UIImage)!
        var _imageType = ""
        if(_pickerType == "cover"){
            
            print("cover")
            // upload Cover
            self._viewEmptyCover.hidden = true
            self.imgHotelCover.contentMode = .ScaleAspectFill
            self.imgHotelCover.image = chosenImage
            _imageType = "coverImage"
            
        }else if(_pickerType == "logo"){
            print("logo")
            
            // Upload LOGO
            self._viewEmptyLogo.hidden = true
            self.imgHotelLogo.contentMode = .ScaleAspectFill
            self.imgHotelLogo.image = chosenImage
            _imageType = "logoImage"
            
        }
        
        let imageURL = info[UIImagePickerControllerReferenceURL] as! NSURL
        let imageName = imageURL.pathComponents![1];
        print("imageURL : \(imageURL)")
        print("imageName : \(imageName)")
        //pickerPick = true
        //        imgHotelLogo.reloadInputViews()
        
        PKHUD.sharedHUD.show()
        self.dismissViewControllerAnimated(true, completion:{_ in
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                
                    let send = API_Model()
                    send.getUploadKey(Int(self.appDelegate.providerData!["ListProviderInformationSummary"]![self.appDelegate.providerIndex!]["provider_id"]! as! String)!,imageType: _imageType,imageName: imageName){
                        _mediaKey in
                        
//                        print("UPLOAD DATA ::: \(data)")
//                        self.mediaKey = data
                        
                        chosenImage = FileMan().resizeImage(chosenImage, maxSize: 1500)
                        
                        send.uploadImage(_mediaKey, image: chosenImage, imageName: imageName){
                            data in
                            
                            dispatch_async(dispatch_get_main_queue()) {
                                if(self._pickerType == "cover"){
                                    print("cover")
                                    //let _coverServer = data["debug"]!["total_room"]!["sssss"]
                                    let _coverLocal = self.appDelegate.providerData!["ListProviderInformationSummary"]![self.appDelegate.providerIndex!]["images"]!!["cover_image"]!!["small"]
                                    
                                    print("_coverLocal = \(_coverLocal)")
                                    self.imgHotelCover.image = chosenImage
                                    
                                }else if(self._pickerType == "logo"){
                                    print("logo")
                                    let _logoLocal = self.appDelegate.providerData!["ListProviderInformationSummary"]![self.appDelegate.providerIndex!]["images"]!!["logo_image"]!!["small"]
                                    print("_logoLocal = \(_logoLocal)")
                                    
                                    self.imgHotelLogo.image = chosenImage
                                }
                                PKHUD.sharedHUD.hide(animated: true, completion: nil)
                            }
                  
                        }
                    }
            }
            
        })
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        print("imagePickerControllerDidCancel")
        self.dismissViewControllerAnimated(true, completion: nil)
        //        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("providerinfo") as! ProviderInfoVC
        //        self.navigationController?.pushViewController(vc, animated:true)
        //        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
}
