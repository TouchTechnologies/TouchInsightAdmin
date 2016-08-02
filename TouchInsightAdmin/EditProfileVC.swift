//
//  EditProfileVC.swift
//  TouchInsightAdmin
//
//  Created by Touch on 12/2/2558 BE.
//  Copyright © 2558 weerapons suwanchatree. All rights reserved.
//

import UIKit
import SCLAlertView

class EditProfileVC: UIViewController , UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var txtFirstName: UITextField!
    
    @IBOutlet var addProfileImg: UIButton!
    @IBOutlet var txtLastName: UITextField!
    
    @IBOutlet var txtMobile: UITextField!
    @IBOutlet var txtEmail: UITextField!
    
    @IBOutlet weak var ProfileImg: UIImageView!
    @IBOutlet var txtPassword: UITextField!
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    @IBAction func btnBack(sender: AnyObject) {
        //self.navigationController?.popToRootViewControllerAnimated(true)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func addImageProfile(sender: AnyObject) {
        
        
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(myPickerController, animated: true, completion: nil)
        
    }
    @IBAction func saveProfileBtn(sender: AnyObject) {
        
        let send = API_Model()
        
        let passWord = (txtPassword.text == "") ? appDelegate.userInfo["passWord"]! : txtPassword.text
        
        send.updateUser(txtFirstName.text!, lastName: txtLastName.text!, mobile: txtMobile.text!, email: txtEmail.text!, passWord: passWord!){
            data in
            print("data(updateUser) \(data)")
            if (data["status"]! as! NSObject == 1)
            {
                send.getUserInfo(self.appDelegate.userInfo["userID"]! as String)
                {
                    data in
                    print("data User : \(data)")
                    
                    let alert = SCLAlertView()
                    //                        alert.addButton("OK"){
                    //                        print("Update OK")
                    //                        let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MainVC")
                    //                        self.navigationController?.pushViewController(secondViewController!, animated: true)
                    //                        }
                    alert.showCircularIcon = false
                    alert.showTitle("Info", subTitle: "Update Profile Success", style: SCLAlertViewStyle.Success, closeButtonTitle: "OK", duration: 1, colorStyle:0xDB3F42 , colorTextButton: 0xFFFFFF)
                    
                }
                
            }
        }
    }
    
    func setViewStyle(){
        txtFirstName.layer.borderColor = UIColor(red: 0.13, green: 0.14, blue: 0.18, alpha: 0.2).CGColor
        txtFirstName.layer.borderWidth = 1
        
        txtLastName.layer.borderColor = UIColor(red: 0.13, green: 0.14, blue: 0.18, alpha: 0.2).CGColor
        txtLastName.layer.borderWidth = 1
        
        ProfileImg.layer.borderColor = UIColor(red: 0.13, green: 0.14, blue: 0.18, alpha: 0.2).CGColor
        ProfileImg.layer.borderWidth = 1
        
        
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        //txtLastName.resignFirstResponder()
        // txtMobile.resignFirstResponder()
        // txtEmail.resignFirstResponder()
        // txtPassword.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViewStyle()
        txtFirstName.text = appDelegate.userInfo["firstName"]
        txtLastName.text = appDelegate.userInfo["lastName"]
        txtMobile.text = appDelegate.userInfo["mobile"]
        txtEmail.text = appDelegate.userInfo["email"]
        
        if let avatar = self.appDelegate.userInfo["avatarImage"] {
            print("has avatar : \(self.appDelegate.userInfo["avatarImage"])")
            //ProfileImg.image = UIImage(data:NSData(contentsOfURL:NSURL(string:avatar)!)!)
            ProfileImg.hnk_setImageFromURL(NSURL(string:avatar)!)
        }else{
            print("no avatar")
            ProfileImg.image = UIImage(named: "ic_team.png")
        }
        //        txtPassword.text = appDelegate.userInfo["passWord"]
        //        print(appDelegate.userInfo["firstName"])
        //        print(appDelegate.userInfo["mobile"])
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        print("ImagePicker:profileImage")
        var chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        
        chosenImage = FileMan().resizeImage(chosenImage, maxSize: 1500)
        
        ProfileImg.contentMode = .ScaleAspectFit //3
        ProfileImg.image = chosenImage //4
        let imageURL = info[UIImagePickerControllerReferenceURL] as! NSURL
        let imageName = imageURL.pathComponents![1];
        print("imageName : \(imageName)")
        
        let send = API_Model()
        let userID = appDelegate.userInfo["userID"]
        send.CreateUserAvatar(userID!,image: chosenImage){
            data in
            print("CreateUserAvatar \(data)")
            
        }
        ProfileImg.reloadInputViews()
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.navigationController?.navigationBarHidden = false
    }
    
    override func viewWillDisappear(animated: Bool) {
        
//        self.navigationController?.navigationBarHidden = true
    }
    
    
    //    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
    //
    //            NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidShow:", name: UIKeyboardDidShowNotification, object: nil)
    //            return true
    //
    //
    //    }
    //
    //    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
    //        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidHide:", name: UIKeyboardDidHideNotification, object: nil)
    //        self.view!.endEditing(true)
    //        return true
    //    }
    
    
    /*
     func keyboardDidShow(notification: NSNotification) {
     
     //        alert.frame = popupView.bounds    }, completion: nil)
     // Assign new frame to your view
     
     let width: CGFloat = UIScreen.mainScreen().bounds.size.width
     let height: CGFloat = UIScreen.mainScreen().bounds.size.height
     var keyboardInfo: [NSObject : AnyObject] = notification.userInfo!
     let keyboardFrameBegin: NSValue = keyboardInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue
     let keyboardFrameBeginRect: CGRect =
     keyboardFrameBegin.CGRectValue()
     
     self.view!.frame = CGRectMake(0,-keyboardFrameBeginRect.size.height/7, width, height)
     
     
     }
     
     func keyboardDidHide(notification: NSNotification) {
     
     let width: CGFloat = UIScreen.mainScreen().bounds.size.width
     let height: CGFloat = UIScreen.mainScreen().bounds.size.height
     self.view!.frame = CGRectMake(0, 0, width, height)
     
     }
     */
    
    
    
    
    
    
    
    
    //    let userID = "4868"
    //    let image = UIImage(named: "bglogin5.png")
    //    login.CreateUserAvatar(userID,image: image!)
    //    {
    //    data in
    //    print("CreateUserAvatar \(data)")
    //    }
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}
