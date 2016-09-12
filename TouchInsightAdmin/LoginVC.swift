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
//import PKHUD
import SVProgressHUD

import Firebase
import FirebaseCrash

import FBSDKCoreKit
//import FBSDKShareKit
import FBSDKLoginKit

import RealmSwift

import FontAwesome_swift

import SwiftyJSON

class LoginVC: UIViewController, CLLocationManagerDelegate,UITextFieldDelegate,UIGestureRecognizerDelegate {
    
    var _member : Results<MemberData>!
    
    let send = API_Model()
    let rmm = RmMemberModel()
    
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
        
        SVProgressHUD.setDefaultStyle(.Dark)
//        SVProgressHUD.setDefaultStyle(.Light)
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.Gradient)
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //readDB()
        
        //rmm.MemberData_Delete()
        
        print("- - - - - - - - viewDidLoad - - - - - - - - - - -")
        let rMember = rmm.MemberData_IsExists()
        if((rMember["status"] as! Bool) == true){
            
            print("- - YES - -")
            let mData = rMember["data"]!
            let _accessToken = mData["accessToken"]! as! String
            print(_accessToken)
            print(mData)
            
            if(_accessToken != ""){
                
                print("- - accessToken YES - -")
                self.send.checkToken(mData as! Object, completionHandler: {strToken in
                    
                    let _tk = strToken 
                    
                    print("- - strToken - -")
                    print(_tk)
                    print(strToken)
                    print("- - - - - - - - - -")
                    
                })
                
            }else{
                // Display Login Page
                print("- - accessToken NO - -")
            }
            
        }else{
            print("- - NO - -")
            // Display Login Page
            let mData = rMember["data"]! as! [String:AnyObject]
            print(mData)
        }
        print("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -")

        print("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -")
        
