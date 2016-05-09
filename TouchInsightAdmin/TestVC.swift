//
//  TestVC.swift
//  TouchInsightAdmin
//
//  Created by weerapons suwanchatree on 11/25/2558 BE.
//  Copyright © 2558 weerapons suwanchatree. All rights reserved.
//

//
//  ViewController.swift
//  JOBBKK
//
//  Created by Thirawat Phannet on 11/13/2558 BE.
//  Copyright © 2558 Thirawat Phannet. All rights reserved.
//

import UIKit

class TestVC: UIViewController,UITextFieldDelegate {
    
    
    let _scrollView = UIScrollView()
    
    let _viewBeforeFade = UIView()
    let _viewBgFade = UIView()
    let _imgLogo = UIImageView()
    
    let _viewBlockButton = UIView()
    
    let _viewBlockButton_Username = UIView()
    let _iconUsername = UIImageView()
    let _txtUsername = UITextField()
    
    let _viewBlockButton_Password = UIView()
    let _iconPassword = UIImageView()
    let _txtPassword = UITextField()
    
    let _btnLogin = FTWButton()
    let _btnLoginShadow = UIView()
    
    let _btnFacebook = FTWButton()
    let _btnLinkedin = FTWButton()
    let _btnGoogle = FTWButton()
    
    let _viewBoxRegisAndForgot = UIView()
    
    let _viewBottom = UIView()
    
    
    
    
    let gradientLayer = CAGradientLayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        design()
        
        
        
