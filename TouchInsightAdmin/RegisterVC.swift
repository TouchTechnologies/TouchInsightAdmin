//
//  RegisterVC.swift
//  TouchInsightAdmin
//
//  Created by Touch on 11/26/2558 BE.
//  Copyright © 2558 weerapons suwanchatree. All rights reserved.
//

import UIKit
import SCLAlertView
import PKHUD
class RegisterVC: UIViewController , UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var firstNameTxt: UITextField!
    @IBOutlet weak var lastNameTxt: UITextField!
    @IBOutlet weak var mobileTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passWordTxt: UITextField!
    @IBOutlet weak var profileImg: UIImageView!
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let alert = SCLAlertView()
    
    var longitude:String? = "0.00"
    
    @IBAction func btnBackLoginView(sender: AnyObject) {
        
        self.navigationController?.popToRootViewControllerAnimated(true)
        
    }
    
    @IBAction func back(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(appDelegate.latitude)
        print(appDelegate.longitude)
        
        mobileTxt.delegate = self
        emailTxt.addTarget(self, action: #selector(RegisterVC.checkTextField), forControlEvents: UIControlEvents.EditingChanged)
        mobileTxt.addTarget(self, action: #selector(RegisterVC.checkTextField), forControlEvents: UIControlEvents.EditingChanged)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RegisterVC.dismissKeyboard))
        self.view!.addGestureRecognizer(tap)
        self.setViewStyle()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        // Do any additional setup after loading the view.
    }
    
    func setViewStyle(){
        
        //set bg image
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"bglogin12.png")!)
        
        profileImg.layer.borderWidth = 1
        profileImg.layer.borderColor = UIColor.grayColor().CGColor
        
        //set txt placeholder
        firstNameTxt.attributedPlaceholder = NSAttributedString(string:"Firstname",attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        firstNameTxt.layer.borderWidth = 1
        firstNameTxt.layer.borderColor = UIColor.grayColor().CGColor
        
        lastNameTxt.attributedPlaceholder = NSAttributedString(string:"Lastname",attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        lastNameTxt.layer.borderWidth = 1
        lastNameTxt.layer.borderColor = UIColor.grayColor().CGColor
        
        mobileTxt.attributedPlaceholder = NSAttributedString(string:"Mobile",attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        mobileTxt.layer.borderWidth = 1
        mobileTxt.layer.borderColor = UIColor.grayColor().CGColor
        
        emailTxt.attributedPlaceholder = NSAttributedString(string:"Email",attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        emailTxt.layer.borderWidth = 1
        emailTxt.layer.borderColor = UIColor.grayColor().CGColor
        
        passWordTxt.attributedPlaceholder = NSAttributedString(string:"Password",attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        passWordTxt.layer.borderWidth = 1
        passWordTxt.layer.borderColor = UIColor.grayColor().CGColor
        
        
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(textField: UITextField) {
        if(textField == mobileTxt)
        {
            print("mobile")
        }
    }
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange,
                   replacementString string: String) -> Bool
    {
        if(textField == mobileTxt)
        {
            let maxLength = 10
            let currentString: NSString = mobileTxt.text!
            let newString: NSString =
                currentString.stringByReplacingCharactersInRange(range, withString: string)
            return newString.length <= maxLength
        }
        else
        {
            return true
        }
        
    }
    func checkTextField() {
        if(!isValidEmail(emailTxt.text!))
        {
            emailTxt.textColor = UIColor.redColor()
        }else{
            emailTxt.textColor = UIColor.whiteColor()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func registerBtn(sender: AnyObject) {
        

        
        
        let register = API_Model()
        var titleMessage:String = ""
        var message:String = "กรุณากรอก "
        let username = emailTxt.text
        let password = passWordTxt.text
        
        
        if firstNameTxt.text == ""
        {
            titleMessage = "Register fail"
            message += "firstname "
        }
        if lastNameTxt.text == ""
        {
            titleMessage = "Register fail"
            message += "lastname "
        }
        if mobileTxt.text == ""
        {
            titleMessage = "Register fail"
            message += "moblie "
        }
        //        if (emailTxt.text == "" ) || (!isValidEmail(emailTxt.text!))
        //        {
        //            print("email")
        //            if !isValidEmail(emailTxt.text!)
        //            {
        //                message += "รูปแบบ email ผิด "
        //            }
        //            else
        //            {
        //                message += "email "
        //            }
        //
        //        }
        if emailTxt.text == ""
        {
            titleMessage = "Register fail"
            message += "email "
        }else if !isValidEmail(emailTxt.text!)
        {
            titleMessage = "Register fail"
            message += "รูปแบบ email ผิด "
        }
        if (passWordTxt.text == "") || (self.passWordTxt.text!.characters.count < 4)
        {
            titleMessage = "Register fail"
            print("count pass \(self.passWordTxt.text!.characters.count)")
            if self.passWordTxt.text!.characters.count < 4 && self.passWordTxt.text!.characters.count != 0
            {
                message += "password น้อยกว่า 4 ตัว"
            }
            else
            {
                message += "password"
            }
        }
        if (firstNameTxt.text != "") && (lastNameTxt.text != "") && (mobileTxt.text != "") && (emailTxt.text != "") && (passWordTxt.text != "") && (self.passWordTxt.text!.characters.count >= 4)
        {
            PKHUD.sharedHUD.dimsBackground = false
            PKHUD.sharedHUD.userInteractionOnUnderlyingViewsEnabled = false
            
            PKHUD.sharedHUD.contentView = PKHUDProgressView()
            //        PKHUD.sharedHUD.contentView = PKHUDStatusView(title: "Loading", subtitle: "Subtitle", image: nil)
            PKHUD.sharedHUD.show()
            
            register.Register(firstNameTxt.text!, lastName: lastNameTxt.text!, mobile: mobileTxt.text!, email: emailTxt.text!, passWord: passWordTxt.text!)
            {
                data in
                print("data :\(data)")
                print("status : \(data["status"])")
                if (data["status"] as! Bool)
                {
                    register.LogIn(username!, password: password!, latitude: self.appDelegate.latitude, longitude: self.appDelegate.longitude)
                    {
                        data in
                        
                        //self.appDelegate.accessToken = data["accessToken"] as! String
                        //print("ACCESS : \(self.appDelegate.accessToken)")
                        
                        // self.appDelegate.accessToken = data["accessToken"] as! String
                        // print("ACCESS : \(self.appDelegate.accessToken)")
                        
                        //                            self.appDelegate.accessToken = data["accessToken"] as! String
                        //                            print("ACCESS : \(self.appDelegate.accessToken)")
                        //                            let profileImage = UIImage(named:"profile-icon.png")!
                        if(self.profileImg.image == nil)
                        {
                            print("No Image")
                        }
                        
                        register.CreateUserAvatar(self.appDelegate.userInfo["userID"]! ,image: self.profileImg.image!)
                        {
                            data in
                            print("CreateUserAvatar \(data)")
                            PKHUD.sharedHUD.contentView = PKHUDSuccessView()
                            PKHUD.sharedHUD.hide(afterDelay: 2.0)
                            
                            titleMessage = "Register Success"
                            message = "ยินดีตอนรับเข้าสู่ระบบ"
                            SCLAlertView().showInfo(titleMessage, subTitle: message, colorStyle:0xAC332F)
                            
                            
                        }
                        register.getUserInfo(self.appDelegate.userInfo["userID"]! as String)
                        {
                            data in
                            print("data : \(data)")
                            //                                 = (data["profileName"] as! String)
                            //                                self.lblEmail.text = (data["email"] as! String)
                            
                            let dataJson = "{\"providerUser\":\"\(data["email"]!)\"}"
                            //print("appDelegate :\(appDelegate.userInfo["email"])")
                            print("dataSendJson : \(dataJson)")
                            register.providerAPI(self.appDelegate.command["listProvider"]!, dataJson: dataJson){
                                data in
                                
                                print("listProvider :\(data["ListProviderInformationSummary"]!)")
                                self.appDelegate.providerData = data
                                print("Count: \(self.appDelegate.providerData!["ListProviderInformationSummary"]!.count)")
                                
                                self.appDelegate.isLogin = true
                                print("APPDALAGATELOGIN:::\(self.appDelegate.isLogin)")
                            }
                        }
                        let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("introview")
                        self.navigationController?.pushViewController(secondViewController!, animated: true)
                        
                        print(data)
                        print("Login Successs")
                    }
                    
                    
                }
                else
                {
                    
                    PKHUD.sharedHUD.hide(afterDelay: 2.0)
                    titleMessage = "Register fail"
                    message = "Email ผิดหรือ มีอยู่ในระบบ"
                    
                    self.alert.showCircularIcon = false
                    self.alert.showInfo(titleMessage, subTitle: message, colorStyle:0xAC332F)
                }
                
            }
        }else
        {
//            PKHUD.sharedHUD.contentView = PKHUDErrorView()
//            PKHUD.sharedHUD.hide(afterDelay: 0.1)
            self.alert.showCircularIcon = false
            self.alert.showInfo(titleMessage, subTitle: message, colorStyle:0xAC332F)
        }
        
    }
    func isValidEmail(email:String) -> Bool {
        // println("validate calendar: \(testStr)")
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(email)
    }
    func isValidMobile(value: String) -> Bool {
        
        let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
        
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        
        let result =  phoneTest.evaluateWithObject(value)
        
        return result
        
    }
    
    @IBAction func backLoginBtn(sender: AnyObject) {
    }
    @IBAction func addProfileImg(sender: AnyObject) {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(myPickerController, animated: true, completion: nil)
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        print("ImagePicker:profileImage")
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        
        profileImg.contentMode = .ScaleAspectFit //3
        profileImg.image = chosenImage //4
        //let imageURL = info[UIImagePickerControllerReferenceURL] as! NSURL
        //let imageName = imageURL.pathComponents![1];
        //        print("imageName : \(imageName)")
        //
        //        let send = API_Model()
        //        let userID = appDelegate.userInfo["userID"]
        //        send.CreateUserAvatar(userID!,image: chosenImage)
        //            {
        //                data in
        //                print("CreateUserAvatar \(data)")
        //
        //        }
        profileImg.reloadInputViews()
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func dismissKeyboard()
    {
        firstNameTxt.resignFirstResponder()
        lastNameTxt.resignFirstResponder()
        mobileTxt.resignFirstResponder()
        emailTxt.resignFirstResponder()
        passWordTxt.resignFirstResponder()
    }
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(RegisterVC.keyboardDidShow(_:)), name: UIKeyboardDidShowNotification, object: nil)
        return true
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(RegisterVC.keyboardDidHide(_:)), name: UIKeyboardDidHideNotification, object: nil)
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
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
