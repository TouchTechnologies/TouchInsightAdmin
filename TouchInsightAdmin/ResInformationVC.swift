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

class ResInformationVC: UIViewController, CustomIOS7AlertViewDelegate ,UITextFieldDelegate,UIPickerViewDelegate , UIPickerViewDataSource ,UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate ,UINavigationControllerDelegate ,UIAccelerometerDelegate{
    let width = UIScreen.mainScreen().bounds.size.width
    let height = UIScreen.mainScreen().bounds.size.height
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var provinceID = Int()
    let send = API_Model()
    var pickerPick = false
    //var mediaKey:String!
    var facilitiesAttached:[[String:String]] = []
    
    var facilitiesResAttached = [String]()
    
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
    @IBOutlet var checkInTxt: UITextField!
    @IBOutlet var checkInTitle: UILabel!
    @IBOutlet var checkOutTxt: UITextField!
    @IBOutlet var checkOutTitle: UILabel!
    @IBOutlet var checkInView: UIView!
    @IBOutlet var checkOutView: UIView!
    
    @IBOutlet weak var btnAddFac: UIButton!
    
    @IBOutlet var _viewEmptyCover: UIView!
    @IBOutlet var _viewEmptyLogo: UIView!
    
    //
    //    @IBOutlet var distanceCityTxt: UITextField!
    //    @IBOutlet var DistanceAirportTxt: UITextField!
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var checkinPicker: UIDatePicker!
    @IBOutlet var checkoutPicker: UIDatePicker!
    
    //    @IBOutlet var lblAirport: UILabel!
    
    let myPickerController = UIImagePickerController()
    
    // Big Box ==========
    @IBOutlet weak var view_DateSet: UIView!
    //    @IBOutlet weak var viewDateArrow: UIView!
    
