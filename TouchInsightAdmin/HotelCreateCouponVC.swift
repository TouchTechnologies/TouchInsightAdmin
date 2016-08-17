//
//  HotelCreateCouponVC.swift
//  TouchInsightAdmin
//
//  Created by Touch on 12/9/2558 BE.
//  Copyright © 2558 weerapons suwanchatree. All rights reserved.
//

import UIKit
import SCLAlertView
import PKHUD

extension String {
    func toDateFormattedWith(format:String)-> NSDate {
        let formatter = NSDateFormatter()
        formatter.dateFormat = format
        return formatter.dateFromString(self)!
    }
}

class HotelCreateCouponVC: UIViewController,UITextFieldDelegate,UITextViewDelegate,UIPickerViewDelegate,UIScrollViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIGestureRecognizerDelegate,CustomIOS7AlertViewDelegate {
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let send = API_Model()
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    var navunderlive = UIView()
    var width = CGFloat()
    var heigth = CGFloat()
    var occupencyNum = Int32()
    var roomImageUpload = [UIImage()]
    var roomGallery = [UIImage()]
    
    
    // Header Section
    @IBOutlet weak var viewSectionHeader: UIView!
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var viewEmptyLogo: UIView!
    
    @IBOutlet weak var viewProviderName: UIView!
    @IBOutlet weak var imgIconProName: UIImageView!
    @IBOutlet weak var lblProName: UILabel!
    // --------------
    
    
    // Description Section
    @IBOutlet weak var viewSectionDescription: UIView!
    @IBOutlet weak var txtCouponName: TextFieldPadd!
    @IBOutlet weak var txtShortDes: UITextView!
    
    // DateTime - Coupon Start
    @IBOutlet weak var viewBgDateStart: UIView!
    @IBOutlet weak var viewBgDateEnd: UIView!
    @IBOutlet weak var txtDateStart: TextFieldPadd!
    @IBOutlet weak var txtDateEnd: TextFieldPadd!
    // --
    
    
    // DateTime - Time to use coupon promotion
    @IBOutlet weak var viewBgUseStart: UIView!
    @IBOutlet weak var viewBgUseEnd: UIView!
    @IBOutlet weak var txtUseStart: TextFieldPadd!
    @IBOutlet weak var txtUseEnd: TextFieldPadd!
    // --
    
    @IBOutlet weak var txtCouponCount: TextFieldPadd!
    @IBOutlet weak var txtValidate: TextFieldPadd!
    @IBOutlet weak var txtPrefixCode: TextFieldPadd!
    
    @IBOutlet weak var viewBoxLongDescription: UIView!
    @IBOutlet weak var txtLongDes: UITextView!
    // --------------
    
    
    // Discount Section
    @IBOutlet weak var viewSectionDiscount: UIView!
    
    @IBOutlet weak var lblDisCash: UILabel!
    @IBOutlet weak var lblDisPercent: UILabel!
    @IBOutlet weak var lblItemTHB: UILabel!
    @IBOutlet weak var lblItemPercent: UILabel!
    
    @IBOutlet weak var viewBgDisCash: UIView!
    @IBOutlet weak var viewBgDisPercent: UIView!
    
    @IBOutlet weak var imgCheckDisCash: UIImageView!
    @IBOutlet weak var imgCheckDisPercent: UIImageView!
    
    @IBOutlet weak var txtPrice: TextFieldPadd!
    @IBOutlet weak var txtDisCash: TextFieldPadd!
    @IBOutlet weak var txtDisPercent: TextFieldPadd!
    
    // --------------
    
    
    // Condition Section
    @IBOutlet weak var viewSectionCondition: UIView!
    @IBOutlet weak var txtCondition: UITextView!
    @IBOutlet weak var txtContactPhone: TextFieldPadd!
    @IBOutlet weak var txtContactEmail: TextFieldPadd!
    
    @IBOutlet weak var imgCheckStatusPublic: UIImageView!
    @IBOutlet weak var imgCheckStatusUnPublic: UIImageView!
    
    @IBOutlet weak var lblStatusPublic: UILabel!
    @IBOutlet weak var lblStatusUnPublic: UILabel!
    // --------------
    