//        if self._member != nil && (self._member).toArray().count > 0{
//            
//            SVProgressHUD.show()
//            
//            //let m = (self._member).toArray().last!
//            //let m = JSON(self._member!)
//            
//            let mData = ((self._member).toArray().last!)
//            
//            print("0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0")
//            print("0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0")
//            print("0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0")
//            print(mData)
//            print("0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0")
//            print("0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0")
//            print("0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0")
//            
//            if ((mData["accessToken"] as! String) == ""){
//                
//                print("accessToken = '' ")
//                
//                self.send.GetUserDataByID((mData["userID"] as! String), completionHandler:{
//                    _StrUserToken in
//                    self.appDelegate.userInfo["accessToken"] = _StrUserToken
//                    
//                    
//                    // - - - - -
//                    //uiRealm.delete(MemberData()) // Not working
//                    let realm = try! Realm()
//                    try! realm.write {
//                        realm.delete(self._member)
//                    }
//                    
//                    //                    try! uiRealm.write{
//                    //                        uiRealm.delete(self._member)
//                    //                        print("Delete newMember")
//                    //                        self.readDB()
//                    //
//                    //                    }
//                    
//                    let newMember = MemberData()
//                    newMember.id = self.appDelegate.userInfo["id"]!
//                    newMember.userID = self.appDelegate.userInfo["userID"]!
//                    newMember.avatarImage = self.appDelegate.userInfo["avatarImage"]!
//                    newMember.firstName = self.appDelegate.userInfo["firstName"]!
//                    newMember.lastName = self.appDelegate.userInfo["lastName"]!
//                    newMember.profileName = self.appDelegate.userInfo["profileName"]!
//                    newMember.mobile = self.appDelegate.userInfo["mobile"]!
//                    newMember.email = self.appDelegate.userInfo["email"]!
//                    newMember.username = self.appDelegate.userInfo["username"]!
//                    newMember.passWord = self.appDelegate.userInfo["passWord"]!
//                    newMember.accessToken = self.appDelegate.userInfo["accessToken"]!
//                    
//                    try! uiRealm.write{
//                        uiRealm.add(newMember)
//                        
//                        print("write Yes")
//                        self.readDB()
//                        
//                    }
//                    // - - - - -
//                    
//                    self.appDelegate.userInfo["userID"] = (mData["userID"] as! String)
//                    self.appDelegate.userInfo["avatarImage"] = (mData["avatarImage"] as! String)
//                    self.appDelegate.userInfo["profileName"] = (mData["profileName"] as! String)
//                    self.appDelegate.userInfo["firstName"] = (mData["firstName"] as! String)
//                    self.appDelegate.userInfo["lastName"] = (mData["lastName"] as! String)
//                    self.appDelegate.userInfo["email"] = (mData["email"] as! String)
//                    self.appDelegate.userInfo["accessToken"] = (mData["accessToken"] as! String)
//                    self.appDelegate.userInfo["mobile"] = (mData["mobile"] as! String)
//                    self.appDelegate.userInfo["passWord"] = (mData["passWord"] as! String)
//                    self.appDelegate.userInfo["id"] = (mData["id"] as! String)
//                    
//                    
//                    print("- - - - - - - - self.appDelegate.userInfo - - - - - - - - - - -")
//                    print(self.appDelegate.userInfo)
//                    print("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -")
//                    
//                    
//                    self.appDelegate.isLogin = true
//                    let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MainVC")
//                    self.navigationController?.pushViewController(secondViewController!, animated: true)
//                    
//                })
//                
//            }else{
//                
//                print("accessToken != '' ")
//                
//                let newMember = MemberData()
//                newMember.id = self.appDelegate.userInfo["id"]!
//                newMember.userID = self.appDelegate.userInfo["userID"]!
//                newMember.avatarImage = self.appDelegate.userInfo["avatarImage"]!
//                newMember.firstName = self.appDelegate.userInfo["firstName"]!
//                newMember.lastName = self.appDelegate.userInfo["lastName"]!
//                newMember.profileName = self.appDelegate.userInfo["profileName"]!
//                newMember.mobile = self.appDelegate.userInfo["mobile"]!
//                newMember.email = self.appDelegate.userInfo["email"]!
//                newMember.username = self.appDelegate.userInfo["username"]!
//                newMember.passWord = self.appDelegate.userInfo["passWord"]!
//                newMember.accessToken = self.appDelegate.userInfo["accessToken"]!
//                
//                try! uiRealm.write{
//                    uiRealm.add(newMember)
//                    
//                    print("write Yes")
//                    self.readDB()
//                    
//                }
//                // - - - - -
//                
//                self.appDelegate.userInfo["userID"] = (mData["userID"] as! String)
//                self.appDelegate.userInfo["avatarImage"] = (mData["avatarImage"] as! String)
//                self.appDelegate.userInfo["profileName"] = (mData["profileName"] as! String)
//                self.appDelegate.userInfo["firstName"] = (mData["firstName"] as! String)
//                self.appDelegate.userInfo["lastName"] = (mData["lastName"] as! String)
//                self.appDelegate.userInfo["email"] = (mData["email"] as! String)
//                self.appDelegate.userInfo["accessToken"] = (mData["accessToken"] as! String)
//                self.appDelegate.userInfo["mobile"] = (mData["mobile"] as! String)
//                self.appDelegate.userInfo["passWord"] = (mData["passWord"] as! String)
//                self.appDelegate.userInfo["id"] = (mData["id"] as! String)
//                
//                
//                print("- - - - - - - - self.appDelegate.userInfo - - - - - - - - - - -")
//                print(self.appDelegate.userInfo)
//                print("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -")
//                
//                
//                self.appDelegate.isLogin = true
//                let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MainVC")
//                self.navigationController?.pushViewController(secondViewController!, animated: true)
//                
//            }
//            
//        }
        
        
        

        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginVC.dismissKeyboard))
        tap.delegate = self
        tap.cancelsTouchesInView = true
        self.view!.addGestureRecognizer(tap)
        
        
        
        
        
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
        btnFbLogin.backgroundColor = UIColor(red:0.19, green:0.33, blue:0.59, alpha:1.00)
