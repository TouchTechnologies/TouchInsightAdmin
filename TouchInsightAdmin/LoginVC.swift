//
//  LoginVC.swift
//  TouchInsightAdmin
//
//  Created by weerapons suwanchatree on 11/26/2558 BE.
//  Copyright © 2558 weerapons suwanchatree. All rights reserved.
//

import UIKit
import CoreData
import Foundation
import FBSDKLoginKit
import FBSDKCoreKit
import SMPageControl
import SCLAlertView
import CoreLocation
import MapKit
import RNCryptor
import PKHUD

import Firebase
import FirebaseCrash


class LoginVC: UIViewController, CLLocationManagerDelegate,UITextFieldDelegate {
    
    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var passWordTxt: UITextField!
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var latitude:String? = "0.00"
    var longitude:String? = "0.00"
    
    let locationManager = CLLocationManager()
    
    //var alertView = SCLAlertView()
    
    
    //    var _mUserData: mUserData!
    //    var _read_UserData = try! Realm().objects(mUserData)
    
    
    //    var provinceList = [ProvinceList]()
    //    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    
    
    @IBAction func registBtn(sender: AnyObject) {
        
        
        
        
        
        //        performSegueWithIdentifier("toRegist", sender: self) HHHHHHHHHHHHHHHHHH
    }
    
    
    //    func RealmWrite() {
    //        
    //        let _ud = [
    //            "name": "teer",
    //            "email": "teer@te.co",
    //            "age": "28",
    //            "province": "khonkean",
    //            "last_time": "xxxx"
    //        ]
    //        
    //        let realm = try! Realm()
    //        try! realm.write {
    //            self._mUserData.username = "TAKKKK"
    //            self._mUserData.userEmail = "teerstudio@hotmail.com"
    //            self._mUserData.userData = _ud
    //        }
    //        print("RealmWrite")
    //        
    //    }
    //    
    //    func RealmRead() {
    //        
    //        print("RealmRead")
    //        _read_UserData = try! Realm().objects(mUserData)
    //        
    //        print(_read_UserData)
    //        
    //    }
    