    @IBAction func btnOpenLongDesriptionClick(sender: AnyObject) {
        
        self.txtLongDes.becomeFirstResponder()
      
        let stbHeight = UIApplication.sharedApplication().statusBarFrame.size.height
        let navHeight = self.navigationController?.navigationBar.frame.size.height
        let boxTop = navHeight! + stbHeight
        let boxHeight = self.view.frame.size.height - boxTop - kHeight
        
        self.viewBoxLongDescription.frame = CGRectMake(0, boxTop, self.view.frame.size.width, boxHeight)
        
        UIView.animateWithDuration(0.25, animations: {
            
            self.viewBoxLongDescription.alpha = 1
            
            }, completion: {a in
                
                
        })
        
    }
    
    @IBAction func btnCloseLongDesriptionClick(sender: AnyObject) {
        
        self.view.endEditing(false)
        UIView.animateWithDuration(0.20, animations: {
            
            self.viewBoxLongDescription.alpha = 0
            
            }, completion: {a in
                
                
        })
    }
    
    
    
    func setDiscountType(type:String) {
        // type : cash|percent
        print("setDiscountType = \(type)")
        if(type == "cash") {
            
            self.lblDisCash.textColor = UIColor.blackColor()
            self.lblDisPercent.textColor = UIColor.grayColor()
            self.imgCheckDisCash.image = UIImage(named: "check.png")
            self.imgCheckDisPercent.image = UIImage(named: "uncheck.png")
            
            UIView.animateWithDuration(0.10, animations: {
                self.viewBgDisCash.alpha = 1
                self.viewBgDisPercent.alpha = 0
            })
            
        } else if(type == "percent") {
            
            self.lblDisCash.textColor = UIColor.grayColor()
            self.lblDisPercent.textColor = UIColor.blackColor()
            self.imgCheckDisCash.image = UIImage(named: "uncheck.png")
            self.imgCheckDisPercent.image = UIImage(named: "check.png")
            
            UIView.animateWithDuration(0.10, animations: {
                self.viewBgDisCash.alpha = 0
                self.viewBgDisPercent.alpha = 1
            })
            
        }
    }
    
    @IBAction func btnDisCashClick(sender: AnyObject) {
        setDiscountType("cash")
    }
    
    @IBAction func btnDisPercentClick(sender: AnyObject) {
        setDiscountType("percent")
    }
    
    
    @IBAction func btnSelectDateStartClick(sender: AnyObject) {
        datePickerType = "datestart"
        datePickerTitle = "Coupon date Start"
        openDatePicker()
        UIView.animateWithDuration(0.25, animations: {_ in
            self.scrollView.contentOffset.y = 383
        })
    }
    @IBAction func btnSelectDateEndClick(sender: AnyObject) {
        datePickerType = "dateend"
        datePickerTitle = "Coupon date End"
        openDatePicker()
        UIView.animateWithDuration(0.25, animations: {_ in
            self.scrollView.contentOffset.y = 383
        })
    }
    @IBAction func btnSelectUseStartClick(sender: AnyObject) {
        datePickerType = "usestart"
        datePickerTitle = "Time to use Start"
        openDatePicker()
        UIView.animateWithDuration(0.25, animations: {_ in
            self.scrollView.contentOffset.y = 460
        })
    }
    @IBAction func btnSelectUseEndClick(sender: AnyObject) {
        datePickerType = "useend"
        datePickerTitle = "Time to use End"
        openDatePicker()
        UIView.animateWithDuration(0.25, animations: {_ in
            self.scrollView.contentOffset.y = 460
        })
    }
    
    
    @IBAction func btnSelectStatusPublicClick(sender: AnyObject) {
        
        self.lblStatusPublic.textColor = UIColor.blackColor()
        self.lblStatusUnPublic.textColor = UIColor.grayColor()
        self.imgCheckStatusPublic.image = UIImage(named: "check.png")
        self.imgCheckStatusUnPublic.image = UIImage(named: "uncheck.png")
    }
    
    @IBAction func btnSelectStatusUnPublicClick(sender: AnyObject) {
        
        self.lblStatusPublic.textColor = UIColor.grayColor()
        self.lblStatusUnPublic.textColor = UIColor.blackColor()
        self.imgCheckStatusPublic.image = UIImage(named: "uncheck.png")
        self.imgCheckStatusUnPublic.image = UIImage(named: "check.png")
        
    }
    
    
    // IBAction Section ------------------------------
    
    
    