        let tap = UITapGestureRecognizer(target: self, action: Selector("hideKeyboard:"))
        self.view.addGestureRecognizer(tap)
    }
    
    func hideKeyboard(gestureRecognizer: UITapGestureRecognizer){
        self.view.endEditing(false)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool{ // called when 'return' key pressed. return NO to ignore.
        //print(textField.tag)
        
        if textField.tag == 100{
            _txtPassword.becomeFirstResponder()
        }
        
        if textField.tag == 200{
            if(_txtUsername.text == ""){
                _txtUsername.becomeFirstResponder()
            }else if(_txtPassword.text == ""){
                _txtPassword.becomeFirstResponder()
            }else{
                textField.resignFirstResponder()
            }
        }
        
        return true;
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func design(){
        
        
        //let globalFont = UIFont(name: "thaisanslite", size: 20)!
        
        //        var topView = UIView()
        //        topView.setTranslatesAutoresizingMaskIntoConstraints(false)
        //        topView.backgroundColor = UIColor.blueColor()
        //
        //        var bottomView = UIView()
        //        bottomView.setTranslatesAutoresizingMaskIntoConstraints(false)
        //        bottomView.backgroundColor = UIColor.redColor()
        //
        //        self.view.addSubview(topView);
        //        self.view.addSubview(bottomView);
        //
        //        // constraints
        //        let viewsDictionary = ["top":topView,"bottom":bottomView]
        //
        //        //position constraints
        //        let view_constraint_H:NSArray = NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[top]-10-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        //        let view_constraint_H2:NSArray = NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[bottom]-10-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        //        let view_constraint_V:NSArray = NSLayoutConstraint.constraintsWithVisualFormat("V:|-20-[top(bottom)]-[bottom]-10-|", options: NSLayoutFormatOptions.AlignAllLeading, metrics: nil, views: viewsDictionary)
        //
        //        view.addConstraints(view_constraint_H)
        //        view.addConstraints(view_constraint_H2)
        //        view.addConstraints(view_constraint_V)
        
        _txtUsername.delegate = self
        _txtPassword.delegate = self
        
        
        //print(self.view.frame.size)
        
        let device = DeviceDetail()
        print(device)
        
        
        
        _scrollView.translatesAutoresizingMaskIntoConstraints = false
        _scrollView.backgroundColor = UIColor.whiteColor()
        _scrollView.scrollEnabled = true
        _scrollView.keyboardDismissMode = .OnDrag
        
        
        var sz_scrollView_h:CGFloat
        if DeviceType.isIpad {
            _scrollView.delaysContentTouches = false
            sz_scrollView_h = CGFloat(self.view.bounds.height)
        }else{
            if(self.view.bounds.height<500){
                sz_scrollView_h = CGFloat(self.view.bounds.height+100)
            }else{
                _scrollView.delaysContentTouches = false
                sz_scrollView_h = CGFloat(self.view.bounds.height)
            }
        }
        
        _scrollView.contentSize = CGSizeMake(self.view.bounds.width, sz_scrollView_h)
        _scrollView.showsVerticalScrollIndicator = false
        _scrollView.showsHorizontalScrollIndicator = false
        //_scrollView.delaysContentTouches = false
        
        
        
        
        
        _viewBeforeFade.translatesAutoresizingMaskIntoConstraints = false
        _viewBeforeFade.backgroundColor = UIColor(red: 212/255, green: 1/255, blue: 1/255, alpha: 1.0)
        _viewBeforeFade.frame = CGRectMake(0, -800, self.view.bounds.width,800)
        
        
        _viewBgFade.translatesAutoresizingMaskIntoConstraints = false
        _viewBgFade.backgroundColor = UIColor.whiteColor()
        _viewBgFade.frame = CGRectMake(0, 0, self.view.bounds.width,120.0)
        
        
        _imgLogo.translatesAutoresizingMaskIntoConstraints = false
        _imgLogo.image = UIImage(named: "login_logo")
        _imgLogo.contentMode = .ScaleAspectFit
        //_imgLogo.backgroundColor = UIColor.blackColor()
        _imgLogo.clipsToBounds = true
        
        
        
        
        var sz_BlockButton_w:CGFloat
        if DeviceType.isIpad {
            sz_BlockButton_w = CGFloat(self.view.frame.width - 320)
        }else{
            sz_BlockButton_w = CGFloat(self.view.frame.width - 70)
        }
        
        //_viewBlockButton.translatesAutoresizingMaskIntoConstraints = true
        _viewBlockButton.clipsToBounds = true
        //_viewBlockButton.backgroundColor = UIColor.yellowColor()
        _viewBlockButton.frame = CGRectMake((self.view.bounds.width/2)-(sz_BlockButton_w/2), 170, sz_BlockButton_w,390)
        
        
        
        
        // # # # # # # # # # # # # # # # # # # # # # #
        let top_Username = CGFloat(0)
        
        _viewBlockButton_Username.clipsToBounds = true
        _viewBlockButton_Username.frame = CGRectMake(0, top_Username, sz_BlockButton_w,34)
        _viewBlockButton_Username.layer.borderColor = UIColor(red:0.92, green:0.11, blue:0.14, alpha:1).CGColor
        _viewBlockButton_Username.layer.borderWidth = 1.6
        _viewBlockButton_Username.layer.cornerRadius = 16
        
        _iconUsername.clipsToBounds = true
        _iconUsername.backgroundColor = UIColor.whiteColor()
        _iconUsername.frame = CGRectMake(12, top_Username+3, 26,26)
        _iconUsername.image = UIImage(named: "login_username")
        _iconUsername.contentMode = .ScaleAspectFit
        _iconUsername.clipsToBounds = true
        
        _txtUsername.frame = CGRectMake(46, top_Username, _viewBlockButton_Username.frame.size.width-46-4,34)
        _txtUsername.attributedPlaceholder = NSAttributedString(string:"ชื่อผู้ใช้งาน / อีเมล",attributes:[NSForegroundColorAttributeName: UIColor(red:0.57, green:0.57, blue:0.57, alpha:1)])
        _txtUsername.returnKeyType = .Next
        _txtUsername.tag = 100
        
       // _txtUsername.font = globalFont
        
        
        _viewBlockButton.addSubview(_iconUsername)
        _viewBlockButton.addSubview(_viewBlockButton_Username)
        _viewBlockButton.addSubview(_txtUsername)
        // # # # # # # # # # # # # # # # # # # # # # #
        
        
        // # # # # # # # # # # # # # # # # # # # # # #
        let top_Password = CGFloat(44)
        
        _viewBlockButton_Password.clipsToBounds = true
        _viewBlockButton_Password.frame = CGRectMake(0, top_Password, sz_BlockButton_w,34)
        _viewBlockButton_Password.layer.borderColor = UIColor(red:0.92, green:0.11, blue:0.14, alpha:1).CGColor
        _viewBlockButton_Password.layer.borderWidth = 1.6
        _viewBlockButton_Password.layer.cornerRadius = 16
        
        _iconPassword.clipsToBounds = true
        _iconPassword.backgroundColor = UIColor.whiteColor()
        _iconPassword.frame = CGRectMake(12, top_Password+3, 26,26)
        _iconPassword.image = UIImage(named: "login_password")
        _iconPassword.contentMode = .ScaleAspectFit
        _iconPassword.clipsToBounds = true
        
        _txtPassword.frame = CGRectMake(46, top_Password, _viewBlockButton_Password.frame.size.width-46-4,34)
        _txtPassword.attributedPlaceholder = NSAttributedString(string:"รหัสผ่าน",attributes:[NSForegroundColorAttributeName: UIColor(red:0.57, green:0.57, blue:0.57, alpha:1)])
        _txtPassword.secureTextEntry = true
        _txtPassword.returnKeyType = .Done
        _txtPassword.tag = 200
        
        //_txtPassword.font = globalFont
        
        _viewBlockButton.addSubview(_iconPassword)
        _viewBlockButton.addSubview(_viewBlockButton_Password)
        _viewBlockButton.addSubview(_txtPassword)
        // # # # # # # # # # # # # # # # # # # # # # #
        
        
        // # # # # # # # # # # # # # # # # # # # # # #
        let top_btnLogin = CGFloat(92)
        
        _btnLoginShadow.frame = CGRectMake(0, top_btnLogin+4, sz_BlockButton_w,42)
        _btnLoginShadow.layer.cornerRadius = 6.0
        _btnLoginShadow.backgroundColor = UIColor(red: 119/255, green: 36/255, blue: 38/255, alpha: 1.0)
        
        _btnLogin.frame = CGRectMake(0, top_btnLogin, sz_BlockButton_w,42)
        _btnLogin.addBtnLogin(.Normal)
        _btnLogin.setText("เข้าสู่ระบบ", forControlState: .Normal)
        _btnLogin.setFont(UIFont(name: "thaisanslite", size: 30))
        
        
        _viewBlockButton.addSubview(_btnLoginShadow)
        _viewBlockButton.addSubview(_btnLogin)
        
        // # # # # # # # # # # # # # # # # # # # # # #
        
        
        // # # # # # # # # # # # # # # # # # # # # # #
        let top_boxRegisAndForgot = CGFloat(146)
        
        let _paddingWidth = CGFloat(8)
        let _paddingHight = CGFloat(8)
        let _paddingSpace = CGFloat(12)
        
        _viewBoxRegisAndForgot.frame = CGRectMake(0, top_boxRegisAndForgot, sz_BlockButton_w,36)
        
        let _btnRegister = UIButton()
        let _btnForgot = UIButton()
        let _lblRegister = UILabel()
        let _lblForgot = UILabel()
        
        let _viewSpliterH = UIView()
        let _viewSpliterV = UIView()
        
        let _lbl_Or = UILabel()
        
        
        let strRegister = "ลงทะเบียน" as NSString
        _lblRegister.text = strRegister as String
        
        let strForgot = "ลืมรหัสผ่าน ?" as NSString
        _lblForgot.text = strForgot as String
        
        
        var attrTemp = NSMutableAttributedString()
        
        attrTemp = NSMutableAttributedString(string:strRegister as String)
        let Attributes1 = [NSFontAttributeName:UIFont(name: "thaisanslite", size: 20)!]
        attrTemp.addAttributes(Attributes1, range: NSRange(location:0,length:strRegister.length))
        _lblRegister.attributedText = attrTemp
        _lblRegister.sizeToFit()
        
        
        attrTemp = NSMutableAttributedString(string:strForgot as String)
        let Attributes2 = [NSFontAttributeName:UIFont(name: "thaisanslite", size: 20)!]
        attrTemp.addAttributes(Attributes2, range: NSRange(location:0,length:strForgot.length))
        _lblForgot.attributedText = attrTemp
        _lblForgot.sizeToFit()
        
        
        var RectRegis = _lblRegister.frame
        var RectForgot = _lblForgot.frame
        
        RectRegis.origin.x = _paddingWidth
        RectRegis.origin.y = 0
        RectRegis.size.width = CGFloat(RectRegis.size.width + _paddingWidth)
        RectRegis.size.height = RectRegis.size.height + _paddingHight
        
        
        RectForgot.origin.x = CGFloat(RectRegis.size.width + ((_paddingWidth*2) + _paddingSpace))
        RectForgot.origin.y = 0
        RectForgot.size.width = CGFloat(RectForgot.size.width + _paddingWidth)
        RectForgot.size.height = RectForgot.size.height + _paddingHight
        
        _lblRegister.frame = RectRegis
        _lblForgot.frame = RectForgot
        
        let _widthAllButton = CGFloat(CGFloat(_lblRegister.frame.size.width + _lblForgot.frame.size.width) + ((_paddingWidth*2) + _paddingSpace) )
        
        
        
        
        var RectBtnRegis = _lblRegister.frame
        var RectBtnForgot = _lblForgot.frame
        
        RectBtnRegis.size.width = RectBtnRegis.size.width + _paddingWidth
        RectBtnRegis.origin.x = RectBtnRegis.origin.x - _paddingWidth
        
        RectBtnForgot.size.width = RectBtnForgot.size.width + _paddingWidth
        RectBtnForgot.origin.x = RectBtnForgot.origin.x - _paddingWidth
        
        
        _btnRegister.frame = RectBtnRegis
        _btnRegister.addTarget(self, action: "clickMe:", forControlEvents: UIControlEvents.TouchUpInside)
        _btnRegister.alpha = 0.6
        
        
        _btnForgot.frame = RectBtnForgot
        _btnForgot.addTarget(self, action: "clickMe:", forControlEvents: UIControlEvents.TouchUpInside)
        _btnForgot.alpha = 0.6
        
        
        _viewSpliterH.frame = CGRectMake((_btnForgot.frame.origin.x - (_paddingSpace/2)-1), 8, 2, 15)
        _viewSpliterH.backgroundColor = UIColor(red:0.49, green:0.45, blue:0.49, alpha:0.6)
        
        
        
        
        let top_SpliterV = CGFloat(206)
        let flt_SpliterV_w = CGFloat(_viewBoxRegisAndForgot.frame.size.width-40)
        _viewSpliterV.frame = CGRectMake(CGFloat(CGFloat((_viewBoxRegisAndForgot.frame.size.width / 2) - (flt_SpliterV_w/2))), top_SpliterV, flt_SpliterV_w, 2)
        _viewSpliterV.backgroundColor = UIColor(red:0.49, green:0.45, blue:0.49, alpha:0.6)
        
        
        var Rect_BoxRegisAndForgot = _viewBoxRegisAndForgot.frame
        Rect_BoxRegisAndForgot.size.width = _widthAllButton
        Rect_BoxRegisAndForgot.origin.x = CGFloat(((_viewBlockButton.frame.size.width / 2) - (_widthAllButton/2)))
        _viewBoxRegisAndForgot.frame = Rect_BoxRegisAndForgot
        
        
        
        
        let top_lbl_Or = CGFloat(190)
        let flt_lbl_Or_w = CGFloat(80)
        _lbl_Or.frame = CGRectMake(CGFloat(CGFloat((_viewBlockButton.frame.size.width / 2) - (flt_lbl_Or_w/2))), top_lbl_Or, flt_lbl_Or_w, 30)
        _lbl_Or.backgroundColor = .whiteColor()
        //_lbl_Or.font = globalFont
        _lbl_Or.textAlignment = .Center
        _lbl_Or.text = "หรือ"
        
        
        // # # # # # # # # # # # # # # # # # # # # # #
        
        
        // # # # # # # # # # # # # # # # # # # # # # #
        let _btnSpaceY = CGFloat(10)
        let btnSocialWidth = CGFloat(200)
        let btnSocialHeight = CGFloat(34)
        let btnSocialx = CGFloat(((_viewBlockButton.bounds.width/2)-btnSocialWidth/2))
        
        let top_btnFacebook = CGFloat(234)
        let top_btnLinkedin = CGFloat((top_btnFacebook + btnSocialHeight) + _btnSpaceY)
        let top_btnGoogle = CGFloat((top_btnLinkedin + btnSocialHeight) + _btnSpaceY)
        
        
        
        
        _btnFacebook.frame = CGRectMake(btnSocialx, top_btnFacebook, btnSocialWidth,34)
        _btnFacebook.addBtnFacebook(.Normal)
        _btnFacebook.setText("Login With Facebook", forControlState: UIControlState.Normal)
        _btnFacebook.setFont(UIFont(name: "thaisanslite", size: 20))
        _btnFacebook.setIcon(UIImage(named: "loginFbIcon"), forControlState: UIControlState.Normal)
        _btnFacebook.setIcon(UIImage(named: "loginFbIcon"), forControlState: UIControlState.Selected)
        _btnFacebook.setIcon(UIImage(named: "loginFbIcon"), forControlState: UIControlState.Reserved)
        _btnFacebook.setIcon(UIImage(named: "loginFbIcon"), forControlState: UIControlState.Highlighted)
        _btnFacebook.textAlignment = .Left
        
        
        _btnLinkedin.frame = CGRectMake(btnSocialx, top_btnLinkedin, btnSocialWidth,34)
        _btnLinkedin.addBtnLinkedin(.Normal)
        _btnLinkedin.setText("Login With Linkedin", forControlState: UIControlState.Normal)
        _btnLinkedin.setFont(UIFont(name: "thaisanslite", size: 20))
        _btnLinkedin.setIcon(UIImage(named: "loginMailIcon"), forControlState: UIControlState.Normal)
        _btnLinkedin.setIcon(UIImage(named: "loginMailIcon"), forControlState: UIControlState.Selected)
        _btnLinkedin.setIcon(UIImage(named: "loginMailIcon"), forControlState: UIControlState.Highlighted)
        _btnLinkedin.textAlignment = .Left
        
        
        
        
        
        _btnGoogle.frame = CGRectMake(btnSocialx, top_btnGoogle, btnSocialWidth,34)
        _btnGoogle.addBtnGoogle(.Normal)
        _btnGoogle.setText("Login With Google", forControlState: UIControlState.Normal)
        _btnGoogle.setFont(UIFont(name: "thaisanslite", size: 20))
        
        _btnGoogle.setIcon(UIImage(named: "loginMailIcon"), forControlState: UIControlState.Normal)
        _btnGoogle.setIcon(UIImage(named: "loginMailIcon"), forControlState: UIControlState.Selected)
        _btnGoogle.setIcon(UIImage(named: "loginMailIcon"), forControlState: UIControlState.Highlighted)
        _btnGoogle.textAlignment = .Left
        
        // # # # # # # # # # # # # # # # # # # # # # #
        
        
        
        
        //_viewBoxRegisAndForgot.addSubview(_btnRegister)
        //_viewBoxRegisAndForgot.addSubview(_btnForgot)
        
        _viewBoxRegisAndForgot.addSubview(_lblRegister)
        _viewBoxRegisAndForgot.addSubview(_lblForgot)
        _viewBoxRegisAndForgot.addSubview(_btnRegister)
        _viewBoxRegisAndForgot.addSubview(_btnForgot)
        _viewBoxRegisAndForgot.addSubview(_viewSpliterH)
        
        _viewBlockButton.addSubview(_viewSpliterV)
        _viewBlockButton.addSubview(_lbl_Or)
        
        _viewBlockButton.addSubview(_btnFacebook)
        _viewBlockButton.addSubview(_btnLinkedin)
        _viewBlockButton.addSubview(_btnGoogle)
        
        
        _viewBlockButton.addSubview(_viewBoxRegisAndForgot)
        
        
        //_viewBlockButton.backgroundColor = UIColor.yellowColor()
        
        
        // # # # # # # # # # # # # # # # # # # # # # #
        
        
        
        
        
        //        let top_testLabel = CGFloat(200)
        //        let _lblText = UILabel()
        //        _lblText.frame = CGRectMake(0, top_testLabel, sz_BlockButton_w,90)
        //        _lblText.text = "สวัสดีครับ ทอสอบนะครับ ๕๕๖๗๘"
        //        _lblText.textAlignment = .Center
        //        _lblText.textColor = UIColor.blueColor()
        //
        //        let preferredDescriptor = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        //        let font = UIFont(name: "thaisanslite", size: preferredDescriptor.pointSize)
        //        _lblText.font = font
        //        _lblText.font = UIFont(name: "thaisanslite", size: 20)
        //
        //        _viewBlockButton.addSubview(_lblText)
        
        
        
        
        
        _viewBottom.translatesAutoresizingMaskIntoConstraints = false
        _viewBottom.backgroundColor = UIColor.greenColor()
        _viewBottom.frame = CGRectMake(0, _scrollView.contentSize.height - 80, self.view.bounds.width, 80)
        
        
        
        
        self.view.addSubview(_scrollView)
        _scrollView.addSubview(_viewBeforeFade)
        _scrollView.addSubview(_viewBgFade)
        
        //_scrollView.addSubview(_viewBottom)
        
        _scrollView.addSubview(_viewBlockButton)
        
        _scrollView.addSubview(_imgLogo)
        
        
        
        gradientLayer.frame = _viewBgFade.frame
        let color1 = UIColor(red: 212/255, green: 1/255, blue: 1/255, alpha: 1.0).CGColor as CGColorRef
        let color2 = UIColor(red: 212/255, green: 1/255, blue: 1/255, alpha: 0.0).CGColor as CGColorRef
        let color3 = UIColor(red: 255/255, green: 1/255, blue: 1/255, alpha: 0.0).CGColor as CGColorRef
        gradientLayer.colors = [color1, color2, color3]
        gradientLayer.locations = [0.0,0.9,1.0]
        //        self.view.layer.addSublayer(gradientLayer)
        _viewBgFade.layer.addSublayer(gradientLayer)
        
        
        
        
        
        
        
        
        let vd_sv = ["sv_top":_scrollView]
        let view_constraint_H:NSArray = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[sv_top]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: vd_sv)
        let view_constraint_V:NSArray = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[sv_top]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: vd_sv)
        
        view.addConstraints(view_constraint_H as! [NSLayoutConstraint])
        view.addConstraints(view_constraint_V as! [NSLayoutConstraint])
        
        var sz_logo_w,sz_logo_h:String
        if DeviceType.isIpad {
            sz_logo_w = String(320)
            sz_logo_h = String(160)
        }else{
            sz_logo_w = String(250)
            sz_logo_h = String(120)
        }
        
        let vd_logo = ["sv_logo":_imgLogo]
        let cs_logo_H:NSArray = NSLayoutConstraint.constraintsWithVisualFormat("H:[sv_logo(\(sz_logo_w))]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: vd_logo)
        let cs_logo_V:NSArray = NSLayoutConstraint.constraintsWithVisualFormat("V:|-22-[sv_logo(\(sz_logo_h))]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: vd_logo)
        
        _scrollView.addConstraints(cs_logo_H as! [NSLayoutConstraint])
        _scrollView.addConstraints(cs_logo_V as! [NSLayoutConstraint])
        
        let cct_logo = NSLayoutConstraint(item: _imgLogo, attribute: .CenterX, relatedBy: .Equal, toItem: _scrollView, attribute: .CenterX, multiplier: 1, constant: 0)
        _scrollView.addConstraint(cct_logo)
        
        
        
        //        let vd_BlockButton = ["sv_BlockButton":_viewBlockButton]
        //        let cs_BlockButton_H:NSArray = NSLayoutConstraint.constraintsWithVisualFormat("H:|-30-[sv_BlockButton]-30-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: vd_BlockButton)
        //        let cs_BlockButton_V:NSArray = NSLayoutConstraint.constraintsWithVisualFormat("V:|-160-[sv_BlockButton]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: vd_BlockButton)
        //
        //        _scrollView.addConstraints(cs_BlockButton_H as! [NSLayoutConstraint])
        //        _scrollView.addConstraints(cs_BlockButton_V as! [NSLayoutConstraint])
        
        let cct_blockbutton = NSLayoutConstraint(item: _viewBlockButton, attribute: .CenterX, relatedBy: .Equal, toItem: _scrollView, attribute: .CenterX, multiplier: 1, constant: 0)
        _scrollView.addConstraint(cct_blockbutton)
        
        
        
        
    }
    
    
    func clickMe(sender:UIButton!){
        print("Button Clicked")
        
        
        
    }
    
    
    
    func pressed(sender: UIButton!) {
        let alertView = UIAlertView();
        alertView.addButtonWithTitle("Ok");
        alertView.title = "title";
        alertView.message = "message";
        alertView.show();
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