    override func viewDidLoad() {
        appDelegate.isLogin = false
        
        //        RealmWrite()
        //        
        //        RealmRead()
        //
        super.viewDidLoad()
        self.setViewStyle()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        //  userNameTxt.text = "gift@m.c"
        //passWordTxt.text = "123456789"
        
        
        //*******************User Test**********************//
        //       userNameTxt.text = "pair@p.z"
        //       passWordTxt.text = "12345678"
        let device = DeviceDetail()
        
        print(" DeviceDetail.Simulator ")
        print(device)
        print(device.description)
        print("= = = = = = = = = = = = =")
//        print(device)     // prints for example "iPhone 6 Plus"
//        if device.model {
//            // Do something
//        } else {
//            // Do something else
//        }
//        
        if(device.description == "Simulator"){
            
            userNameTxt.text = "teerstudio@hotmail.com"
            passWordTxt.text = "master99"
            
        }
        
        userNameTxt.delegate = self
        passWordTxt.delegate = self
        
        locationManager.requestWhenInUseAuthorization();
        if CLLocationManager.locationServicesEnabled(){
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            self.locationManager.startUpdatingLocation()
            print("OK Location")
        }
        else{
            print("Location service disabled");
        }
        
        
        
        //        test.PostData()
        
        /***
         define AlertView
         .......................................................
         SCLAlertView().showInfo("Important info", subTitle: "You are great")
         ***/
        
        
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        userNameTxt.resignFirstResponder()
        passWordTxt.resignFirstResponder()
        
        return true;
    }
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        return true
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        self.view!.endEditing(true)
        return true
    }
    func keyboardWillShow(notification: NSNotification) {
        
        UIView.animateWithDuration(0.25, animations: {_ in
            
            //        alert.frame = popupView.bounds    }, completion: nil)
            // Assign new frame to your view
            let width: CGFloat = UIScreen.mainScreen().bounds.size.width
            let height: CGFloat = UIScreen.mainScreen().bounds.size.height
            var keyboardInfo: [NSObject : AnyObject] = notification.userInfo!
            let keyboardFrameBegin: NSValue = keyboardInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue
            let keyboardFrameBeginRect: CGRect =
                keyboardFrameBegin.CGRectValue()
            self.view!.frame = CGRectMake(0,-keyboardFrameBeginRect.size.height/2, width, height)
            //here taken -20 for example i.e. your view will be scrolled to -20. change its value according to your requirement.
            
        })
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        
        UIView.animateWithDuration(0.25, animations: {_ in
            
            let width: CGFloat = UIScreen.mainScreen().bounds.size.width
            let height: CGFloat = UIScreen.mainScreen().bounds.size.height
            self.view!.frame = CGRectMake(0, 0, width, height)
        })
    }
    
    func setViewStyle(){
        
        //set bg image
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bglogin6Plus.png")!)
        
        //set txt placeholder
        userNameTxt.attributedPlaceholder = NSAttributedString(string:"Username",attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        userNameTxt.layer.borderWidth = 1
        userNameTxt.layer.borderColor = UIColor.grayColor().CGColor
        
        
        passWordTxt.attributedPlaceholder = NSAttributedString(string:"Password",attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        passWordTxt.layer.borderWidth = 1
        passWordTxt.layer.borderColor = UIColor.grayColor().CGColor
        
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        
        print("lacationManager")
        let location = locations.last! as CLLocation
        //        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        //        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        print("latitude : \(location.coordinate.latitude)")
        print("longitude : \(location.coordinate.longitude)")
        appDelegate.latitude = String(location.coordinate.latitude)
        appDelegate.longitude = String(location.coordinate.longitude)
        latitude  = String(location.coordinate.latitude)
        longitude = String(location.coordinate.longitude)
        locationManager.stopUpdatingLocation()
        //        self.map.setRegion(region, animated: true)
    }
    
    @IBAction func LoginBtn(sender: AnyObject)
    {
        userNameTxt.resignFirstResponder()
        passWordTxt.resignFirstResponder()
        
        
//        FIRCrashMessage("Cause Crash button clicked")
//        fatalError()
        
        
        var titleMessage:String = ""
        var message:String = ""
        
        if userNameTxt.text != "" && passWordTxt.text != "" {
            
            let login = API_Model()
            //        print(userNameTxt.text as! String)
            //        print(passWordTxt.text as! String)
            //        print("latitude : \(latitude)")
            //        print("long")
            PKHUD.sharedHUD.dimsBackground = false
            PKHUD.sharedHUD.userInteractionOnUnderlyingViewsEnabled = false
            
            PKHUD.sharedHUD.contentView = PKHUDProgressView()
            //        PKHUD.sharedHUD.contentView = PKHUDStatusView(title: "Loading", subtitle: "Subtitle", image: nil)
            PKHUD.sharedHUD.show()
            
            //  PKHUD.sharedHUD.contentView = PKHUDSuccessView()
            //   PKHUD.sharedHUD.hide(afterDelay: 2.0)
            
            login.LogIn(userNameTxt.text!, password: passWordTxt.text!,latitude: latitude!,longitude: longitude!)
            {
                data in
                print(data)
                
//returnData = [
//    "success":true,
//    "message":"Login Success!",
//    "data":json
//]
                
                if (data["success"] as! Bool == true){
                    
                    titleMessage = "Login Success"
                    message = "ยินดีต้อนรับเข้าสู่ระบบ"
                    //                        SCLAlertView().showInfo(titleMessage, subTitle: message, colorStyle:0xAC332F)
                    //                        print("SUCCESS")
                    
                    
                    //                        appDelegate.firstName = 
                    //                        login.getUserInfo(data["userID"] as! String)
                    login.getUserInfo(self.appDelegate.userInfo["userID"]! as String){
                        data in
                        //PKHUD.sharedHUD.hide(afterDelay: 0.1)
                        print("data : \(data)")
                        
                        
                        if let _avatarImage = data["avatar"] as! String? {
                            self.appDelegate.userInfo["avatarImage"] = _avatarImage
                        }
                        
                        if let _firstName = data["firstName"] as! String? {
                            self.appDelegate.userInfo["firstName"] = _firstName
                        }
                        
                        if let _lastName = data["lastName"] as! String? {
                            self.appDelegate.userInfo["lastName"] = _lastName
                        }
                        
                        if let _email = data["email"] as! String? {
                            self.appDelegate.userInfo["email"] = _email
                        }
                        
                        if let _mobile = data["phoneNumber"] as! String? {
                            self.appDelegate.userInfo["mobile"] = _mobile
                        }
                        
                        
                        if let _id = data["id"] as! String? {
                            self.appDelegate.userInfo["id"] = _id
                        }
                        
                        self.appDelegate.userInfo["profileName"] = "\(self.appDelegate.userInfo["firstName"]!) \(self.appDelegate.userInfo["lastName"]!)"
                        
                        
                        
                        self.appDelegate.userInfo["username"] = self.userNameTxt.text
                        self.appDelegate.userInfo["passWord"] = self.passWordTxt.text
                        self.appDelegate.userInfo["email"] = self.userNameTxt.text
                        //
                        
                        self.appDelegate.isLogin = true
                        print("APPDALAGATELOGIN:::\(self.appDelegate.isLogin)")
                        
                        PKHUD.sharedHUD.hide(animated: false, completion: {_ in
                            let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MainVC")
                            self.navigationController?.pushViewController(secondViewController!, animated: true)
                        })
                        
                    }
                }else{
                    self.appDelegate.isLogin = false
                    titleMessage = "Login fail"
                    message = data["message"] as! String
                    PKHUD.sharedHUD.hide(animated: false, completion: {_ in
                        
                    })
                    
                    let alertView = SCLAlertView()
                    alertView.showCircularIcon = false
                    alertView.showInfo(titleMessage, subTitle: message, colorStyle:0xAC332F, duration: 3.0)
     
                }
                
            }
        }
        else if userNameTxt.text == "" && passWordTxt.text == ""
        {
            titleMessage = "Login fail"
            message = "กรุณากรอก Username และ Password"
            let alertView = SCLAlertView()
            alertView.showCircularIcon = false
            alertView.showInfo(titleMessage, subTitle: message, colorStyle:0xAC332F, duration: 3.0)

        }
        else if userNameTxt.text == ""
        {
            titleMessage = "Login fail"
            message = "กรุณากรอก Username"
            let alertView = SCLAlertView()
            alertView.showCircularIcon = false
            alertView.showInfo(titleMessage, subTitle: message, colorStyle:0xAC332F, duration: 3.0)
        }
        else if passWordTxt.text == ""
        {
            titleMessage = "Login fail"
            message = "กรุณากรอก Password"
            let alertView = SCLAlertView()
            alertView.showCircularIcon = false
            alertView.showInfo(titleMessage, subTitle: message, colorStyle:0xAC332F, duration: 3.0)
        }
        
        
    }
    
    @IBAction func LoginFbBtn(sender: AnyObject) {
        
        
        locationManager.requestWhenInUseAuthorization();
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            print("OK Location")
        }
        else{
            print("Location service disabled");
        }
        
        
        
        
        
    }
    
    func convertStringToDictionary(text: String) -> [String:AnyObject]? {
        if let data = text.dataUsingEncoding(NSUTF8StringEncoding) {
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? [String:AnyObject]
                return json
            } catch {
                print("Something went wrong")
            }
        }
        return nil
    }
    // override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    //        if(segue.identifier == "toRegist"){
    //            var  registerVC = self.storyboard?.instantiateViewControllerWithIdentifier("RegisterVC");          registerVC = segue.destinationViewController as! RegisterVC
    //         registerVC!.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
    //     //   self.navigationController?.pushViewController(registerVC, animated: true)
    //    }}
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