    // Begin Date Picker  ------------------------------
    let _viewPickerBox = UIView()
    let _pkDate = UIDatePicker()
    let _lblPickerHeader = UILabel()
    let _btnPickerClose = UIButton()
    let pickerHeight:CGFloat = 230 // 250
    
    //    SelectDateStart
    //    SelectDateEnd
    //    SelectUseStart
    //    SelectUseEnd
    
    var datePickerType = ""
    var datePickerTitle = ""
    var pickerTop_Hide = CGFloat()
    var pickerTop_Show = CGFloat()
    
    func initDatePicker() {
        
        pickerTop_Hide = scrollView.frame.size.height
        pickerTop_Show = scrollView.frame.size.height - pickerHeight
        
        _viewPickerBox.frame = CGRectMake(0, pickerTop_Hide, self.view.frame.size.width, pickerHeight)
        //_viewPickerBox.backgroundColor = UIColor.redColor()
        _viewPickerBox.clipsToBounds = true
        self.view.addSubview(_viewPickerBox)
        
        
        
        let pickerHeaderHeight:CGFloat = 30
        let btnClosePickerWidth:CGFloat = 60
        let lblPickerTitleWidth:CGFloat = _viewPickerBox.frame.size.width // - btnClosePickerWidth
        
        let _viewPickerHeader = UIView()
        _viewPickerHeader.frame = CGRectMake(0, 0, lblPickerTitleWidth, pickerHeaderHeight)
        _viewPickerHeader.backgroundColor = UIColor.grayColor()
        _viewPickerBox.addSubview(_viewPickerHeader)
        
        _lblPickerHeader.frame = CGRectMake(6, 0, lblPickerTitleWidth - 6, pickerHeaderHeight)
        _lblPickerHeader.backgroundColor = UIColor.clearColor()
        _lblPickerHeader.text = datePickerTitle
        _viewPickerBox.addSubview(_lblPickerHeader)
        
        
        _btnPickerClose.frame = CGRectMake(_viewPickerBox.frame.size.width - btnClosePickerWidth, 0, btnClosePickerWidth, pickerHeaderHeight)
        //_btnPickerClose.backgroundColor = UIColor.greenColor()
        _btnPickerClose.setTitle("Finish", forState: .Normal)
        _btnPickerClose.titleLabel?.font = UIFont.systemFontOfSize(15)
        _btnPickerClose.addTarget(self, action: #selector(self.closeDatePicker), forControlEvents: .TouchUpInside)
        _viewPickerBox.addSubview(_btnPickerClose)
        
        
        _pkDate.frame = CGRectMake(0, pickerHeaderHeight, _viewPickerBox.frame.size.width, pickerHeight-pickerHeaderHeight)
        _pkDate.backgroundColor = UIColor.greenColor()
        _pkDate.addTarget(self, action: #selector(self.datePickerChanged), forControlEvents: .ValueChanged)
        _pkDate.datePickerMode = UIDatePickerMode.Date
        _pkDate.locale = NSLocale(localeIdentifier: "TH")
        
        _viewPickerBox.addSubview(_pkDate)
        
    }
    let strDateFormat = "dd/MM/yyyy"
    func datePickerChanged(datePicker:UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        print("checkinPickerChanged")
        dateFormatter.dateStyle = NSDateFormatterStyle.NoStyle
        //dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        dateFormatter.dateFormat = strDateFormat
        let strDate = dateFormatter.stringFromDate(datePicker.date)
        
        switch datePickerType {
        case "datestart":
            txtDateStart.text = strDate
            break
        case "dateend":
            txtDateEnd.text = strDate
            break
        case "usestart":
            txtUseStart.text = strDate
            break
        case "useend":
            txtUseEnd.text = strDate
            break
        default:
            //
            break
        }
//        datestart
//        dateend
//        usestart
//        useend

        // checkinPicker.hidden = true
        
    }
    
    func openDatePicker() {
        lastScrollY = self.scrollView.contentOffset.y
        _lblPickerHeader.text = datePickerTitle
        
        var currentDate = NSDate()
        switch datePickerType {
        case "datestart":
            currentDate = txtDateStart.text != "" ? (txtDateStart.text?.toDateFormattedWith(strDateFormat))! : currentDate
            break
        case "dateend":
            currentDate = txtDateEnd.text != "" ? (txtDateEnd.text?.toDateFormattedWith(strDateFormat))! : currentDate
            break
        case "usestart":
            currentDate = txtUseStart.text != "" ? (txtUseStart.text?.toDateFormattedWith(strDateFormat))! : currentDate
            break
        case "useend":
            currentDate = txtUseEnd.text != "" ? (txtUseEnd.text?.toDateFormattedWith(strDateFormat))! : currentDate
            break
        default:
            //
            break
        }
        
        _pkDate.setDate(currentDate, animated: false)
        
        if(self._viewPickerBox.frame.origin.y == pickerTop_Hide){
            UIView.animateWithDuration(0.25, animations: {
                self._viewPickerBox.frame.origin.y = self.pickerTop_Show
            })
        }
    }
    
    func closeDatePicker() {
        
        if(self._viewPickerBox.frame.origin.y == pickerTop_Show){
            scrollToLastScroll()
            UIView.animateWithDuration(0.25, animations: {
                self._viewPickerBox.frame.origin.y = self.pickerTop_Hide
            })
        }
        
    }
    
    
    
    // End Date Picker  ------------------------------
    
    
    
    
    var lastScrollY:CGFloat = 0
    var kHeight = CGFloat()
    func keyboardWillShow(notification: NSNotification) {
        
        //lastScrollY = self.scrollView.contentOffset.y
        
        closeDatePicker()
        
        print("notification \(lastScrollY)")
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            //let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
            kHeight = keyboardSize.height
        }else{
            kHeight = 0
        }
        //self.txtLongDes
        
        UIView.animateWithDuration(0.25, animations: {_ in
            
        })
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        
        print("keyboardWillHide = \(self.lastScrollY)")
        
        scrollToLastScroll()
        
        btnCloseLongDesriptionClick(UIButton())
        
        UIView.animateWithDuration(0.25, animations: {_ in
            
            //self.scrollView.contentOffset.y = self.lastScrollY
        })
        
    }
    
    func keyboardDidHide(notification: NSNotification) {
        
        print("keyboardDidHide = \(self.lastScrollY)")
        
        scrollToLastScroll()
        
    }
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true;
    }
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        lastScrollY = self.scrollView.contentOffset.y

        
        if textField == txtCouponName {
            UIView.animateWithDuration(0.25, animations: {_ in
                self.scrollView.contentOffset.y = 106
            })
        }else if textField == txtCouponCount || textField == txtValidate {
            UIView.animateWithDuration(0.25, animations: {_ in
                self.scrollView.contentOffset.y = 543
            })
        }else if textField == txtPrefixCode {
            UIView.animateWithDuration(0.25, animations: {_ in
                self.scrollView.contentOffset.y = 616
            })
        }else if textField == txtPrice || textField == txtDisCash || textField == txtDisPercent {
            UIView.animateWithDuration(0.25, animations: {_ in
                self.scrollView.contentOffset.y = 701
            })
        }else if textField == txtContactPhone {
            UIView.animateWithDuration(0.25, animations: {_ in
                self.scrollView.contentOffset.y = 1067
            })
        }else if textField == txtContactEmail {
            UIView.animateWithDuration(0.25, animations: {_ in
                self.scrollView.contentOffset.y = 1142
            })
        }
        
