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

import FBSDKCoreKit
//import FBSDKShareKit
import FBSDKLoginKit

import RealmSwift

extension Results {
    
    func toArray() -> [T] {
        return self.map{$0}
    }
}

extension RealmSwift.List {
    
    func toArray() -> [T] {
        return self.map{$0}
    }
}
class LoginVC: UIViewController, CLLocationManagerDelegate,UITextFieldDelegate,UIGestureRecognizerDelegate {
    
    var _member : Results<MemberData>!
    
    
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var btnLogin: UIButton!
    let btnFbLogin = UIButton()
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
    
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    
    func readDB(){
        self._member = uiRealm.objects(MemberData)
//        if self._member != nil {
//            return self._member
//        }else{
//            return nil
//        }
//        
//        print("--------- readDB --------")
//        print(self._member[0])
//        print("----------------------------")
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        

        
//        readDB()
//        if self._member != nil{
//            
//            let m = Array((self._member).toArray())
//            
//            print("0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0")
//            print("0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0")
//            print("0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0")
//            print(m)
//            print("0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0")
//            print("0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0")
//            print("0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0")
//            
//
////            do {
////                let realm = try Realm()
////                let objs = realm.objects(MemberData).toArray()
////                // ...
////                
////            } catch _ {
////                // ...
////            }
//
//            
//        }
        
        


        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginVC.dismissKeyboard))
        tap.delegate = self
        tap.cancelsTouchesInView = true
        self.view!.addGestureRecognizer(tap)
        
        
        
        
        
        appDelegate.isLogin = false
        userNameTxt.keyboardType = .EmailAddress
        //        RealmWrite()
        //        
        //        RealmRead()
        //
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
        
        let deviceName = UIDevice.currentDevice().name
        
        if(device.description == "Simulator" || (deviceName == "TAK" && device.description == "iPhone 6s")){
            
            userNameTxt.text = "teerstudio@hotmail.com"
            passWordTxt.text = "master99"
            
        }
        