//        btnFbLogin.setTitle("Sign up with facebook", forState: UIControlState.Normal)
//        btnFbLogin.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        btnFbLogin.addTarget(self, action: #selector(loginFB) , forControlEvents: UIControlEvents.TouchUpInside)
        
        
        
        var frmBGIconFB = frmBtnFbLogin
        frmBGIconFB.size.width = frmBtnFbLogin.size.height
        let viewBGFbIcon = UIView(frame:frmBGIconFB)
        viewBGFbIcon.backgroundColor = UIColor(red:0.00, green:0.28, blue:0.58, alpha:1.00)
        //viewBGFbIcon.backgroundColor = UIColor.greenColor()
        
        var frmIconFB = frmBtnFbLogin
        frmIconFB.size.width = frmIconFB.size.height - 8
        frmIconFB.size.height = frmIconFB.size.height - 8
        frmIconFB.origin.x = frmBtnFbLogin.origin.x + 4
        frmIconFB.origin.y = frmBtnFbLogin.origin.y + 4
        
        let imgIconFacebook = UIImageView()
        imgIconFacebook.frame = frmIconFB
        
        imgIconFacebook.image = UIImage.fontAwesomeIconWithName(.Facebook, textColor: UIColor.whiteColor(), size: CGSizeMake(frmIconFB.size.width - 8, frmIconFB.size.width - 8))
        imgIconFacebook.contentMode = .ScaleAspectFit
        imgIconFacebook.clipsToBounds = true
        //imgIconFacebook.backgroundColor = UIColor.greenColor()
        
        var frmTitleFB = frmBtnFbLogin
        frmTitleFB.size.width = frmBtnFbLogin.size.width - frmBGIconFB.size.width
        frmTitleFB.origin.x = frmBGIconFB.size.width + frmBGIconFB.origin.x
        let lblTitleFacebook = UILabel()
        lblTitleFacebook.frame = frmTitleFB
        lblTitleFacebook.text = "Sign up with facebook"
        lblTitleFacebook.textAlignment = .Center
        lblTitleFacebook.textColor = UIColor.whiteColor()
        
        
        scrollview.addSubview(btnFbLogin)
        scrollview.addSubview(viewBGFbIcon)
        scrollview.addSubview(imgIconFacebook)
        scrollview.addSubview(lblTitleFacebook)
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
        
        
        let loginManager:FBSDKLoginManager = FBSDKLoginManager()
        
        loginManager.logInWithReadPermissions(["email", "public_profile"], handler: { (
            result:FBSDKLoginManagerLoginResult!, error:NSError!) -> Void in
            
            
            if let _ = error{
                //got error
                print("login got error 1")
                SVProgressHUD.dismiss()
            } else if(result.isCancelled){
                
                print("login canceled")
                SVProgressHUD.dismiss()
                
            } else{
                
                SVProgressHUD.show()
                
//                print("loginManager.logInWithReadPermissions")
//                print(result)
//                print(result.grantedPermissions)
                //                if(result.grantedPermissions.containsObject("email")){
                
                let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters:["fields":"name,email,first_name,last_name"])
//                let request = FBSDKGraphRequest(graphPath: "me", parameters: nil, HTTPMethod: "GET")
                graphRequest.startWithCompletionHandler({ (connection:FBSDKGraphRequestConnection!, data:AnyObject!, error:NSError!) -> Void in
                    
                    if let _ = error{
                        //got error
                        print("login got error 2")
                        SVProgressHUD.dismiss()
                    } else {
                        
                        print("dataAll 111 : \(data)")
                        
                        let email : String = data.valueForKey("email") as! String;
                        let firstName:String = data.valueForKey("first_name") as! String;
                        let lastName:String = data.valueForKey("last_name") as! String;
                        let userFBID:String = data.valueForKey("id") as! String;
                        
                        let userImageURL = "https://graph.facebook.com/\(userFBID)/picture?width=260&height=260";
                        //https://graph.facebook.com/1257021660984067/picture?width=150&height=150
                        
//                        let url = NSURL(string: userImageURL);
//                        let imageData = NSData(contentsOfURL: url!);
//                        let image = UIImage(data: imageData!);
                        
                        let fbAccesToken = FBSDKAccessToken.currentAccessToken().tokenString
                        print("userFBID: \(userFBID) Email \(email) \n firstName:\(firstName) \n lastname:\(lastName)  \n image: \(userImageURL)");
                        print("access token : \(fbAccesToken)")
                        self.send.checkUser(email, completionHandler: {
                            checkData in
                            
                            print("checkData 222 : \(checkData)")
                            
                            if (checkData["status"] as! Bool == true) {
                                print("checkData status : 1")
                                
                                let randPassword = self.randomStringWithLength(6) as String
                                
                                self.send.Register(firstName, lastName: lastName, mobile: "", email: email, passWord: randPassword) {
                                    regData in
                                    print("Register Data 3333 : \(regData)")
//                                    print("userID : \(regData["data"]!["id"])")
                                    let userID = regData["data"]!["id"] as! String
                                    
                                    self.send.LogInFB(userID, socialAccessToken: fbAccesToken,completionHandler:
                                        {
                                            logData in
                                            
                                            print("Data(CreateUsersSocialAccounts) 4444 : \(logData)")
                                            
                                            
                                            if(logData["success"] as! Bool ) {
                                                if let _email = logData["data"]!["email"] as! String? {
                                                    self.appDelegate.userInfo["email"] = _email
                                                }
 
                                                if let _id = logData["data"]!["userId"] as! String? {
                                                    self.appDelegate.userInfo["id"] = _id
                                                }
                                                
////                                                if let _accessToken = logData["data"]!["accessToken"] as! String? {
////                                                    self.appDelegate.userInfo["accessToken"] = _accessToken
////                                                }
                                                if let _avatarImage = logData["data"]!["photoUrl"] as! String? {
                                                    self.appDelegate.userInfo["avatarImage"] = _avatarImage
                                                }
                                                
                                                if let _firstName = logData["data"]!["userProfileObject"]!!["firstName"] as! String? {
                                                    self.appDelegate.userInfo["firstName"] = _firstName
                                                }
                                                
                                                if let _lastName = logData["data"]!["userProfileObject"]!!["lastName"] as! String? {
                                                    self.appDelegate.userInfo["lastName"] = _lastName
                                                }
                                                
                                                self.appDelegate.userInfo["profileName"] = "\(self.appDelegate.userInfo["firstName"]!) \(self.appDelegate.userInfo["lastName"]!)"
                                                
                                                
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
                                                
                                                
                                                self.send.GetToken({_ in
                                                    
                                                    let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MainVC")
                                                    self.navigationController?.pushViewController(secondViewController!, animated: true)
                                                    
                                                })
                                                

                                                
                                            } else {
                                                
                                                self.appDelegate.isLogin = false
                                                titleMessage = "Login fail"
                                                message = data["message"] as! String
                                                
                                                SVProgressHUD.dismiss()
                                                
                                                let alertView = SCLAlertView()
                                                alertView.showCircularIcon = false
                                                alertView.showInfo(titleMessage, subTitle: message, colorStyle:0xAC332F, duration: 3.0)
                                            }
                                            
                                            
                                    })
                                    
                                }
                            } else {
                                
                                print("checkData status : 0 (มีีอยู่ในระบบแล้ว)")
                                print("HAS USERS in system : \(checkData["data"]!["id"] as! String)")
                                
                                let userID = checkData["data"]!["id"] as! String
                                self.send.checkUserFB(userID, completionHandler: {
                                    checkUserFBData in
                                    let _checkUserFBData = JSON(checkUserFBData)
                                    
                                    print("checkUserFBData x 1 : \(Bool(_checkUserFBData["status"]))")
                                    
                                    if(Bool(_checkUserFBData["status"]) == true){
                                        
                                        self.send.LogInFB(userID, socialAccessToken: fbAccesToken,completionHandler:{
                                            logData in
                                            
                                            print("logData x 2 : \(logData)")
                                        
                                            
                                                if(logData["success"] as! Bool ){

                                                    if let _email = logData["data"]!["email"] as! String? {
                                                        self.appDelegate.userInfo["email"] = _email
                                                    }
                                                    
                                                    if let _id = logData["data"]!["userId"] as! String? {
                                                        self.appDelegate.userInfo["id"] = _id
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
                                                    
                                                    self.appDelegate.userInfo["profileName"] = "\(self.appDelegate.userInfo["firstName"]!) \(self.appDelegate.userInfo["lastName"]!)"
                                                    
                                                    if logData["data"]!["userProfileObject"]!!["phone"] != nil && !(logData["data"]!["userProfileObject"]!!["phone"] is NSNull){
                                                        if let _mobile = logData["data"]!["userProfileObject"]!!["phone"] as! String? {
                                                            self.appDelegate.userInfo["mobile"] = _mobile
                                                        }
                                                    }
                                                    
                                                    self.send.GetToken({
                                                        _StrUserToken in
                                                        self.appDelegate.userInfo["accessToken"] = _StrUserToken 
                                                        
                                                        
                                                        // - - - - -
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
                                                        // - - - - -
                                                        
                                                        
                                                        self.appDelegate.isLogin = true
                                                        let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MainVC")
                                                        self.navigationController?.pushViewController(secondViewController!, animated: true)
                                                        
                                                    })
                                                    
    
                                                } else{
                                                    
                                                    self.appDelegate.isLogin = false
                                                    titleMessage = "Login fail"
                                                    message = data["message"] as! String
                                                    
                                                    SVProgressHUD.dismiss()
                                                    
                                                    let alertView = SCLAlertView()
                                                    alertView.showCircularIcon = false
                                                    alertView.showInfo(titleMessage, subTitle: message, colorStyle:0xAC332F, duration: 3.0)
                                                }
                                        })

                                    }else{
                                        
//                                        print("checkUserFBData \(checkUserFBData)")
                                        print("checkUserFBData xxxxc : \(_checkUserFBData)")
                                        
                                        if let _email = checkUserFBData["data"]!["email"] as! String? {
                                            self.appDelegate.userInfo["email"] = _email
                                        }
                                        
                                        if let _id = checkUserFBData["data"]!["userId"] as! String? {
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
                                        
                                        self.appDelegate.userInfo["profileName"] = "\(self.appDelegate.userInfo["firstName"]!) \(self.appDelegate.userInfo["lastName"]!)"
                                        
//                                        if let _mobile = checkUserFBData["data"]!["userProfileObject"]!!["phone"] as! String? {
//                                            self.appDelegate.userInfo["mobile"] = _mobile
//                                        }
                                        
                                        if checkUserFBData["data"]!["userProfileObject"]!!["phone"] != nil && !(checkUserFBData["data"]!["userProfileObject"]!!["phone"] is NSNull){
                                            if let _mobile = checkUserFBData["data"]!["userProfileObject"]!!["phone"] as! String? {
                                                self.appDelegate.userInfo["mobile"] = _mobile
                                            }
                                        }
                                        
                                        self.send.GetToken({
                                            _StrUserToken in
                                            self.appDelegate.userInfo["accessToken"] = _StrUserToken
                                            
                                            // - - - - -
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
                                            // - - - - -
                                            
                                            
                                            self.appDelegate.isLogin = true
                                            let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MainVC")
                                            self.navigationController?.pushViewController(secondViewController!, animated: true)
                                            
                                        })
                                        
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
            
            SVProgressHUD.show()
            
            
            login.LogIn(userNameTxt.text!, password: passWordTxt.text!,latitude: latitude!,longitude: longitude!)
            {
                data in
                print("login.LogIn")
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
                        
                        print("login.getUserInfo")
                        print("data : \(data)")
                        
                        let _data = JSON(data)
                        
                        print("_data : \(_data)")
                        
                        //self.appDelegate.userInfo["avatarImage"] = _avatarImage
                        
//                        if let _avatarImage = _data["avatar"]{
//                            self.appDelegate.userInfo["avatarImage"] = _data["avatar"]
//                        }
//                        self.appDelegate.userInfo["avatarImage"] = String(_data["avatar"])
                        
//                        if let _firstName = _data["firstName"]{
//                            self.appDelegate.userInfo["firstName"] = _firstName
//                        }
                        self.appDelegate.userInfo["firstName"] = String(_data["firstName"])
                        
//                        if let _lastName = _data["lastName"] as! String? {
//                            self.appDelegate.userInfo["lastName"] = _lastName
//                        }
                        self.appDelegate.userInfo["lastName"] = String(_data["lastName"])
                        
//                        if let _email = _data["email"] as! String? {
//                            self.appDelegate.userInfo["email"] = _email
//                        }
                        self.appDelegate.userInfo["email"] = String(_data["email"])
                        
//                        if let _mobile = _data["phoneNumber"] as! String? {
//                            self.appDelegate.userInfo["mobile"] = _mobile
//                        }
                        self.appDelegate.userInfo["mobile"] = String(_data["phoneNumber"])
                        
                        
//                        if let _id = _data["id"] as! String? {
//                            self.appDelegate.userInfo["id"] = _id
//                        }
                        self.appDelegate.userInfo["id"] = String(_data["id"])
                        
                        self.appDelegate.userInfo["profileName"] = "\(self.appDelegate.userInfo["firstName"]!) \(self.appDelegate.userInfo["lastName"]!)"
                        
                        //FIRAnalytics.setUserPropertyString(self.appDelegate.userInfo["email"], forName: "email")
                        
                        self.appDelegate.userInfo["username"] = self.userNameTxt.text
                        self.appDelegate.userInfo["passWord"] = self.passWordTxt.text
                        self.appDelegate.userInfo["email"] = self.userNameTxt.text
                        //
                        
                        print("self.appDelegate.userInfo")
                        print(self.appDelegate.userInfo)
                        print("-------------------------")
                        
                        self.send.GetToken({_ in
                            
                            let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MainVC")
                            self.navigationController?.pushViewController(secondViewController!, animated: true)
                            
                        })
                        
                    }
                }else{
                    self.appDelegate.isLogin = false
                    titleMessage = "Login fail"
                    message = data["message"] as! String
                   
                    SVProgressHUD.dismiss()
                    
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