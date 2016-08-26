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
    
    var dicProvider = NSDictionary()
    @IBOutlet weak var btnSaveData: UIButton!
    @IBAction func btnSaveDataClick(sender: AnyObject) {
        
        print("btnSaveDataClick")
        let alertView = SCLAlertView()
        alertView.showCircularIcon = false
        alertView.showCloseButton = false
        
        let msgAlertTitle = "Information"
        var msgAlertDetail = "Please input data!"
        
        
        //let objProvider = [String : AnyObject]()
        //let objProvider = appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!] // [NSObject:AnyObject]
//        
//        guard let objProvider = appDelegate.providerData!["ListProviderInformationSummary"]! as! NSArray else {
//            return
//        }
//        guard let objProvider = appDelegate.providerData! as! Dictionary else {
//            
//            return
//        }
        
        
//        print("objProviderDic")
//        print(objProviderDic)
//        print("-----------------------------------------")
//        print("UserData")
//        print(appDelegate.userInfo)
//        print("-----------------------------------------")
        
        if imgLogo.image == nil {
            msgAlertDetail = "Please Choose Coupon Image!"
            alertView.addButton("OK", action: {_ in
                UIView.animateWithDuration(0.25, animations: {_ in self.scrollView.contentOffset.y = -64 })
            })
            alertView.showInfo(msgAlertTitle, subTitle: msgAlertDetail, colorStyle:0xAC332F, duration: 5.0)
        }else if txtCouponName.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()) == "" {
            msgAlertDetail = "Please enter Coupon Name"
            alertView.addButton("OK", action: {_ in
                self.txtCouponName.becomeFirstResponder()
                //UIView.animateWithDuration(0.25, animations: {_ in self.scrollView.contentOffset.y = 106 }, completion:{ _ in self.txtCouponName.becomeFirstResponder()})
            })
            alertView.showInfo(msgAlertTitle, subTitle: msgAlertDetail, colorStyle:0xAC332F, duration: 5.0)
        }else if txtShortDes.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()) == "" {
            msgAlertDetail = "Please enter Short Description"
            alertView.addButton("OK", action: {_ in
                self.txtShortDes.becomeFirstResponder()
                //UIView.animateWithDuration(0.25, animations: {_ in self.scrollView.contentOffset.y = 190 }, completion:{ _ in self.txtShortDes.becomeFirstResponder()})
            })
            alertView.showInfo(msgAlertTitle, subTitle: msgAlertDetail, colorStyle:0xAC332F, duration: 5.0)
        }else if txtLongDes.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()) == "" {
            msgAlertDetail = "Please enter Long Description"
            alertView.addButton("OK", action: {_ in
                //self.txtLongDes.becomeFirstResponder()
                self.btnOpenLongDesriptionClick(UIButton())
                //UIView.animateWithDuration(0.25, animations: {_ in self.scrollView.contentOffset.y = 190 }, completion:{ _ in self.txtShortDes.becomeFirstResponder()})
            })
            alertView.showInfo(msgAlertTitle, subTitle: msgAlertDetail, colorStyle:0xAC332F, duration: 5.0)
        }else if txtDateStart.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()) == "" {
            msgAlertDetail = "Please Choose Date Start"
            alertView.addButton("OK", action: {_ in
                self.btnSelectDateStartClick(UIButton())
                //UIView.animateWithDuration(0.25, animations: {_ in self.scrollView.contentOffset.y = 383 }, completion:{ _ in self.btnSelectDateStartClick(UIButton())})
            })
            alertView.showInfo(msgAlertTitle, subTitle: msgAlertDetail, colorStyle:0xAC332F, duration: 5.0)
        }else if txtDateEnd.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()) == "" {
            msgAlertDetail = "Please Choose Date End"
            alertView.addButton("OK", action: {_ in
                self.btnSelectDateEndClick(UIButton())
                //UIView.animateWithDuration(0.25, animations: {_ in self.scrollView.contentOffset.y = 383 }, completion:{ _ in self.btnSelectDateEndClick(UIButton())})
            })
            alertView.showInfo(msgAlertTitle, subTitle: msgAlertDetail, colorStyle:0xAC332F, duration: 5.0)
        }else if (txtDateStart.text?.toDateFormattedWith(strDateFormat))!.compare((txtDateEnd.text?.toDateFormattedWith(strDateFormat))!) == .OrderedDescending { // asasdasdasd
            msgAlertDetail = "Start Date must be\ngreater than the end date"
            alertView.addButton("OK", action: {_ in
                self.btnSelectDateEndClick(UIButton())
            })
            alertView.showInfo(msgAlertTitle, subTitle: msgAlertDetail, colorStyle:0xAC332F, duration: 5.0)
        }else if txtUseStart.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()) == "" {
            msgAlertDetail = "Please Choose\nTime to use Start"
            alertView.addButton("OK", action: {_ in
                self.btnSelectUseStartClick(UIButton())
                //UIView.animateWithDuration(0.25, animations: {_ in self.scrollView.contentOffset.y = 460 }, completion:{ _ in self.btnSelectUseStartClick(UIButton())})
            })
            alertView.showInfo(msgAlertTitle, subTitle: msgAlertDetail, colorStyle:0xAC332F, duration: 5.0)
        }else if txtUseEnd.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()) == "" {
            msgAlertDetail = "Please Choose\nTime to use End"
            alertView.addButton("OK", action: {_ in
                self.btnSelectUseEndClick(UIButton())
                //UIView.animateWithDuration(0.25, animations: {_ in self.scrollView.contentOffset.y = 460 }, completion:{ _ in self.btnSelectUseEndClick(UIButton())})
            })
            alertView.showInfo(msgAlertTitle, subTitle: msgAlertDetail, colorStyle:0xAC332F, duration: 5.0)
        }else if (txtUseStart.text?.toDateFormattedWith(strDateFormat))!.compare((txtUseEnd.text?.toDateFormattedWith(strDateFormat))!) == .OrderedDescending { // asasdasdasd
            msgAlertDetail = "Start Date must be\ngreater than the end date"
            alertView.addButton("OK", action: {_ in
                self.btnSelectUseEndClick(UIButton())
            })
            alertView.showInfo(msgAlertTitle, subTitle: msgAlertDetail, colorStyle:0xAC332F, duration: 5.0)
        }else if txtCouponCount.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()) == "" {
            msgAlertDetail = "Please enter number of Coupon"
            alertView.addButton("OK", action: {_ in
                self.txtCouponCount.becomeFirstResponder()
                //UIView.animateWithDuration(0.25, animations: {_ in self.scrollView.contentOffset.y = 543 }, completion:{ _ in self.txtCouponCount.becomeFirstResponder()})
            })
            alertView.showInfo(msgAlertTitle, subTitle: msgAlertDetail, colorStyle:0xAC332F, duration: 5.0)
        }else if txtPrice.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()) == "" {
            msgAlertDetail = "Please enter Price"
            alertView.addButton("OK", action: {_ in
                self.txtPrice.becomeFirstResponder()
                //UIView.animateWithDuration(0.25, animations: {_ in self.scrollView.contentOffset.y = 701 }, completion:{ _ in self.txtPrice.becomeFirstResponder()})
            })
            alertView.showInfo(msgAlertTitle, subTitle: msgAlertDetail, colorStyle:0xAC332F, duration: 5.0)
        }else if txtCondition.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()) == "" {
            msgAlertDetail = "Please enter Condition"
            alertView.addButton("OK", action: {_ in
                self.txtCondition.becomeFirstResponder()
                //UIView.animateWithDuration(0.25, animations: {_ in self.scrollView.contentOffset.y = 903 }, completion:{ _ in self.txtCondition.becomeFirstResponder()})
            })
            alertView.showInfo(msgAlertTitle, subTitle: msgAlertDetail, colorStyle:0xAC332F, duration: 5.0)
        }else if txtContactPhone.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()) == "" {
            msgAlertDetail = "Please enter Contact Phone"
            alertView.addButton("OK", action: {_ in
                self.txtContactPhone.becomeFirstResponder()
                //UIView.animateWithDuration(0.25, animations: {_ in self.scrollView.contentOffset.y = 1067 }, completion:{ _ in self.txtContactPhone.becomeFirstResponder()})
            })
            alertView.showInfo(msgAlertTitle, subTitle: msgAlertDetail, colorStyle:0xAC332F, duration: 5.0)
        }else if txtContactEmail.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()) == "" {
            msgAlertDetail = "Please enter Contact Email"
            alertView.addButton("OK", action: {_ in
                self.txtContactEmail.becomeFirstResponder()
                //UIView.animateWithDuration(0.25, animations: {_ in self.scrollView.contentOffset.y = 1142 }, completion:{ _ in self.txtContactEmail.becomeFirstResponder()})
            })
            alertView.showInfo(msgAlertTitle, subTitle: msgAlertDetail, colorStyle:0xAC332F, duration: 5.0)
        }else{
            
            let sendData = [
                "providerId": dicProvider["provider_id"]!,
                "coupongroupNameEn": txtCouponName.text!,
                "coupongroupNameTh": txtCouponName.text!,
                "descriptionEn": txtLongDes.text!,
                "descriptionTh": txtLongDes.text!,
                "shortDescriptionEn": txtShortDes.text!,
                "shortDescriptionTh": txtShortDes.text!,
                "conditionEn": txtCondition.text!,
                "conditionTh": txtCondition.text!,
                "coupongroupValue": couponDiscountType == "cash" ? txtDisCash.text! : txtDisPercent.text!,
                "coupongroupType": String(couponDiscountType),
                //"limitUseTime": "", // optional
                "startDate": (txtDateStart.text! == "") ? strCurDate : txtDateStart.text!, // 2016-02-16
                "endDate": (txtDateEnd.text! == "") ? strCurDate :  txtDateEnd.text!, // 2016-02-16
                "startPromotionDate": (txtUseStart.text! == "") ? strCurDate : txtUseStart.text!, // 2016-02-16
                "endPromotionDate": (txtUseEnd.text! == "") ? strCurDate : txtUseEnd.text!, // 2016-02-16
                "coupongroupLimit": txtCouponCount.text!,
                "coupongroupPrefix": txtPrefixCode.text!,// optional
                "email": txtContactEmail.text!,// optional
                "contactPhone": txtContactPhone.text!,// optional
                "status": StatusPublic,// optional
                "userId": appDelegate.userInfo["userID"]!
            ]
            
            print("------------   sendData   -----------")
            print(sendData)
            print("-----------------------------------------")
            

            send.createCoupon(sendData, completionHandler:{data in
                if let objData:NSDictionary = data {
                    
                    print("completionHandler")
                    print("success = \(objData["success"])")
                    print("message = \(objData["message"])")
                    print("-----------------")
                    
                    guard let _success = objData["success"] as! Bool?,let _message = objData["message"] as! String? where _success == true else {
                        // Value requirements not met, do something
                        
                        print("_success is failed")
                        print("-----------------")
                        
                        msgAlertDetail = "Please enter Short Description"
                        alertView.addButton("OK", action: {_ in
                            //self.txtShortDes.becomeFirstResponder()
                            self.btnBack(UIButton())
                            //UIView.animateWithDuration(0.25, animations: {_ in self.scrollView.contentOffset.y = 190 }, completion:{ _ in self.txtShortDes.becomeFirstResponder()})
                        })
                        alertView.showInfo(msgAlertTitle, subTitle: String(objData["message"]!), colorStyle:0xAC332F, duration: 5.0)
                        return
                    }
                    
                    let tmDelayToClose:NSTimeInterval = 5.0
                    msgAlertDetail = "Please enter Short Description"
                    alertView.addButton("OK", action: {_ in
                        self.btnBack(UIButton())
                    })
                    alertView.showInfo(msgAlertTitle, subTitle: _message, colorStyle:0xAC332F, duration: tmDelayToClose)
                    NSTimer.scheduledTimerWithTimeInterval(tmDelayToClose , target: self, selector: #selector(self.btnBack(_:)), userInfo: nil, repeats: false)
                    
                    
                    print("_success is OK")
                    print("success = \(objData["success"])")
                    print("message = \(objData["message"])")
                    print("-----------------")
                    
                    
                }
            })
            
        }
        
    }
    
    
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
    
    
    var canFocus_DisCash = false
    var couponDiscountType = ""
    func setDiscountType(type:String) {
        // type : cash|percent
        print("setDiscountType = \(type)")
        couponDiscountType = type
        if(type == "cash") {
            
            self.lblDisCash.textColor = UIColor.blackColor()
            self.lblDisPercent.textColor = UIColor.grayColor()
            self.imgCheckDisCash.image = UIImage(named: "check.png")
            self.imgCheckDisPercent.image = UIImage(named: "uncheck.png")
            
            if self.canFocus_DisCash {
                self.txtDisCash.becomeFirstResponder()
            }else{
                self.canFocus_DisCash = true
            }
            
            UIView.animateWithDuration(0.10, animations: {
                self.viewBgDisCash.alpha = 1
                self.viewBgDisPercent.alpha = 0
                },completion: {_ in
                    
            })
            
        } else if(type == "percent") {
            
            self.lblDisCash.textColor = UIColor.grayColor()
            self.lblDisPercent.textColor = UIColor.blackColor()
            self.imgCheckDisCash.image = UIImage(named: "uncheck.png")
            self.imgCheckDisPercent.image = UIImage(named: "check.png")
            
            self.txtDisPercent.becomeFirstResponder()
            
            UIView.animateWithDuration(0.10, animations: {
                self.viewBgDisCash.alpha = 0
                self.viewBgDisPercent.alpha = 1
                },completion: {_ in
                    
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
            self.scrollView.contentOffset.y = 383//460
        })
    }
    @IBAction func btnSelectUseEndClick(sender: AnyObject) {
        datePickerType = "useend"
        datePickerTitle = "Time to use End"
        openDatePicker()
        UIView.animateWithDuration(0.25, animations: {_ in
            self.scrollView.contentOffset.y = 383//460
        })
    }
    
    var StatusPublic = "0"
    @IBAction func btnSelectStatusPublicClick(sender: AnyObject) {
        StatusPublic = "1"
        self.lblStatusPublic.textColor = UIColor.blackColor()
        self.lblStatusUnPublic.textColor = UIColor.grayColor()
        self.imgCheckStatusPublic.image = UIImage(named: "check.png")
        self.imgCheckStatusUnPublic.image = UIImage(named: "uncheck.png")
    }
    
    @IBAction func btnSelectStatusUnPublicClick(sender: AnyObject) {
        StatusPublic = "0"
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
        let btnSaveH = btnSaveData.frame.size.height
        pickerTop_Hide = scrollView.frame.size.height + btnSaveH
        pickerTop_Show = scrollView.frame.size.height + btnSaveH - pickerHeight
        
        _viewPickerBox.frame = CGRectMake(0, pickerTop_Hide, self.view.frame.size.width, pickerHeight)
        //_viewPickerBox.backgroundColor = UIColor.redColor()
        _viewPickerBox.clipsToBounds = true
        self.view.addSubview(_viewPickerBox)
        
        
        
        let pickerHeaderHeight:CGFloat = 30
        let btnClosePickerWidth:CGFloat = 60
        let lblPickerTitleWidth:CGFloat = _viewPickerBox.frame.size.width // - btnClosePickerWidth
        
        let _viewPickerHeader = UIView()
        _viewPickerHeader.frame = CGRectMake(0, 0, lblPickerTitleWidth, pickerHeaderHeight)
        _viewPickerHeader.backgroundColor = UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1.0)
        _viewPickerBox.addSubview(_viewPickerHeader)
        
        _lblPickerHeader.frame = CGRectMake(6, 0, lblPickerTitleWidth - 6, pickerHeaderHeight)
        _lblPickerHeader.backgroundColor = UIColor.clearColor()
        _lblPickerHeader.text = datePickerTitle
        _viewPickerBox.addSubview(_lblPickerHeader)
        
        
        _btnPickerClose.frame = CGRectMake(_viewPickerBox.frame.size.width - btnClosePickerWidth, 0, btnClosePickerWidth, pickerHeaderHeight)
        //_btnPickerClose.backgroundColor = UIColor.greenColor()
        _btnPickerClose.setTitle("Finish", forState: .Normal)
        _btnPickerClose.tintColor = UIColor(red: 84/255, green: 84/255, blue: 84/255, alpha: 1.0)
        _btnPickerClose.titleLabel?.font = UIFont.systemFontOfSize(15)
        _btnPickerClose.addTarget(self, action: #selector(self.closeDatePicker), forControlEvents: .TouchUpInside)
        _viewPickerBox.addSubview(_btnPickerClose)
        
        
        _pkDate.frame = CGRectMake(0, pickerHeaderHeight, _viewPickerBox.frame.size.width, pickerHeight-pickerHeaderHeight)
        _pkDate.backgroundColor = UIColor.whiteColor()
        _pkDate.addTarget(self, action: #selector(self.datePickerChanged), forControlEvents: .ValueChanged)
        _pkDate.datePickerMode = UIDatePickerMode.Date
        _pkDate.locale = NSLocale(localeIdentifier: "TH")
        
        _viewPickerBox.addSubview(_pkDate)
        
    }
    let strDateFormat = "yyyy/MM/dd" // "dd/MM/yyyy"
    var strCurDate = ""
    func datePickerChanged(datePicker:UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        print("checkinPickerChanged")
        dateFormatter.dateStyle = NSDateFormatterStyle.NoStyle
        //dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        dateFormatter.dateFormat = strDateFormat
        strCurDate = dateFormatter.stringFromDate(datePicker.date)
        
        switch datePickerType {
        case "datestart":
            txtDateStart.text = strCurDate
            break
        case "dateend":
            txtDateEnd.text = strCurDate
            break
        case "usestart":
            txtUseStart.text = strCurDate
            break
        case "useend":
            txtUseEnd.text = strCurDate
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
    
    func dateToString(date:NSDate) -> String {
        
//        let dateString = "Thu, 22 Oct 2015 07:45:17 +0000"
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = strDateFormat
        dateFormatter.dateStyle = NSDateFormatterStyle.NoStyle
//        let dateObj = dateFormatter.dateFromString(dateString)
        
        dateFormatter.dateFormat = strDateFormat
        //print("Dateobj: \(dateFormatter.stringFromDate(date))")
        
        return dateFormatter.stringFromDate(date)
    }
    
    func openDatePicker() {
        lastScrollY = self.scrollView.contentOffset.y
        _lblPickerHeader.text = datePickerTitle
        dismissKeyboard()
        var currentDate = NSDate()
        
        
        switch datePickerType {
        case "datestart":
            //currentDate = txtDateStart.text != "" ? (txtDateStart.text?.toDateFormattedWith(strDateFormat))! : currentDate
            if txtDateStart.text != "" {
                currentDate = (txtDateStart.text?.toDateFormattedWith(strDateFormat))!
            }else{
                txtDateStart.text = dateToString(currentDate)
            }
            break
        case "dateend":
            //currentDate = txtDateEnd.text != "" ? (txtDateEnd.text?.toDateFormattedWith(strDateFormat))! : currentDate
            if txtDateEnd.text != "" {
                currentDate = (txtDateEnd.text?.toDateFormattedWith(strDateFormat))!
            }else{
                txtDateEnd.text = dateToString(currentDate)
            }
            break
        case "usestart":
            //currentDate = txtUseStart.text != "" ? (txtUseStart.text?.toDateFormattedWith(strDateFormat))! : currentDate
            if txtUseStart.text != "" {
                currentDate = (txtUseStart.text?.toDateFormattedWith(strDateFormat))!
            }else{
                txtUseStart.text = dateToString(currentDate)
            }
            break
        case "useend":
            //currentDate = txtUseEnd.text != "" ? (txtUseEnd.text?.toDateFormattedWith(strDateFormat))! : currentDate
            if txtUseEnd.text != "" {
                currentDate = (txtUseEnd.text?.toDateFormattedWith(strDateFormat))!
            }else{
                txtUseEnd.text = dateToString(currentDate)
            }
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
    var kbIsShow = false
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
        
        //scrollToLastScroll()
        
        btnCloseLongDesriptionClick(UIButton())
        
        UIView.animateWithDuration(0.25, animations: {_ in
            
            //self.scrollView.contentOffset.y = self.lastScrollY
        })
        
    }
    
    func keyboardDidHide(notification: NSNotification) {
        kbIsShow = false
        print("keyboardDidHide = \(self.lastScrollY)")
        
        scrollToLastScroll()
        
    }
    
    func keyboardDidShow(notification: NSNotification) {
        kbIsShow = true
        print("keyboardDidShow = \(self.lastScrollY)")
        
        
    }
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        print("textFieldShouldReturn")
        //self.dismissKeyboard()
        textField.isFirstResponder()
        return true;
    }
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        print("textFieldShouldBeginEditing")
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
            let scY = scrollView.frame.size.height - 1142 + kHeight
            print("scY = \(scY)")
            UIView.animateWithDuration(0.25, animations: {_ in
                self.scrollView.contentOffset.y = 1142 // scY // 1142
            })
        }
        
        return true
    }
    
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        print("textFieldDidEndEditing")
        //scrollToLastScroll()
        
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        
        print("textFieldShouldEndEditing")
        //scrollToLastScroll()
        
        return true
    }
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        print("textViewShouldBeginEditing")
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
        
        print("textViewDidEndEditing")
        scrollToLastScroll()
        
    }
    
    func textViewShouldEndEditing(textView: UITextView) -> Bool {
        
        print("textViewShouldEndEditing")
        scrollToLastScroll()
        return true
    }
    
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        //dismissKeyboard()
        //print("scrollViewDidScroll \(scrollView.contentOffset.y)")
    }
    
    func scrollToLastScroll() {
        
        if self.scrollView.contentOffset.y != self.lastScrollY {
            
            UIView.animateWithDuration(0.25, animations: {_ in
                self.scrollView.contentOffset.y = self.lastScrollY > 830 ? 830 : self.lastScrollY
            })
            
        }
        
    }
    
    // -----------------------------------------------
    
    let contentscrollheight:CGFloat = 1350 // self.scrollView.layer.bounds.size.height
    override func viewWillAppear(animated: Bool) {
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
      //  let width = UIScreen.mainScreen().bounds.size.width
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
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyboardDidShow(_:)), name: UIKeyboardDidShowNotification, object: nil)
        
    }
    
    func initialObject(){
        
        
        guard let objProvider = appDelegate.providerData!["ListProviderInformationSummary"]! as? NSArray else {
            print("no objProvider")
            return
        }
        
        guard let objProviderDic = objProvider[appDelegate.providerIndex!] as? NSDictionary else {
            print("no objProviderDic")
            return
        }
        
        dicProvider = objProviderDic
        
        
        print("dicProvider")
        print("dicProvider")
        print("dicProvider")
        print(dicProvider)
        print("-----------------------------------------")
        print("-----------------------------------------")
        print("-----------------------------------------")
        
        var provider_type_keyname = providerType.hotel
        switch String(dicProvider["provider_type_keyname"]!) {
        case "hotel":
            provider_type_keyname = providerType.hotel
            break
        case "attraction":
            provider_type_keyname = providerType.attraction
            break
        case "restaurant":
            provider_type_keyname = providerType.restaurant
            break
        default:
            break
        }
        
        setProName(String(dicProvider["name_en"]!), proType: provider_type_keyname)
        
        
        
        
        setDiscountType("cash")
        
        txtDateStart.placeholder = strDateFormat
        txtDateEnd.placeholder = strDateFormat
        txtUseStart.placeholder = strDateFormat
        txtUseEnd.placeholder = strDateFormat
        
        
        let borderColorCG = UIColor(red: 0.13, green: 0.14, blue: 0.18, alpha: 0.2).CGColor
        
        
        txtCouponName.borderStyle = UITextBorderStyle.None
        txtCouponName.layer.borderWidth = 1
        txtCouponName.layer.borderColor = borderColorCG
        
        txtShortDes.layer.borderWidth = 1
        txtShortDes.layer.borderColor = borderColorCG
        
        txtLongDes.layer.borderWidth = 1
        txtLongDes.layer.borderColor = borderColorCG
        
        txtCouponCount.borderStyle = UITextBorderStyle.None
        txtCouponCount.layer.borderWidth = 1
        txtCouponCount.layer.borderColor = borderColorCG
        
        txtValidate.borderStyle = UITextBorderStyle.None
        txtValidate.layer.borderWidth = 1
        txtValidate.layer.borderColor = borderColorCG
        
        txtPrefixCode.borderStyle = UITextBorderStyle.None
        txtPrefixCode.layer.borderWidth = 1
        txtPrefixCode.layer.borderColor = borderColorCG
        
        let viewBgPrice:UIView = txtPrice.superview!
        viewBgPrice.layer.borderWidth = 1
        viewBgPrice.layer.borderColor = borderColorCG
        
        viewBgDisCash.layer.borderWidth = 1
        viewBgDisCash.layer.borderColor = borderColorCG
        
        viewBgDisPercent.layer.borderWidth = 1
        viewBgDisPercent.layer.borderColor = borderColorCG
        
        txtCondition.layer.borderWidth = 1
        txtCondition.layer.borderColor = borderColorCG
        
        txtContactPhone.borderStyle = UITextBorderStyle.None
        txtContactPhone.layer.borderWidth = 1
        txtContactPhone.layer.borderColor = borderColorCG
        
        txtContactEmail.borderStyle = UITextBorderStyle.None
        txtContactEmail.layer.borderWidth = 1
        txtContactEmail.layer.borderColor = borderColorCG
        
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
