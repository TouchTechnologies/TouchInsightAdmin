//
//  LoginVC.swift
//  TouchInsightAdmin
//
//  Created by weerapons suwanchatree on 11/26/2558 BE.
//  Copyright © 2558 weerapons suwanchatree. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import SMPageControl
import SCLAlertView
import CoreLocation
import MapKit
import RNCryptor
import PKHUD

class LoginVC: UIViewController, CLLocationManagerDelegate,UITextFieldDelegate {

    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var passWordTxt: UITextField!
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var latitude:String? = "0.00"
    var longitude:String? = "0.00"
    
    let locationManager = CLLocationManager()
  
    var alertView = SCLAlertView()
    
    @IBAction func registBtn(sender: AnyObject) {
        
        performSegueWithIdentifier("toRegist", sender: self)
    }
    override func viewDidLoad() {
        appDelegate.isLogin = false
        alertView.showCircularIcon = false
        super.viewDidLoad()
        self.setViewStyle()
        self.navigationController?.setNavigationBarHidden(true, animated: true)

     //  userNameTxt.text = "gift@m.c"
//passWordTxt.text = "123456789"
        
        
//*******************User Test**********************//
//       userNameTxt.text = "pair@p.z"
//       passWordTxt.text = "12345678"
       
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
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidShow:", name: UIKeyboardDidShowNotification, object: nil)
        return true
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidHide:", name: UIKeyboardDidHideNotification, object: nil)
        self.view!.endEditing(true)
        return true
    }
    func keyboardDidShow(notification: NSNotification) {
        
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
        
    }
    
    func keyboardDidHide(notification: NSNotification) {
        
        let width: CGFloat = UIScreen.mainScreen().bounds.size.width
        let height: CGFloat = UIScreen.mainScreen().bounds.size.height
        self.view!.frame = CGRectMake(0, 0, width, height)
        
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
        
        let login = API_Model()
        var titleMessage:String = ""
        var message:String = ""
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
        if userNameTxt.text != "" && passWordTxt.text != ""
        {
            login.LogIn(userNameTxt.text!, password: passWordTxt.text!,latitude: latitude!,longitude: longitude!)
                {
                    data in
                    print(data)
                    

                    if (data["status"] as! Bool)
                    {

                        titleMessage = "Login Success"
                        message = "ยินดีต้อนรับเข้าสู่ระบบ"
//                        SCLAlertView().showInfo(titleMessage, subTitle: message, colorStyle:0xAC332F)
//                        print("SUCCESS")

                        
//                        appDelegate.firstName = 
//                        login.getUserInfo(data["userID"] as! String)
                        login.getUserInfo(self.appDelegate.userInfo["userID"]! as String)
                            {
                                data in
                                PKHUD.sharedHUD.hide(afterDelay: 0.1)
                                print("data : \(data)")
//                                 = (data["profileName"] as! String)
//                                self.lblEmail.text = (data["email"] as! String)
                                
                                let dataJson = "{\"providerUser\":\"\(data["email"]!)\"}"
                                //print("appDelegate :\(appDelegate.userInfo["email"])")
                                print("dataSendJson : \(dataJson)")
                                login.providerAPI(self.appDelegate.command["listProvider"]!, dataJson: dataJson){
                                    data in
                                    
                                    print("listProvider :\(data["ListProviderInformationSummary"]!)")
                                    self.appDelegate.providerData = data
                                    print("Count: \(self.appDelegate.providerData!["ListProviderInformationSummary"]!.count)")
                                   
                                    self.alertView.showTitle(titleMessage, subTitle: message, style: SCLAlertViewStyle.Success, closeButtonTitle: "OK" , duration: 3.0, colorStyle: 0xAC332F, colorTextButton: 0xFFFFFF)
                                    
                                    let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MainVC")
                                    self.navigationController?.pushViewController(secondViewController!, animated: true)


                                    self.appDelegate.isLogin = true
                                    print("APPDALAGATELOGIN:::\(self.appDelegate.isLogin)")
                                }
                        }
                    }
                    else
                    {
                        self.appDelegate.isLogin = false
                        titleMessage = "Login fail"
                        message = data["message"] as! String
                       self.alertView.showInfo(titleMessage, subTitle: message, colorStyle:0xAC332F, duration: 1.0)
                        print(" Message = \(data["message"])")
                        PKHUD.sharedHUD.contentView = PKHUDSuccessView()
                        PKHUD.sharedHUD.hide(afterDelay: 1.0)
                    }

            }
        }
        else if userNameTxt.text == "" && passWordTxt.text == ""
        {
            titleMessage = "Login fail"
            message = "กรุณากรอก Username และ Password"
           alertView.showInfo(titleMessage, subTitle: message, colorStyle:0xAC332F, duration: 1.0)
        }
        else if userNameTxt.text == ""
        {
            titleMessage = "Login fail"
            message = "กรุณากรอก Username"
           alertView.showInfo(titleMessage, subTitle: message, colorStyle:0xAC332F, duration: 1.0)
        }
        else if passWordTxt.text == ""
        {
            titleMessage = "Login fail"
            message = "กรุณากรอก Password"
           alertView.showInfo(titleMessage, subTitle: message, colorStyle:0xAC332F, duration: 1.0)
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