//        userNameTxt.text = "teerstudio@hotmail.com"
//        passWordTxt.text = "master99"
//        
//        userNameTxt.text = "admin2327@hotel.com"
//        passWordTxt.text = "admin2327"
        
        
        
        
        userNameTxt.delegate = self
        passWordTxt.delegate = self
        
        locationManager.requestWhenInUseAuthorization();
        if CLLocationManager.locationServicesEnabled(){
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            self.locationManager.startUpdatingLocation()
            print("OK Location")
        }else{
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
        
        // ยังไม่เซทค่า config app
        // https://developers.facebook.com/docs/facebook-login/ios#code-example
        var frmBtnFbLogin = btnLogin.frame
        frmBtnFbLogin.origin.y = btnLogin.frame.origin.y + btnLogin.frame.size.height + 12
        btnFbLogin.frame = frmBtnFbLogin
        btnFbLogin.backgroundColor = UIColor.blueColor()
        btnFbLogin.setTitle("FB LOGIN", forState: UIControlState.Normal)
        btnFbLogin.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        btnFbLogin.addTarget(self, action: #selector(loginFB) , forControlEvents: UIControlEvents.TouchUpInside)
        scrollview.addSubview(btnFbLogin)
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
    func loginFB() {
        print("loginFB")
        var titleMessage:String = ""
        var message:String = ""
        PKHUD.sharedHUD.dimsBackground = false
        PKHUD.sharedHUD.userInteractionOnUnderlyingViewsEnabled = false
        
        PKHUD.sharedHUD.contentView = PKHUDProgressView()
        PKHUD.sharedHUD.show()
        
        let loginManager:FBSDKLoginManager = FBSDKLoginManager()
        loginManager.logInWithReadPermissions(["email", "public_profile"], handler: { (result:FBSDKLoginManagerLoginResult!, error:NSError!) -> Void in
            
            if let _ = error{
                //got error
            } else if(result.isCancelled){
                print("login canceled")
                PKHUD.sharedHUD.hide(animated: false, completion:nil)
            } else{
                
                print(result.grantedPermissions)
                //                if(result.grantedPermissions.containsObject("email")){
                
                let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters:["fields":"name,email,first_name,last_name"])
//                let request = FBSDKGraphRequest(graphPath: "me", parameters: nil, HTTPMethod: "GET")
                graphRequest.startWithCompletionHandler({ (connection:FBSDKGraphRequestConnection!, data:AnyObject!, error:NSError!) -> Void in
                    
                    if let _ = error{
                        //got error
                    } else {
                        
                        print("dataAll : \(data)")
                        
                        let email : String = data.valueForKey("email") as! String;
                        let firstName:String = data.valueForKey("first_name") as! String;
                        let lastName:String = data.valueForKey("last_name") as! String;
                        let userFBID:String = data.valueForKey("id") as! String;
                        
                        let userImageURL = "https://graph.facebook.com/\(userFBID)/picture?type=small";
                        
//                        let url = NSURL(string: userImageURL);
//                        
//                        let imageData = NSData(contentsOfURL: url!);
//                        
//                        let image = UIImage(data: imageData!);
                        
                        let fbAccesToken = FBSDKAccessToken.currentAccessToken().tokenString
                        print("userFBID: \(userFBID) Email \(email) \n firstName:\(firstName) \n lastname:\(lastName)  \n image: \(userImageURL)");
                        print("access token : \(fbAccesToken)")
                        let send = API_Model()
                        send.checkUser(email, completionHandler: {
                            checkData in
                            if (checkData["status"] as! Bool == true)
                            {
                                send.Register(firstName, lastName: lastName, mobile: "", email: email, passWord: self.randomStringWithLength(6) as String)
                                {
                                    regData in
                                    print("Register Data : \(regData)")
//                                    print("userID : \(regData["data"]!["id"])")
                                    let userID = regData["data"]!["id"] as! String
                                    
                                    send.LogInFB(userID, socialAccessToken: fbAccesToken,completionHandler:
                                        {
                                            logData in
                                            print("Data(CreateUsersSocialAccounts) : \(logData)")
                                            if(logData["success"] as! Bool )
                                            {
                                                if let _email = logData["data"]!["email"] as! String? {
                                                    self.appDelegate.userInfo["email"] = _email
                                                }
 
                                                if let _id = logData["data"]!["userID"] as! String? {
                                                    self.appDelegate.userInfo["id"] = _id
                                                }
                                                
                                                if let _accessToken = logData["data"]!["accessToken"] as! String? {
                                                    self.appDelegate.userInfo["accessToken"] = _accessToken
                                                }
                                                if let _avatarImage = logData["data"]!["photoUrl"] as! String? {
                                                    self.appDelegate.userInfo["avatarImage"] = _avatarImage
                                                }
                                                
                                                if let _firstName = logData["data"]!["userProfileObject"]!!["firstName"] as! String? {
                                                    self.appDelegate.userInfo["firstName"] = _firstName
                                                }
                                                
                                                if let _lastName = logData["data"]!["userProfileObject"]!!["lastName"] as! String? {
                                                    self.appDelegate.userInfo["lastName"] = _lastName
                                                }
                                                
                                                
//                                                guard let value = logData["data"]!["userProfileObject"] where
//                                                    self.appDelegate.userInfo["mobile"] == value!["phone"] as? String else {
//                                                        self.appDelegate.userInfo["mobile"] = "aaaa"
//                                                        print("Malformed data received from fetchAllRooms service")
//                                                        return
//                                                }
//                                                if(!self.isNull(logData["data"]!["userProfileObject"]!!["phone"]))
//                                                {
//                                                    if let _mobile = logData["data"]!["userProfileObject"]!!["phone"] as! String? {
//                                                        self.appDelegate.userInfo["mobile"] = _mobile
//                                                    }
//                                                }
                                                
                                                

                                                

                                                
                                                self.appDelegate.isLogin = true
                                                let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MainVC")
                                                self.navigationController?.pushViewController(secondViewController!, animated: true)
                                            }
                                            else{
                                                
                                                self.appDelegate.isLogin = false
                                                titleMessage = "Login fail"
                                                message = data["message"] as! String
                                                PKHUD.sharedHUD.hide(animated: false, completion: {_ in
                                                    
                                                })
                                                
                                                let alertView = SCLAlertView()
                                                alertView.showCircularIcon = false
                                                alertView.showInfo(titleMessage, subTitle: message, colorStyle:0xAC332F, duration: 3.0)
                                            }
                                            
                                            
                                    })
                                    
                                }
                            }else
                            {
                                print("HAS USERS in system : \(checkData["data"]!["id"] as! String)")
                                let userID = checkData["data"]!["id"] as! String
                                send.checkUserFB(userID, completionHandler: {
                                    checkUserFBData in
                                    print("checkUserFBData \(checkUserFBData)")
                                    
                                    if(checkUserFBData["status"] as! Bool == true)
                                    {
                                        send.LogInFB(userID, socialAccessToken: fbAccesToken,completionHandler:
                                            {
                                                logData in
                                                print("Data(CreateUsersSocialAccounts) : \(logData)")
                                                if(logData["success"] as! Bool )
                                                {

                                                    if let _email = logData["data"]!["email"] as! String? {
                                                        self.appDelegate.userInfo["email"] = _email
                                                    }
                                                    
                                                    if let _id = logData["data"]!["userID"] as! String? {
                                                        self.appDelegate.userInfo["id"] = _id
                                                    }
                                                    
                                                    if let _accessToken = logData["data"]!["accessToken"] as! String? {
                                                        self.appDelegate.userInfo["accessToken"] = _accessToken
                                                    }
                                                    if let _avatarImage = logData["data"]!["photoUrl"] as! String? {
                                                        self.appDelegate.userInfo["avatarImage"] = _avatarImage
                                                    }
                                                    
                                                    if let _firstName = logData["data"]!["userProfileObject"]!!["firstName"] as! String? {
                                                        self.appDelegate.userInfo["firstName"] = _firstName
                                                    }
                                                    
                                                    if let _lastName = logData["data"]!["userProfileObject"]!!["lastName"] as! String? {
                                                        self.appDelegate.userInfo["lastName"] = _lastName
                                                    }
                                                    if let _mobile = logData["data"]!["userProfileObject"]!!["phone"] as! String? {
                                                        self.appDelegate.userInfo["mobile"] = _mobile
                                                    }
    
                                                    self.appDelegate.isLogin = true
                                                    let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MainVC")
                                                    self.navigationController?.pushViewController(secondViewController!, animated: true)
                                                } else{
                                                    
                                                    self.appDelegate.isLogin = false
                                                    titleMessage = "Login fail"
                                                    message = data["message"] as! String
                                                    PKHUD.sharedHUD.hide(animated: false, completion: {_ in
                                                        
                                                    })
                                                    
                                                    let alertView = SCLAlertView()
                                                    alertView.showCircularIcon = false
                                                    alertView.showInfo(titleMessage, subTitle: message, colorStyle:0xAC332F, duration: 3.0)
                                                }
                                        })

                                    }else
                                    {
                                        print("checkUserFBData \(checkUserFBData)")
                                        if let _email = checkUserFBData["data"]!["email"] as! String? {
                                            self.appDelegate.userInfo["email"] = _email
                                        }
                                        
                                        if let _id = checkUserFBData["data"]!["userID"] as! String? {
                                            self.appDelegate.userInfo["id"] = _id
                                        }
                                        
                                        if let _accessToken = checkUserFBData["data"]!["accessToken"] as! String? {
                                            self.appDelegate.userInfo["accessToken"] = _accessToken
                                        }
                                        if let _avatarImage = checkUserFBData["data"]!["photoUrl"] as! String? {
                                            self.appDelegate.userInfo["avatarImage"] = _avatarImage
                                        }
                                        
                                        if let _firstName = checkUserFBData["data"]!["userProfileObject"]!!["firstName"] as! String? {
                                            self.appDelegate.userInfo["firstName"] = _firstName
                                        }
                                        
                                        if let _lastName = checkUserFBData["data"]!["userProfileObject"]!!["lastName"] as! String? {
                                            self.appDelegate.userInfo["lastName"] = _lastName
                                        }
//                                        if let _mobile = checkUserFBData["data"]!["userProfileObject"]!!["phone"] as! String? {
//                                            self.appDelegate.userInfo["mobile"] = _mobile
//                                        }
                                        
                                        self.appDelegate.isLogin = true
                                        let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MainVC")
                                        self.navigationController?.pushViewController(secondViewController!, animated: true)
                                    }
                                    

                                    
                                })

                            }
                            
                        })

                        
                    }
                }) 
                
            }
        })

    }
//    func fbCreateUser(firstName:String,lastName:String,email:String) ->() {
//        let register = API_Model()
//        register.Register(firstName, lastName: lastName, mobile: "", email: email, passWord: "")
//        {
//            data in
//            print("Register Data : \(data)")
//        }
//    }


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
                        
                        FIRAnalytics.setUserPropertyString(self.appDelegate.userInfo["email"], forName: "email")
                        
                        self.appDelegate.userInfo["username"] = self.userNameTxt.text
                        self.appDelegate.userInfo["passWord"] = self.passWordTxt.text
                        self.appDelegate.userInfo["email"] = self.userNameTxt.text
                        //
                        
                        self.appDelegate.isLogin = true
                        print("APPDALAGATELOGIN:::\(self.appDelegate.isLogin)")
                        
                        
                        let newMember = MemberData()
                        newMember.id = self.appDelegate.userInfo["id"]!
                        newMember.userID = self.appDelegate.userInfo["userID"]!
                        newMember.avatarImage = self.appDelegate.userInfo["avatarImage"]!
                        newMember.firstName = self.appDelegate.userInfo["firstName"]!
                        newMember.lastName = self.appDelegate.userInfo["lastName"]!
                        newMember.profileName = self.appDelegate.userInfo["profileName"]!
                        newMember.mobile = self.appDelegate.userInfo["mobile"]!
                        newMember.email = self.appDelegate.userInfo["email"]!
                        newMember.username = self.appDelegate.userInfo["username"]!
                        newMember.passWord = self.appDelegate.userInfo["passWord"]!
                        
                        try! uiRealm.write{
                            uiRealm.add(newMember)
                            
                            print("write Yes")
                            self.readDB()
                            
                        }
                        
                        let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MainVC")
                        self.navigationController?.pushViewController(secondViewController!, animated: true)
                        
//                        PKHUD.sharedHUD.hide(animated: false, completion: {_ in
//                            let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MainVC")
//                            self.navigationController?.pushViewController(secondViewController!, animated: true)
//                        })
                        
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
    
    func randomStringWithLength (len : Int) -> NSString {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        
        let randomString : NSMutableString = NSMutableString(capacity: len)
        
        for (var i=0; i < len; i++){
            let length = UInt32 (letters.length)
            let rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.characterAtIndex(Int(rand)))
        }
        
        return randomString
    }
    func isNull(someObject: AnyObject?) -> Bool {
        guard let someObject = someObject else {
            return true
        }
        return (someObject is NSNull)
    }
    
}