    @IBOutlet weak var view_BottomSet: UIView!
    
    
    // Open Daily
    @IBOutlet weak var img_AllDay: UIImageView!
    @IBOutlet weak var img_Weekly: UIImageView!
    @IBAction func btn_AllDayClick(sender: AnyObject) {
        
        print("self.scrollView.contentSize = \(self.scrollView.contentSize)")
        
        UIView.animateWithDuration(0.2, animations: {
            self.img_AllDay.image = UIImage(named: "check.png")
            self.img_Weekly.image = UIImage(named: "uncheck.png")
            
            self.view_DateSet.hidden = true
            self.view_BottomSet.frame.origin.y = 912
            self.selectedDay = ["su": "1", "tu": "1", "th": "1", "fr": "1", "we": "1", "sa": "1", "mo": "1"]
//            self.scrollView.contentSize = CGSizeMake(self.view.bounds.width, 1900)
            
            
            self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.width, 1454)
        })
        
    }
    
    @IBAction func btn_WeeklyClick(sender: AnyObject) {
        
        print("self.scrollView.contentSize = \(self.scrollView.contentSize)")
        
        UIView.animateWithDuration(0.2, animations: {
            self.img_Weekly.image = UIImage(named: "check.png")
            self.img_AllDay.image = UIImage(named: "uncheck.png")
            
            self.selectedDay = ["su": "0", "tu": "0", "th": "0", "fr": "0", "we": "0", "sa": "0", "mo": "0"]
            
            for (day,status) in self.selectedDay
            {
                switch day {
                case  "su":
                    self.day_su.image = (status == "0") ? UIImage(named: "su.png") : UIImage(named: "su_hover.png")
                case  "mo":
                    self.day_mo.image = (status == "0") ? UIImage(named: "mo.png") : UIImage(named: "mo_hover.png")
                case  "tu":
                    self.day_tu.image = (status == "0") ? UIImage(named: "tu.png") : UIImage(named: "tu_hover.png")
                case  "we":
                    self.day_we.image = (status == "0") ? UIImage(named: "we.png") : UIImage(named: "we_hover.png")
                case  "th":
                    self.day_th.image = (status == "0") ? UIImage(named: "th.png") : UIImage(named: "th_hover.png")
                case  "fr":
                    self.day_fr.image = (status == "0") ? UIImage(named: "fr.png") : UIImage(named: "fr_hover.png")
                case  "sa":
                    self.day_sa.image = (status == "0") ? UIImage(named: "sa.png") : UIImage(named: "sa_hover.png")
                default:
                    break;
                }
                
            }
            self.view_DateSet.hidden = false
            self.view_BottomSet.frame.origin.y = 984
            
            self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.width, 1526)
            
//            self.scrollView.contentSize = CGSizeMake(self.view.bounds.width, 1900)
        })
        
        
    }
    
    
    
    // Sub box ==========
    // Btn 24 Hour
    var is24Hour = true
    @IBOutlet weak var imgCheck24h: UIImageView!
    @IBAction func btn24Click(sender: AnyObject) {
        
        if ( is24Hour != true ) {
            
            setStatus24(true)
        }else{
            
            setStatus24(false)
        }
        
    }
    
    func setStatus24(val:Bool) {
        
        if ( val == true ) {
            
            self.checkInView.backgroundColor = UIColor(red:0.78, green:0.78, blue:0.78, alpha:1.00)
            self.checkOutView.backgroundColor = UIColor(red:0.78, green:0.78, blue:0.78, alpha:1.00)
            
            self.checkInTxt.backgroundColor = UIColor(red:0.78, green:0.78, blue:0.78, alpha:1.00)
            self.checkOutTxt.backgroundColor = UIColor(red:0.78, green:0.78, blue:0.78, alpha:1.00)
            
            self.checkInTxt.textColor = UIColor(red:0.61, green:0.61, blue:0.63, alpha:1.00)
            self.checkOutTxt.textColor = UIColor(red:0.61, green:0.61, blue:0.63, alpha:1.00)
            
            self.checkInTxt.enabled = false
            self.checkOutTxt.enabled = false
            
            is24Hour = true
            self.imgCheck24h.image = UIImage(named: "check.png")
            self.checkOutTxt.text = "00:00"
            self.checkInTxt.text = "00:00"
        }else{
            
            
            self.checkInView.backgroundColor = UIColor.whiteColor()
            self.checkOutView.backgroundColor = UIColor.whiteColor()
            
            self.checkInTxt.backgroundColor = UIColor.whiteColor()
            self.checkOutTxt.backgroundColor = UIColor.whiteColor()
            
            self.checkInTxt.textColor = UIColor.blackColor()
            self.checkOutTxt.textColor = UIColor.blackColor()
            
            self.checkInTxt.enabled = true
            self.checkOutTxt.enabled = true
            is24Hour = false
            self.imgCheck24h.image = UIImage(named: "uncheck.png")
            
        }

    }
    
    
    
    
    
    // Date Click
    @IBOutlet weak var superviewForDateSet: UIView!
    var selectedDay = [
        "mo":"0",
        "tu":"0",
        "we":"0",
        "th":"0",
        "fr":"0",
        "sa":"0",
        "su":"0"
    ]
    @IBOutlet weak var day_mo: UIImageView!
    @IBOutlet weak var day_tu: UIImageView!
    @IBOutlet weak var day_we: UIImageView!
    @IBOutlet weak var day_th: UIImageView!
    @IBOutlet weak var day_fr: UIImageView!
    @IBOutlet weak var day_sa: UIImageView!
    @IBOutlet weak var day_su: UIImageView!
    
    @IBOutlet weak var btn_day_mo: UIButton!
    @IBOutlet weak var btn_day_tu: UIButton!
    @IBOutlet weak var btn_day_we: UIButton!
    @IBOutlet weak var btn_day_th: UIButton!
    @IBOutlet weak var btn_day_fr: UIButton!
    @IBOutlet weak var btn_day_sa: UIButton!
    @IBOutlet weak var btn_day_su: UIButton!
    
    // Day Click
    @IBAction func day_mo_click(sender: AnyObject) {
        if(selectedDay["mo"] == "0"){
            selectedDay["mo"] = "1"
            day_mo.image = UIImage(named: "mo_hover.png")
        }else{
            selectedDay["mo"] = "0"
            day_mo.image = UIImage(named: "mo.png")
        }
        displaySelectedDay()
    }
    
    @IBAction func day_tu_click(sender: AnyObject) {
        
        if(selectedDay["tu"] == "0"){
            selectedDay["tu"] = "1"
            day_tu.image = UIImage(named: "tu_hover.png")
        }else{
            selectedDay["tu"] = "0"
            day_tu.image = UIImage(named: "tu.png")
        }
        displaySelectedDay()
    }
    
    @IBAction func day_we_click(sender: AnyObject) {
        
        if(selectedDay["we"] == "0"){
            selectedDay["we"] = "1"
            day_we.image = UIImage(named: "we_hover.png")
        }else{
            selectedDay["we"] = "0"
            day_we.image = UIImage(named: "we.png")
        }
        displaySelectedDay()
    }
    
    @IBAction func day_th_click(sender: AnyObject) {
        
        if(selectedDay["th"] == "0"){
            selectedDay["th"] = "1"
            day_th.image = UIImage(named: "th_hover.png")
        }else{
            selectedDay["th"] = "0"
            day_th.image = UIImage(named: "th.png")
        }
        displaySelectedDay()
    }
    
    @IBAction func day_fr_click(sender: AnyObject) {
        
        if(selectedDay["fr"] == "0"){
            selectedDay["fr"] = "1"
            day_fr.image = UIImage(named: "fr_hover.png")
        }else{
            selectedDay["fr"] = "0"
            day_fr.image = UIImage(named: "fr.png")
        }
        displaySelectedDay()
    }
    
    @IBAction func day_sa_click(sender: AnyObject) {
        
        if(selectedDay["sa"] == "0"){
            selectedDay["sa"] = "1"
            day_sa.image = UIImage(named: "sa_hover.png")
        }else{
            selectedDay["sa"] = "0"
            day_sa.image = UIImage(named: "sa.png")
        }
        displaySelectedDay()
    }
    
    @IBAction func day_su_click(sender: AnyObject) {
        
        if(selectedDay["su"] == "0"){
            selectedDay["su"] = "1"
            day_su.image = UIImage(named: "su_hover.png")
        }else{
            selectedDay["su"] = "0"
            day_su.image = UIImage(named: "su.png")
        }
        displaySelectedDay()
    }
    
    func displaySelectedDay() {
        print(selectedDay)
    }
    
    
    
    
    /////////////////// Restaurant Service
    // Wifi
    var selectedService = [
        "wifi":"0",
        "parking":"0",
        "smonking":"0",
        ]
    @IBOutlet weak var btnWifiServiceYes: UIButton!
    @IBOutlet weak var btnWifiServiceNo: UIButton!
    @IBOutlet weak var imgWifiServiceYes: UIImageView!
    @IBOutlet weak var imgWifiServiceNo: UIImageView!
    @IBOutlet weak var lblWifiServiceYes: UILabel!
    @IBOutlet weak var lblWifiServiceNo: UILabel!
    
    @IBAction func btnWifiServiceYesClick(sender: AnyObject) {
        print("btnWifiServiceYesClick")
        UIView.animateWithDuration(0.25, animations: {_ in
            self.selectedService["wifi"] = "1"
            self.lblWifiServiceYes.textColor = UIColor.blackColor()
            self.lblWifiServiceNo.textColor = UIColor.grayColor()
            self.imgWifiServiceYes.image = UIImage(named: "check.png")
            self.imgWifiServiceNo.image = UIImage(named: "uncheck.png")
            
        })
    }
    
    @IBAction func btnWifiServiceNoClick(sender: AnyObject) {
        print("btnWifiServiceNoClick")
        UIView.animateWithDuration(0.25, animations: {_ in
            self.selectedService["wifi"] = "0"
            self.lblWifiServiceYes.textColor = UIColor.grayColor()
            self.lblWifiServiceNo.textColor = UIColor.blackColor()
            self.imgWifiServiceYes.image = UIImage(named: "uncheck.png")
            self.imgWifiServiceNo.image = UIImage(named: "check.png")
            
        })
        
    }
    
    // Parking
    @IBOutlet weak var btnParkingServiceYes: UIButton!
    @IBOutlet weak var btnParkingServiceNo: UIButton!
    @IBOutlet weak var imgParkingServiceYes: UIImageView!
    @IBOutlet weak var imgParkingServiceNo: UIImageView!
    @IBOutlet weak var lblParkingServiceYes: UILabel!
    @IBOutlet weak var lblParkingServiceNo: UILabel!
    
    @IBAction func btnParkingServiceYesClick(sender: AnyObject) {
        print("btnParkingServiceYesClick")
        UIView.animateWithDuration(0.25, animations: {_ in
            self.selectedService["parking"] = "1"
            self.lblParkingServiceYes.textColor = UIColor.blackColor()
            self.lblParkingServiceNo.textColor = UIColor.grayColor()
            self.imgParkingServiceYes.image = UIImage(named: "check.png")
            self.imgParkingServiceNo.image = UIImage(named: "uncheck.png")
            
        })
    }
    
    @IBAction func btnParkingServiceNoClick(sender: AnyObject) {
        print("btnParkingServiceNoClick")
        UIView.animateWithDuration(0.25, animations: {_ in
            self.selectedService["parking"] = "0"
            self.lblParkingServiceYes.textColor = UIColor.grayColor()
            self.lblParkingServiceNo.textColor = UIColor.blackColor()
            self.imgParkingServiceYes.image = UIImage(named: "uncheck.png")
            self.imgParkingServiceNo.image = UIImage(named: "check.png")
            
        })
        
    }
    
    
    // Smonking
    @IBOutlet weak var btnSmonkingServiceYes: UIButton!
    @IBOutlet weak var btnSmonkingServiceNo: UIButton!
    @IBOutlet weak var imgSmonkingServiceYes: UIImageView!
    @IBOutlet weak var imgSmonkingServiceNo: UIImageView!
    @IBOutlet weak var lblSmonkingServiceYes: UILabel!
    @IBOutlet weak var lblSmonkingServiceNo: UILabel!
    
    @IBAction func btnSmonkingServiceYesClick(sender: AnyObject) {
        print("btnSmonkingServiceYesClick")
        UIView.animateWithDuration(0.25, animations: {_ in
            self.selectedService["smonking"] = "1"
            self.lblSmonkingServiceYes.textColor = UIColor.blackColor()
            self.lblSmonkingServiceNo.textColor = UIColor.grayColor()
            self.imgSmonkingServiceYes.image = UIImage(named: "check.png")
            self.imgSmonkingServiceNo.image = UIImage(named: "uncheck.png")
            
        })
    }
    
    @IBAction func btnSmonkingServiceNoClick(sender: AnyObject) {
        print("btnSmonkingServiceNoClick")
        UIView.animateWithDuration(0.25, animations: {_ in
            self.selectedService["smonking"] = "0"
            self.lblSmonkingServiceYes.textColor = UIColor.grayColor()
            self.lblSmonkingServiceNo.textColor = UIColor.blackColor()
            self.imgSmonkingServiceYes.image = UIImage(named: "uncheck.png")
            self.imgSmonkingServiceNo.image = UIImage(named: "check.png")
            
        })
        
    }
    
    
    
    /////////////////
    
    
    var button = UIButton()
    
    var SCALING_Y = (1024.0/480.0)
    var SCALING_X = (768.0/360.0)
    
    
    @IBAction func addHotelFacilityBtn(sender: AnyObject) {
        
        self.initalertView()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.viewDateArrow.transform = CGAffineTransformMakeRotation((45.0 * CGFloat(M_PI)) / 180.0)
        
        print("View Did Load")
        
        setStatus24(true)
        
       myPickerController.delegate = self
        
        //self.view.bounds.size = CGSizeMake(UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height)
        
        checkinPicker.hidden = true
        checkinPicker.backgroundColor = UIColor.whiteColor()
        checkinPicker.addTarget(self, action: #selector(ResInformationVC.checkinPickerChanged(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
        checkoutPicker.hidden = true
        checkoutPicker.backgroundColor = UIColor.whiteColor()
        checkoutPicker.addTarget(self, action: #selector(ResInformationVC.checkoutPickerChanged(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.hidden = true
        
        
        self.setObject()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        checkOutTxt.delegate = self
        checkInTxt.delegate = self
        
        checkinPicker.datePickerMode = UIDatePickerMode.Time
        checkinPicker.locale = NSLocale(localeIdentifier: "TH")
        checkoutPicker.datePickerMode = UIDatePickerMode.Time
        checkoutPicker.locale = NSLocale(localeIdentifier: "TH")
        //print("province Data \(provinceData)")
        print("province Delegate \(appDelegate.provinceName)")
        
        //hide keybord when tap view
        //        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ResInformationVC.dismissKeyboard))
        //        self.view!.addGestureRecognizer(tap)
        
        self.initailLogoImage()
        
        self.getProviderByID()
        self.getFacility()
        
        btn_WeeklyClick(UIButton())
        
    }
    override func viewDidDisappear(animated: Bool) {
        print("viewDidDisappear(ResInfo)")
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
        //     let strCheckout = dateFormatter.stringFromDate(datePicker.date)
        checkInTxt.text = strCheckin
        //            checkinPicker.hidden = true
    }
    
    func checkoutPickerChanged(datePicker:UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.NoStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        dateFormatter.dateFormat = "HH:mm"
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
        
        self.facilitiesResAttached.removeAll()
        for i in 0...appDelegate.facilityResDic!["facilities"]!.count - 1
        {
            if (self.appDelegate.facilityResStatus[i] as Bool)
            {
                
                self.facilitiesResAttached.append(appDelegate.facilityResDic!["facilities"]![i]["facility_name_en"] as! String)
                
                
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
        
        let subView1: Resfacility = NSBundle.mainBundle().loadNibNamed("Resfacility", owner: self, options: nil)[0] as! Resfacility
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
        print("selectedDay \(send.Dict2JsonString(selectedDay))")
        
        //  print ("Province ID : \(provinceID)")
        
        PKHUD.sharedHUD.dimsBackground = false
        PKHUD.sharedHUD.userInteractionOnUnderlyingViewsEnabled = false
        
        PKHUD.sharedHUD.contentView = PKHUDProgressView()
        //        PKHUD.sharedHUD.contentView = PKHUDStatusView(title: "Loading", subtitle: "Subtitle", image: nil)
        PKHUD.sharedHUD.show()
        
        print("BtnSaveData checkIn:  \(checkInTxt.text) checkOut \(checkOutTxt.text)")
        
        let dataDic = [
            "providerInformation" : [
                "providerId" : Int(appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["provider_id"]! as! String)!,
                "providerTypeKeyname" : "restaurant",
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

                //Restaurant
                "restaurantWeekdayOpentime": checkInTxt.text!,
                "restaurantWeekdayClosetime": checkOutTxt.text!,
                "restaurantWeekendOpentime": "",
                "restaurantWeekendClosetime": "",
                "restaurantTypeDetail": "",
                "payByCreditCard": "",
                "openDaily": send.Dict2JsonString(selectedDay),
                "wifiAvailable": (self.selectedService["wifi"]! == "1") ? "yes" : "no",
                "parkingAvailable": (self.selectedService["parking"]! == "1") ? "yes" : "no",
                "nonSmokingZone": (self.selectedService["smonking"]! == "1" ) ? "yes" : "no"
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
                    
//                    PKHUD.sharedHUD.contentView = PKHUDSuccessView()
                    //PKHUD.sharedHUD.hide(animated: false, completion: nil)
                    
                    // let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("providerlist")
                    // secondViewController?.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
                    //self.navigationController?.pushViewController(secondViewController!, animated: true)
//                    self.dismissViewControllerAnimated(true, completion: nil)
                    
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
        for i in 0...appDelegate.facilityResDic!["facilities"]!.count - 1
        {
            //            print("faccccccc \(i)")
            if(self.appDelegate.facilityResStatus[i])
            {
                print("Facility :\(appDelegate.facilityResDic!["facilities"]![i]["facility_name_en"] as! String)")
            }
            
        }
    }
    func getFacility()
    {
        
        facilitiesResAttached.removeAll()
        
        let dataDic =
            [
                "providerInformation" :
                    [
                        "providerId" : Int(appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["provider_id"]! as! String)!,
                        "providerTypeKeyname" : "restaurant"
                ]
        ]
        
        print("Resfac Dic \(appDelegate.facilityResDic)")
        print("Resfac status \(appDelegate.facilityResStatus)")
        print("Resfac DicCount \(appDelegate.facilityResDic?.count)")
        print("Resfac statusCount \(appDelegate.facilityResStatus.count)")
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
                    
                    //print(data["facilitiesAttached"]![i]["facility_keyname"])
                    //print("CountWTF : \(self.appDelegate.facilityResDic!["facilities"]!.count)")

                     //HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH
                    for j in 0...self.appDelegate.facilityResDic!["facilities"]!.count - 1{
                        //                    print("facilitiesAttachedID \(self.appDelegate.facilityResDic!["facilities"]![j]!["facility_id"])")
                        
                        if((data["facilitiesAttached"]![i]["facility_id"] as! String) == (self.appDelegate.facilityResDic!["facilities"]![j]!["facility_id"] as! String))
                        {
                            self.appDelegate.facilityResStatus[j] = true
                            print("index : \(j) \(data["facilitiesAttached"]![i]["facility_id"] as! String)")
                            print("index : \(j) \(self.appDelegate.facilityResDic!["facilities"]![j]!["facility_id"] as! String)")
                            
                        }
                        
                    }
                     //HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH
                    
                    
                    self.facilitiesResAttached.append(data["facilitiesAttached"]![i]["facility_keyname"] as! String)
                }
            }
            self.tableView.reloadData()
        }
        
        print("all facility Restaurant \(appDelegate.facilityResDic)")
        
    }
    
    func setFacility()
    {
        var dataDic =
            [
                "providerInformation" :
                    [
                        "providerId" : Int(appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["provider_id"]! as! String)!,
                        "providerTypeKeyname" : "restaurant"
                ],
                "facilitiesAttached" :[],
                
                "user" : [
                    "accessToken" : appDelegate.userInfo["accessToken"]!
                ]
        ]
        
        //var facilitiesAttached:[[String:String]] = []
        self.facilitiesResAttached.removeAll()
        for i in 0...appDelegate.facilityResDic!["facilities"]!.count - 1
        {
            if (self.appDelegate.facilityResStatus[i] as Bool)
            {
                facilitiesAttached.append(
                    ["facility_id": appDelegate.facilityResDic!["facilities"]![i]["facility_id"] as! String,
                        "facility_keyname": appDelegate.facilityResDic!["facilities"]![i]["facility_name_en"] as! String,
                        "quantity": "0", ])
                print("fac OK \(appDelegate.facilityResDic!["facilities"]![i]["facility_name_en"] as! String)")
                
                self.facilitiesResAttached.append(appDelegate.facilityResDic!["facilities"]![i]["facility_name_en"] as! String)
                
                
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
        checkInTxt.resignFirstResponder()
        checkOutTxt.resignFirstResponder()
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
        
        pickerView.frame.origin.x = 0
        checkinPicker.frame.origin.x = 0
        checkoutPicker.frame.origin.x = 0
        
        pickerView.frame.size.width = UIScreen.mainScreen().bounds.width
        checkinPicker.frame.size.width = UIScreen.mainScreen().bounds.width
        checkoutPicker.frame.size.width = UIScreen.mainScreen().bounds.width
        
        
        let navBarHeight:CGFloat = 44.0
        var frmScrollView = scrollView.frame
        frmScrollView.origin.y = 0
        frmScrollView.size.height = UIScreen.mainScreen().bounds.height - (navBarHeight + 54 + 46) // - 10
        scrollView.frame = frmScrollView
        
        self.scrollView.frame.origin.y = 0
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.width, 1526)
//        self.view_DateSet.frame.size.width = self.view.frame.width - 16
//        self.view_BottomSet.frame.size.width = self.view.frame.width - 16
        
        self.view_DateSet.hidden = true
        self.view_BottomSet.frame.origin.y = 912
        
        self.view_DateSet.frame.size.width = self.view.frame.size.width
        self.view_BottomSet.frame.size.width = self.view.frame.size.width
        
        
//        var frmBottomSet = self.view_BottomSet.frame
//        frmBottomSet.size.width = 370
//        self.view_BottomSet.frame = frmBottomSet

        
        
        //superviewForDateSet
        view_DateSet.frame.size.width = self.scrollView.frame.width - 12
        view_DateSet.center.x = self.scrollView.frame.width / 2
        superviewForDateSet.frame.size.width = view_DateSet.frame.size.width
        superviewForDateSet.frame.origin.x = 0
        
        let itemWidth = (superviewForDateSet.frame.size.width / 7)
        var nImg = 0
        for dateItem in superviewForDateSet.subviews {
            // UIImageView
            if(dateItem.classForCoder == UIImageView.self){
                dateItem.frame.size.width = itemWidth - 6
                dateItem.frame.origin.x = itemWidth * CGFloat(nImg) + 3
                dateItem.contentMode = .ScaleAspectFit

                nImg += 1
            }
        }
        
        let itemBtnWidth = superviewForDateSet.frame.size.width / 7
        var nBtn = 0
        for dateItem in superviewForDateSet.subviews {
            if(dateItem.classForCoder == UIButton.self){
                dateItem.frame.size.width = itemBtnWidth
                dateItem.frame.origin.x = itemBtnWidth * CGFloat(nBtn)
                
                nBtn += 1
            }
        }
        
        
        //open and close
        
//        let openAndCloseWidth = superviewForDateSet.frame.size.width / 2
//        var frmCheckIn = checkInView.frame
//        frmCheckIn.origin.x = 6
//        frmCheckIn.size.width = openAndCloseWidth - 12
//        checkInView.frame = frmCheckIn
//        
//        var frmCheckOut = checkOutView.frame
//        frmCheckOut.origin.x = openAndCloseWidth + 6
//        frmCheckOut.size.width = openAndCloseWidth - 12
//        checkOutView.frame = frmCheckOut
        
        
    }

    
    override func viewWillAppear(animated: Bool) {
        
        
        //self.setObject()
        
        let tapAddCover = UITapGestureRecognizer(target:self, action:#selector(ResInformationVC.imageTapped(_:)))
        imgHotelCover.userInteractionEnabled = true
        imgHotelCover.tag = 1
        imgHotelCover.addGestureRecognizer(tapAddCover)
        
        let tapAddLogo = UITapGestureRecognizer(target:self, action:#selector(ResInformationVC.imageTapped(_:)))
        imgHotelLogo.userInteractionEnabled = true
        imgHotelLogo.tag = 2
        imgHotelLogo.addGestureRecognizer(tapAddLogo)
        
        //scrollView.contentSize = CGSizeMake(width,2150)
        
//        print("scrollwidth = \(scrollView.bounds.size.width)")
//        scrollView.layer.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1).CGColor
//        scrollView.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1)
        
        //hide keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ResInformationVC.dismissKeyboard))
        self.view!.addGestureRecognizer(tap)
        
        let pickerTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ResInformationVC.dismissKeyboard2))
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
        //self.imgHotelLogo.image = UIImage(named: "bg_cctvdefault.png")
        
        
        //                    if(pickerPick == false){
        //
        //                    }
        //                    else{
        //
        //                         self.imgHotelLogo.image = UIImage(named: "bg_cctvdefault.png")
        //                     self.imgHotelLogo.image = UIImage(data: NSData(contentsOfURL: NSURL(string: self.appDelegate.providerData!["ListProviderInformationSummary"]![self.appDelegate.providerIndex!]["images"]!!["logo_image"]!!["small"] as! String)!)!)
        //                    }
        
        
//        if let logo = self.appDelegate.providerData!["ListProviderInformationSummary"]![self.appDelegate.providerIndex!]["images"]!!["logo_image"]!!["small"]{
//            print("has LOGO : \(self.appDelegate.providerData!["ListProviderInformationSummary"]![self.appDelegate.providerIndex!]["images"]!!["logo_image"]!)")
//            self.imgHotelLogo.image = UIImage(data:NSData(contentsOfURL:NSURL(string:logo as! String)!)!)
//            self._viewEmptyLogo.hidden = true
//        }else{
//            print("no logo")
//            self.imgHotelLogo.image = UIImage()
//            self._viewEmptyLogo.hidden = false
//        }
//        
//        
//        if let cover = self.appDelegate.providerData!["ListProviderInformationSummary"]![self.appDelegate.providerIndex!]["images"]!!["cover_image"]!!["small"]{
//            print("has cover : \(self.appDelegate.providerData!["ListProviderInformationSummary"]![self.appDelegate.providerIndex!]["images"]!!["cover_image"]!)")
//            self.imgHotelCover.image = UIImage(data:NSData(contentsOfURL:NSURL(string:cover as! String)!)!)
//            self._viewEmptyCover.hidden = true
//        }else{
//            print("no cover")
//            self.imgHotelCover.image = UIImage()
//            self._viewEmptyCover.hidden = false
//        }
        
        
//        
////        let dateFormatter = NSDateFormatter()
//        
//        dateFormatter.dateStyle = NSDateFormatterStyle.NoStyle
//        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
////        let strCheckin = dateFormatter.stringFromDate(datePicker.date)
//        checkinPicker.setDate(NSDate(dateFormatter dateFromString("10:51:00")), animated: true)
        //     let strCheckout = dateFormatter.stringFromDate(datePicker.date)
//        checkInTxt.text = strCheckin
        

//        checkOutTxt.text = (appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["restaurant_weekend_closetime"]! as! String)
        

        
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    func textFieldShouldBeginEditing(textField:UITextField) -> Bool {
        
        print(textField)
        if(textField == provinceTxt){
            
            pickerView.hidden = false
            txtHotelName.resignFirstResponder()
            emailTxt.resignFirstResponder()
            websiteTxt.resignFirstResponder()
            provinceTxt.resignFirstResponder()
            checkInTxt.resignFirstResponder()
            checkOutTxt.resignFirstResponder()
            
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
            checkInTxt.resignFirstResponder()
            checkOutTxt.resignFirstResponder()
            
            HotelDesTxt.resignFirstResponder()
            addressTxt.resignFirstResponder()
            phonNumberTxt.resignFirstResponder()
            
            return false
        }
        else if(textField == checkOutTxt){
            print("pppppppp")
            checkoutPicker.hidden = false
            checkinPicker.hidden = true
            txtHotelName.resignFirstResponder()
            emailTxt.resignFirstResponder()
            websiteTxt.resignFirstResponder()
            provinceTxt.resignFirstResponder()
            checkInTxt.resignFirstResponder()
            checkOutTxt.resignFirstResponder()
            
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
        return facilitiesResAttached.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        if(facilitiesResAttached.count == 0){
            cell.textLabel?.text = ""
        }
        else{
            // var facilitiesAttached:[[String:String]] = []
            cell.textLabel?.text = facilitiesResAttached[indexPath.row]
            print("facilitiesResAttached(table) \(facilitiesResAttached[indexPath.row])")
        }
        
        //cell.textLabel?.text = "facility name"
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Select")
    }
    
    func getProviderByID()
    {
        //        PKHUD.sharedHUD.dimsBackground = false
        //        PKHUD.sharedHUD.userInteractionOnUnderlyingViewsEnabled = false
        //
        //        //        PKHUD.sharedHUD.contentView = PKHUDStatusView(title: "Loading", subtitle: "Subtitle", image: nil)
        //        PKHUD.sharedHUD.contentView = PKHUDProgressView()
        //        PKHUD.sharedHUD.show()
        //        PKHUD.sharedHUD.hide(afterDelay: 1.0)
        
        let send = API_Model()
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            
            print("providerId:::\(self.appDelegate.providerData!["ListProviderInformationSummary"]![self.appDelegate.providerIndex!]["provider_id"])")
            
            let dataJson = "{\"providerId\":\"\(self.appDelegate.providerData!["ListProviderInformationSummary"]![self.appDelegate.providerIndex!]["provider_id"] as! String)\"}"
            send.providerAPI(self.appDelegate.command["GetProviderInformationById"]!, dataJson: dataJson) {
                data in
                print("getProviderByID \(data)")
                //            PKHUD.sharedHUD.contentView = PKHUDSuccessView()
                //            PKHUD.sharedHUD.hide(afterDelay: 1.0)
                //            print("providerDataID \(data["GetProviderInformationById"]!["total_room"])")
                
                //            self.totalRoomTxt.text = (data["GetProviderInformationById"]!["total_room"]! === NSNull()) ? "" : data["GetProviderInformationById"]!["total_room"] as! String
                //
                //            self.totalFloorTxt.text = (data["GetProviderInformationById"]!["number_of_floors"]! === NSNull()) ? "" : data["GetProviderInformationById"]!["number_of_floors"] as! String
                //
                //            self.checkInTxt.text = (data["GetProviderInformationById"]!["check_in_time"]! === NSNull()) ? "" : data["GetProviderInformationById"]!["check_in_time"] as! String
                //
                //            self.checkOutTxt.text = (data["GetProviderInformationById"]!["check_out_time"]! === NSNull()) ? "" : data["GetProviderInformationById"]!["check_out_time"] as! String
                //
                //            self.distanceCityTxt.text = (data["GetProviderInformationById"]!["distance_from_city_center"]! === NSNull()) ? "" : data["GetProviderInformationById"]!["distance_from_city_center"] as! String
                //
                //            self.DistanceAirportTxt.text = (data["GetProviderInformationById"]!["distance_to_airport"]! === NSNull()) ? "" : data["GetProviderInformationById"]!["distance_to_airport"] as! String
                
                
                print("openDaily=======>>>> \(data["GetProviderInformationById"]!["openDaily"])")
                
                
                if var openTime = data["GetProviderInformationById"]!["restaurant_weekday_opentime"]
                {
                    
                    let myNSString = openTime as! NSString
                    
                    openTime = myNSString.substringWithRange(NSRange(location: 0, length: 5))
                    
                    if((openTime as! String) == "00:00")
                    {
                        self.setStatus24(true)
                    }else
                    {
                        self.setStatus24(false)
                        
                    }
                    self.checkInTxt.text = openTime as? String
                    let dateFormatter = NSDateFormatter()
                    dateFormatter.dateStyle = NSDateFormatterStyle.NoStyle
                    dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
                    dateFormatter.dateFormat = "HH:mm"
                    let date = dateFormatter.dateFromString(openTime as! String)
                    if let unwrappedDate = date {
                        self.checkinPicker.setDate(unwrappedDate, animated: false)
                    }
                    
                }
                else
                {
                    self.checkInTxt.text = "10:00"
                }
                if var closeTime = data["GetProviderInformationById"]!["restaurant_weekday_closetime"]
                {
                    let myNSString = closeTime as! NSString
                    
                    closeTime = myNSString.substringWithRange(NSRange(location: 0, length: 5))
                    
                    if((closeTime as! String) == "00:00")
                    {
                        self.setStatus24(true)
                    }else{
                        self.setStatus24(false)
                        
                    }
                    self.checkOutTxt.text = closeTime as? String
                    let dateFormatter = NSDateFormatter()
                    dateFormatter.dateStyle = NSDateFormatterStyle.NoStyle
                    dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
                    dateFormatter.dateFormat = "HH:mm"
                    let date = dateFormatter.dateFromString(closeTime as! String)
                    if let unwrappedDate = date {
                        self.checkoutPicker.setDate(unwrappedDate, animated: false)
                    }
                    
                }
                else
                {
                    self.checkOutTxt.text = "12:00"
                }
                
               
                if let openDailyStr = data["GetProviderInformationById"]!["open_daily"]
                {
                    var openDailyDic = ["":""]
                    if (openDailyStr === NSNull())
                    {
                        openDailyDic = ["su": "0", "tu": "0", "th": "0", "fr": "0", "we": "0", "sa": "0", "mo": "0"]
                    }else
                    {
                        openDailyDic = send.jsonEncode(openDailyStr as! String) as! [String : String]
                    }
                    
                    self.img_Weekly.image = UIImage(named: "check.png")
                    self.img_AllDay.image = UIImage(named: "uncheck.png")
                    print("aaaaaaaaaaa \(openDailyDic["mo"])")
                    self.selectedDay = openDailyDic
                    var allDay = 0
                    for (day,status) in openDailyDic
                    {
                        allDay = allDay + Int(status)!
                        switch day {
                        case  "su":
                            self.day_su.image = (status == "0") ? UIImage(named: "su.png") : UIImage(named: "su_hover.png")
                        case  "mo":
                            self.day_mo.image = (status == "0") ? UIImage(named: "mo.png") : UIImage(named: "mo_hover.png")
                        case  "tu":
                            self.day_tu.image = (status == "0") ? UIImage(named: "tu.png") : UIImage(named: "tu_hover.png")
                        case  "we":
                            self.day_we.image = (status == "0") ? UIImage(named: "we.png") : UIImage(named: "we_hover.png")
                        case  "th":
                            self.day_th.image = (status == "0") ? UIImage(named: "th.png") : UIImage(named: "th_hover.png")
                        case  "fr":
                            self.day_fr.image = (status == "0") ? UIImage(named: "fr.png") : UIImage(named: "fr_hover.png")
                        case  "sa":
                            self.day_sa.image = (status == "0") ? UIImage(named: "sa.png") : UIImage(named: "sa_hover.png")
                            default:
                                break;
                        }
                    }
                    if(allDay == 7){
                        self.view_DateSet.hidden = true
                        self.view_BottomSet.frame.origin.y = 912
                        self.img_AllDay.image = UIImage(named: "check.png")
                        self.img_Weekly.image = UIImage(named: "uncheck.png")
                        
                    }else{
                        self.view_DateSet.hidden = false
                        self.img_AllDay.image = UIImage(named: "uncheck.png")
                        self.img_Weekly.image = UIImage(named: "check.png")
                        
                    }
                    

                    if let wifi = data["GetProviderInformationById"]!["wifi_available"]
                    {
                        if(wifi === NSNull())
                        {
                            self.selectedService["wifi"] = "0"
                            self.lblWifiServiceYes.textColor = UIColor.grayColor()
                            self.lblWifiServiceNo.textColor = UIColor.blackColor()
                            self.imgWifiServiceYes.image = UIImage(named: "uncheck.png")
                            self.imgWifiServiceNo.image = UIImage(named: "check.png")
                        }else
                        {
                            if ((wifi as! String) == "1" || (wifi as! String) == "yes")
                            {
                                self.selectedService["wifi"] = "1"
                                self.lblWifiServiceYes.textColor = UIColor.blackColor()
                                self.lblWifiServiceNo.textColor = UIColor.grayColor()
                                self.imgWifiServiceYes.image = UIImage(named: "check.png")
                                self.imgWifiServiceNo.image = UIImage(named: "uncheck.png")
                                
                            }else
                            {
                                self.selectedService["wifi"] = "0"
                                self.lblWifiServiceYes.textColor = UIColor.grayColor()
                                self.lblWifiServiceNo.textColor = UIColor.blackColor()
                                self.imgWifiServiceYes.image = UIImage(named: "uncheck.png")
                                self.imgWifiServiceNo.image = UIImage(named: "check.png")
                                
                                
                            }
                            
                        }
                        
                    }
                    if let parking = data["GetProviderInformationById"]!["parking_available"]
                    {
                        if(parking === NSNull())
                        {
                            self.selectedService["parking"] = "0"
                            self.lblParkingServiceYes.textColor = UIColor.grayColor()
                            self.lblParkingServiceNo.textColor = UIColor.blackColor()
                            self.imgParkingServiceYes.image = UIImage(named: "uncheck.png")
                            self.imgParkingServiceNo.image = UIImage(named: "check.png")
                        }else
                        {
                            if ((parking as! String) == "1" || (parking as! String) == "yes")
                            {
                                self.selectedService["parking"] = "1"
                                self.lblParkingServiceYes.textColor = UIColor.blackColor()
                                self.lblParkingServiceNo.textColor = UIColor.grayColor()
                                self.imgParkingServiceYes.image = UIImage(named: "check.png")
                                self.imgParkingServiceNo.image = UIImage(named: "uncheck.png")
                                
                            }else
                            {
                                self.selectedService["parking"] = "0"
                                self.lblParkingServiceYes.textColor = UIColor.grayColor()
                                self.lblParkingServiceNo.textColor = UIColor.blackColor()
                                self.imgParkingServiceYes.image = UIImage(named: "uncheck.png")
                                self.imgParkingServiceNo.image = UIImage(named: "check.png")
                                
                                
                            }
                            
                        }
                        
                    }
                    if let smonking = data["GetProviderInformationById"]!["non_smoking_zone"]
                    {
                        if(smonking === NSNull())
                        {
                            self.selectedService["smonking"] = "0"
                            self.lblSmonkingServiceYes.textColor = UIColor.grayColor()
                            self.lblSmonkingServiceNo.textColor = UIColor.blackColor()
                            self.imgSmonkingServiceYes.image = UIImage(named: "uncheck.png")
                            self.imgSmonkingServiceNo.image = UIImage(named: "check.png")
                        }else
                        {
                            if ((smonking as! String) == "1" || (smonking as! String) == "yes")
                            {
                                self.selectedService["smonking"] = "1"
                                self.lblSmonkingServiceYes.textColor = UIColor.blackColor()
                                self.lblSmonkingServiceNo.textColor = UIColor.grayColor()
                                self.imgSmonkingServiceYes.image = UIImage(named: "check.png")
                                self.imgSmonkingServiceNo.image = UIImage(named: "uncheck.png")
                            }else
                            {
                                self.selectedService["smonking"] = "0"
                                self.lblSmonkingServiceYes.textColor = UIColor.grayColor()
                                self.lblSmonkingServiceNo.textColor = UIColor.blackColor()
                                self.imgSmonkingServiceYes.image = UIImage(named: "uncheck.png")
                                self.imgSmonkingServiceNo.image = UIImage(named: "check.png")
                                
                            }
                            
                        }
                        
                    }

                }
            }
            
            dispatch_async(dispatch_get_main_queue()) {
                // update some UI
            }
        }
        
        
    }
    
    var _pickerType = ""
    func imageTapped(sender: AnyObject){
        
        print("Upload Logo Img")
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
//        
//        print("ImagePicker")
//        
//        let chosenImage = (info[UIImagePickerControllerOriginalImage] as? UIImage)!
//        var _imageType = ""
//        if(_pickerType == "cover"){
//            
//            print("cover")
//            // upload Cover
//            self.imgHotelCover.contentMode = .ScaleAspectFill
//            self.imgHotelCover.image = chosenImage
//            _imageType = "coverImage"
//            
//        }else if(_pickerType == "logo"){
//            print("logo")
//            
//            // Upload LOGO
//            self.imgHotelLogo.contentMode = .ScaleAspectFill
//            self.imgHotelLogo.image = chosenImage
//            _imageType = "logoImage"
//            
//        }
//        
////        //let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
////        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
////        imgHotelLogo.contentMode = .ScaleAspectFit //3
////        self.imgHotelLogo.image = chosenImage //4
//        
//        
//        let imageURL = info[UIImagePickerControllerReferenceURL] as! NSURL
//        let imageName = imageURL.pathComponents![1];
//        print("imageName : \(imageName)")
//        pickerPick = true
//        //        imgHotelLogo.reloadInputViews()
//        
//        let send = API_Model()
//        send.getUploadKey(Int(appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["provider_id"]! as! String)!,imageType: _imageType,imageName: imageName){
//            data in
//            PKHUD.sharedHUD.dimsBackground = false
//            PKHUD.sharedHUD.userInteractionOnUnderlyingViewsEnabled = false
//            PKHUD.sharedHUD.contentView = PKHUDProgressView()
//            PKHUD.sharedHUD.show()
//            
//            print("UPLOAD DATA ::: \(data)")
//            self.mediaKey = data
//            
//            send.uploadImage(self.mediaKey, image: chosenImage, imageName: imageName)
//            {
//                data in
//                //                PKHUD.sharedHUD.contentView = PKHUDSuccessView()
//                self.dismissViewControllerAnimated(true, completion:
//                    {
//                        PKHUD.sharedHUD.hide(afterDelay: 1.0)
//                        self.imgHotelLogo.image = chosenImage
//                        self.imgHotelLogo.reloadInputViews()
//                })
//            }
//        }
//        
//        
        
        
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
        //        // self.dismissViewControllerAnimated(true, completion: nil)
        //        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("providerinfo") as! ProviderInfoVC
        //        self.navigationController?.pushViewController(vc, animated:true)
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
}