        return true
    }
    
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        //scrollToLastScroll()
        
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        
        //scrollToLastScroll()
        
        return true
    }
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        lastScrollY = self.scrollView.contentOffset.y

        if textView == txtShortDes {
            UIView.animateWithDuration(0.25, animations: {_ in
                self.scrollView.contentOffset.y = 190
            })
        }else if textView == txtCondition {
            UIView.animateWithDuration(0.25, animations: {_ in
                self.scrollView.contentOffset.y = 903
            })
        }
        return true
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        
        //scrollToLastScroll()
        
    }
    
    func textViewShouldEndEditing(textView: UITextView) -> Bool {
        
        //scrollToLastScroll()
        return true
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
    }
    
    func scrollToLastScroll() {
        
        UIView.animateWithDuration(0.25, animations: {_ in
            
            self.scrollView.contentOffset.y = self.lastScrollY
        })
        
    }
    
    // -----------------------------------------------
    
    override func viewWillAppear(animated: Bool) {
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
      //  let width = UIScreen.mainScreen().bounds.size.width
        let contentscrollheight:CGFloat = 1350 // self.scrollView.layer.bounds.size.height
        scrollView.contentSize = CGSizeMake(width,contentscrollheight);
        self.appDelegate.viewWithTopButtons.hidden = true
//        self.getFacility()
//
//        self.setFacility(7270)
//        self.updateData()
    }
    
    enum providerType {
        case hotel
        case restaurant
        case attraction
    }
    func setProName(proName:String, proType:providerType) {
        
        imgIconProName.contentMode = .ScaleAspectFit
        imgIconProName.backgroundColor = UIColor.clearColor()
        switch proType {
        case .hotel:
            imgIconProName.image = UIImage(named: "ic_hotel_hover.png")
            break
        case .restaurant:
            imgIconProName.image = UIImage(named: "ic_restaurant_hover.png")
            break
        case .attraction:
            imgIconProName.image = UIImage(named: "ic_attraction_hover.png")
            break
        }
        
        self.lblProName.text = proName
        lblProName.sizeToFit()
        
        let boxWidth = lblProName.frame.size.width + imgIconProName.frame.size.width + 5
        viewProviderName.frame.size.width = boxWidth
        viewProviderName.frame.origin.x = (self.view.frame.size.width / 2) - (boxWidth / 2)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setProName("สวัสดีครับ กดเกสทวาทวsdfsdfsfท", proType: .hotel)
        
        width = UIScreen.mainScreen().bounds.size.width
        heigth = UIScreen.mainScreen().bounds.size.height
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(HotelCreateCouponVC.dismissKeyboard))
        tap.delegate = self
        tap.cancelsTouchesInView = true
        self.view!.addGestureRecognizer(tap)
        
        self.initNavUnderline()
        self.initialObject()
        self.initDatePicker()
        
        // Do any additional setup after loading the view.
        
        self.viewBoxLongDescription.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
        self.viewBoxLongDescription.alpha = 0
        self.viewEmptyLogo.userInteractionEnabled = false
        
        
        myPicker.delegate = self
        
        
        txtCouponName.delegate = self
        txtShortDes.delegate = self
        
        txtDateStart.delegate = self
        txtDateEnd.delegate = self
        
        txtUseStart.delegate = self
        txtUseEnd.delegate = self
        
        txtCouponCount.delegate = self
        txtValidate.delegate = self
        txtPrefixCode.delegate = self
        
        txtLongDes.delegate = self
        
        txtPrice.delegate = self
        txtDisCash.delegate = self
        txtDisPercent.delegate = self
        
        txtCondition.delegate = self
        txtContactPhone.delegate = self
        txtContactEmail.delegate = self
        
        
        self.imgLogo.contentMode = .ScaleAspectFill
        let tapAddLogo = UITapGestureRecognizer(target:self, action:#selector(HotelCreateCouponVC.imageTapped(_:)))
        imgLogo.userInteractionEnabled = true
        imgLogo.addGestureRecognizer(tapAddLogo)
        
        let tapBgLongDes = UITapGestureRecognizer(target:self, action:#selector(HotelCreateCouponVC.btnOpenLongDesriptionClick(_:)))
        tapBgLongDes.cancelsTouchesInView = false
        viewBoxLongDescription.userInteractionEnabled = true
        viewBoxLongDescription.addGestureRecognizer(tapBgLongDes)
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyboardDidHide(_:)), name: UIKeyboardDidHideNotification, object: nil)
        
    }
    
    func initialObject(){
        
        setDiscountType("cash")
        
//        roomNameTxt.borderStyle = UITextBorderStyle.RoundedRect
//        roomNameTxt.layer.cornerRadius = 5
//        roomNameTxt.layer.borderWidth = 1
//        roomNameTxt.layer.borderColor = UIColor(red: 0.13, green: 0.14, blue: 0.18, alpha: 0.09).CGColor
//        
//        
//       // shotDescTxt.borderStyle = UITextBorderStyle.RoundedRect
//        shotDescTxt.layer.cornerRadius = 5
//        shotDescTxt.layer.borderWidth = 1
//        shotDescTxt.layer.borderColor = UIColor(red: 0.13, green: 0.14, blue: 0.18, alpha: 0.2).CGColor
//        
//        priceTxt.borderStyle = UITextBorderStyle.RoundedRect
//        priceTxt.layer.cornerRadius = 5
//        priceTxt.layer.borderWidth = 1
//        priceTxt.layer.borderColor = UIColor(red: 0.13, green: 0.14, blue: 0.18, alpha: 0.09).CGColor
//        
//        numOfRoomTxt.borderStyle = UITextBorderStyle.RoundedRect
//        numOfRoomTxt.layer.cornerRadius = 5
//        numOfRoomTxt.layer.borderWidth = 1
//        numOfRoomTxt.layer.borderColor = UIColor(red: 0.13, green: 0.14, blue: 0.18, alpha: 0.09).CGColor
//        
//        bedTxt.borderStyle = UITextBorderStyle.RoundedRect
//        bedTxt.layer.cornerRadius = 5
//        bedTxt.layer.borderWidth = 1
//        bedTxt.layer.borderColor = UIColor(red: 0.13, green: 0.14, blue: 0.18, alpha: 0.09).CGColor
//        
//        maxOccupTxt.borderStyle = UITextBorderStyle.RoundedRect
//        maxOccupTxt.layer.cornerRadius = 5
//        maxOccupTxt.layer.borderWidth = 1
//        maxOccupTxt.layer.borderColor = UIColor(red: 0.13, green: 0.14, blue: 0.18, alpha: 0.09).CGColor
//        addButton.layer.cornerRadius = 5
//        facilityView.layer.cornerRadius = 5
        
    }
    
    func initNavUnderline(){
        navunderlive.frame = CGRectMake(self.view.frame.size.width/3, (self.navigationController?.navigationBar.frame.size.height)! - 3, self.view.frame.size.width/3, 3)
        navunderlive.backgroundColor = UIColor.redColor()
        self.navigationController?.navigationBar.addSubview(navunderlive)
    }
    override func viewDidDisappear(animated: Bool) {
       
    }

    func customIOS7AlertViewButtonTouchUpInside(alertView: CustomIOS7AlertView, buttonIndex: Int) {
        alertView.close()
        print("customIOS7AlertViewButtonTouchUpInside")
        
       
    }
    func closealert(sender: UIButton, alertView: CustomIOS7AlertView) {
        alertView.close()
    }
    // Create a custom container view
    func createContainerView() -> UIView {
        width = UIScreen.mainScreen().bounds.size.width
        heigth = UIScreen.mainScreen().bounds.size.height
        let containerView = UIView(frame: CGRectMake(0, 0, 300 , heigth - 100))
        let subView1: UIView = NSBundle.mainBundle().loadNibNamed("roomfacility", owner: self, options: nil)[0] as! UIView
        subView1.frame = containerView.bounds

        containerView.addSubview(subView1)
        
        return containerView
    }

    @IBAction func btnBack(sender: AnyObject) {
        
        
        self.appDelegate.menuFocusIndexOnBack = 2
        self.navigationController?.popViewControllerAnimated(true)
//        appDelegate.pagecontrolIndex = 2
        
//
//       print("Back")
//        let nev = self.storyboard?.instantiateViewControllerWithIdentifier("navCon")
//        self.navigationController?.presentViewController(nev!, animated: true, completion: { () -> Void in
//            self.appDelegate.viewWithTopButtons.hidden = false
//            self.navunderlive.hidden = true
//            
//        })
        
    }
 
    func dismissKeyboard(){
        closeDatePicker()
        self.view.endEditing(true)
    }
    

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
    
    
    
    // MARK: UICollectionViewDataSource
    
//    func numberOfSectionsInCollectionView(collectionView: UICollectionView)->Int {
//        //#warning Incomplete method implementation -- Return the number of sections
//        return 1
//    }
//    
    
    
    let myPicker = UIImagePickerController()
    func imageTapped(sender: AnyObject){
        myPicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        myPicker.allowsEditing = false
        self.presentViewController(myPicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        print("ImagePicker")
        var chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        chosenImage = FileMan().resizeImage(chosenImage, maxSize: 1500)
        self.imgLogo.image = chosenImage
        
        self.viewEmptyLogo.alpha = 0
        
        dismissViewControllerAnimated(true, completion: nil)
     
    }
    //gestureRecognizer

    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
//        if(self.view.isDescendantOfView(self.collectionView))
//        {
//            print("if gestureRecognizer")
//            return false
//        }
//        else
//        {
//            print("else gestureRecognizer")
//            return true
//        }
        return true
    }

}
