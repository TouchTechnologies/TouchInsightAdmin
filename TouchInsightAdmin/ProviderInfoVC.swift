//
//  ViewController1.swift
//  TouchInsightAdmin
//
//  Created by Touch on 12/8/2558 BE.
//  Copyright © 2558 weerapons suwanchatree. All rights reserved.
//

import UIKit
import PagingMenuController
import PKHUD
import SCLAlertView
class ProviderInfoVC: UIViewController , UIGestureRecognizerDelegate, PagingMenuControllerDelegate
{
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    //let viewWithTopButtons = UIView()
    let btnInfo = UIButton()
    let btnGallery = UIButton()
    let btnLive = UIButton()
    //var viewControllers = UIViewController()
    
    var infoViewController = UIViewController()
    var LocationViewController = UIViewController()
    var RoominfoViewController = UIViewController()
    var navunderlive = UIView()
    
    var _HotelCouponListVC = UIViewController()
    var _HotelCouponListExpireVC = UIViewController()
    
    var options = PagingMenuOptions()
    
    
    @IBOutlet var containnerView: UIView!
    
    @IBAction func backtomyproviderBtn(sender: AnyObject) {
        //performSegueWithIdentifier("backtoproviderlistBtn", sender: self)
        self.navigationController?.popViewControllerAnimated(true)
    }
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
//        if (segue.identifier == "backtoproviderlistBtn") {
//            let nav = segue.destinationViewController as! UINavigationController
//            let providerlist = self.storyboard?.instantiateViewControllerWithIdentifier("providerlist")
//            nav.pushViewController(providerlist!, animated: true)
//            
//            // pass data to next view
//        }
//    }
//    
    
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    var navBar = UINavigationBar()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        
        
        //         navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44 + 20))
        //        self.view.addSubview(navBar);
        //        let navItem = UINavigationItem(title: "");
        //        let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: nil, action: #selector(ProviderInfoVC.backtomyproviderBtn(_:)));
        //        navItem.leftBarButtonItem = doneItem;
        //        navBar.setItems([navItem], animated: false);
        //
        
        
        self.setViewWihtTopButton(appDelegate.viewWithTopButtons)
        self.navigationController?.navigationBar.addSubview(appDelegate.viewWithTopButtons)
        self.appDelegate.viewWithTopButtons.hidden = false
        self.initialInfoVC()
        self.reloadInputViews()
        // self.appDelegate.pagecontrolIndex = 2
        
        self.getProviderByID()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        print("viewWillAppearviewWillAppearviewWillAppear")
        
        self.navigationController?.navigationBarHidden = false
        //self.setViewWihtTopButton(appDelegate.viewWithTopButtons)
        self.navigationController?.navigationBar.addSubview(appDelegate.viewWithTopButtons)
        self.reloadInputViews()
        self.appDelegate.viewWithTopButtons.hidden = false
        //self.initialInfoVC()
        
        if (self.appDelegate.menuFocusIndexOnBack == 0){
            btnInfo.setImage(UIImage(named: "ic_info2.png"), forState: .Normal)
            btnGallery.setImage(UIImage(named: "ic_gellary.png"), forState: .Normal)
            btnLive.setImage(UIImage(named: "ic_coupon_menu1.png"), forState: .Normal)
        }else if(self.appDelegate.menuFocusIndexOnBack == 1){
            btnGallery.setImage(UIImage(named:"ic_gellary2.png"), forState: .Normal)
            btnLive.setImage(UIImage(named: "ic_coupon_menu1.png"), forState: .Normal)
            btnInfo.setImage(UIImage(named: "ic_info.png"), forState: .Normal)
        }else if(self.appDelegate.menuFocusIndexOnBack == 2){
            btnLive.setImage(UIImage(named: "ic_coupon_menu2.png"), forState: .Normal)
            btnInfo.setImage(UIImage(named: "ic_info.png"), forState: .Normal)
            btnGallery.setImage(UIImage(named: "ic_gellary.png"), forState: .Normal)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - PagingMenuControllerDelegate
    
    func willMoveToMenuPage(page: Int) {
        print("willMoveToMenuPage \(page)")
    }
    
    func didMoveToMenuPage(page: Int) {
        print("didMoveToMenuPage \(page)")
        
    }
    
    
    func setViewWihtTopButton(viewWithTopButtons:UIView){
        let x = (self.navigationController?.navigationBar.bounds.size.width)! - 95
        let y = (self.navigationController?.navigationBar.bounds.size.height)!
        viewWithTopButtons.frame = CGRect(origin:CGPoint(x: x, y: y/2-10), size: CGSize(width: 90.0, height: 30.0))
        
        // viewWithTopButtons.backgroundColor = UIColor.redColor()
        btnInfo.tag = 0
        btnInfo.frame = CGRect(origin:CGPoint(x: 0.0, y: 0.0), size: CGSize(width: 20.0, height: 20.0))
        
        // btnInfo.backgroundColor = UIColor.greenColor()
        btnInfo.setImage(UIImage(named: "ic_info2.png"), forState: .Normal)
        btnInfo.addTarget(self, action: #selector(ProviderInfoVC.topMenu(_:)), forControlEvents: .TouchUpInside)
        
        btnGallery.tag = 1
        btnGallery.frame = CGRect(origin:CGPoint(x: 30.0, y: 0.0), size: CGSize(width: 20.0, height: 20.0))
        
        // btnGallery.backgroundColor = UIColor.grayColor()
        btnGallery.setImage(UIImage(named: "ic_gellary.png"), forState: .Normal)
        btnGallery.addTarget(self, action: #selector(ProviderInfoVC.topMenu(_:)), forControlEvents: .TouchUpInside)
        
        btnLive.tag = 2
        btnLive.frame = CGRect(origin:CGPoint(x: 60.0, y: 0.0), size: CGSize(width: 20.0, height: 20.0))
        // btnLive.backgroundColor = UIColor.yellowColor()
        btnLive.setImage(UIImage(named: "ic_coupon_menu1.png"), forState: .Normal)
        btnLive.addTarget(self, action: #selector(ProviderInfoVC.topMenu(_:)), forControlEvents: .TouchUpInside)
        
        print("-----setViewWihtTopButton-----")
        var nn = 0
        for _vv in viewWithTopButtons.subviews {
            print("\(nn)")
            print(_vv)
            print("-----------------")
            nn = nn + 1
        }
        
        viewWithTopButtons.addSubview(btnInfo)
        viewWithTopButtons.addSubview(btnGallery)
        viewWithTopButtons.addSubview(btnLive)
        
        
    }
    func initialInfoVC(){
        infoViewController = self.storyboard?.instantiateViewControllerWithIdentifier("InformationVC") as! InformationVC
        LocationViewController = self.storyboard?.instantiateViewControllerWithIdentifier("LocationVC") as! LocationVC
        RoominfoViewController = self.storyboard?.instantiateViewControllerWithIdentifier("RoomInfoVC") as! RoomInfoVC
        //        let viewControllers = [infoViewController, LocationViewController, RoominfoViewController]
        let viewControllers = [infoViewController,LocationViewController,RoominfoViewController]
        options.menuItemMode = .Underline(height: 3.0, color: UIColor.redColor(), horizontalPadding: 0, verticalPadding: 0)
        let navwidth = self.navigationController?.navigationBar.bounds.size.width
        print("nav width = \(navwidth)")
        options.menuHeight = (self.navigationController?.navigationBar.bounds.size.height)! - 10
        let menuWidth = navwidth!/3
        options.menuDisplayMode = .Standard(widthMode: PagingMenuOptions.MenuItemWidthMode.Fixed(width: menuWidth), centerItem: false, scrollingMode: PagingMenuOptions.MenuScrollingMode.PagingEnabled)
        options.defaultPage = 0
        if(appDelegate.pagecontrolIndex == 2){
            options.defaultPage = 2
        }else{
            options.defaultPage = 0
        }
        options.scrollEnabled = true
        options.menuItemMargin = 0
        options.textColor = UIColor.grayColor()
        options.backgroundColor = UIColor.whiteColor()
        options.lazyLoadingPage = .Three
        
        let pagingMenuController = self.childViewControllers.first as! PagingMenuController
        pagingMenuController.delegate = self
        pagingMenuController.view.bounds.size.width = UIScreen.mainScreen().bounds.size.width
        pagingMenuController.setup(viewControllers: viewControllers, options: options)
        pagingMenuController.menuView.scrollEnabled = true
        pagingMenuController.menuView.menuItemViews.forEach{$0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ProviderInfoVC.handleTapGesture(_:)))) }
    }
    func handleTapGesture(recognizer: UITapGestureRecognizer) {
        let pagingMenuController = self.childViewControllers.first as! PagingMenuController
        let tappedMenuView = recognizer.view as! MenuItemView
        let tappedPage = pagingMenuController.menuView.menuItemViews.indexOf(tappedMenuView)
        if (tappedPage != pagingMenuController.currentPage){
            print("not refresh")
            print("tappedPage = \(tappedPage)") // 0,1,2
            print("currentPage = \(pagingMenuController.currentPage)") // 0,1,2
            
            if((pagingMenuController.currentPage == 0 && tappedPage! == 2) || (pagingMenuController.currentPage == 2 && tappedPage! == 0)){
                pagingMenuController.moveToMenuPage(1, animated: true)
            }else{
                pagingMenuController.moveToMenuPage(tappedPage!, animated: true)
            }
            
        } else {
            if(tappedPage == 0){
                print("tapp 1")
                
            } else if (tappedPage == 1){
                print("tapp 2")
                
                
            } else if (tappedPage == 2){
                print("tapp 3")
            }
        }
    }
    
    
    func initialImageGalleryVC(){
        
        
        let galleryViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ImageGalleryVC") as! ImageGalleryVC
        
        // self.setViewWihtTopButton(appDelegate.viewWithTopButtons)
        // self.navigationController?.navigationBar.addSubview(appDelegate.viewWithTopButtons)
        // self.appDelegate.viewWithTopButtons.hidden = false
        
        
        let viewControllers = [galleryViewController]
        
        options.menuItemMode = .Underline(height: 3.0, color: UIColor.redColor(), horizontalPadding: 0, verticalPadding: 0)
        let navwidth = self.navigationController?.navigationBar.bounds.size.width
        print("nav width = \(navwidth)")
        options.menuHeight = (self.navigationController?.navigationBar.bounds.size.height)! - 10
        let menuWidth = navwidth!/2
        options.menuDisplayMode = .Standard(widthMode: PagingMenuOptions.MenuItemWidthMode.Fixed(width: menuWidth), centerItem: true, scrollingMode: PagingMenuOptions.MenuScrollingMode.PagingEnabled)
        
        
        options.scrollEnabled = false
        options.menuItemMargin = 0
        options.textColor = UIColor.grayColor()
        options.backgroundColor = UIColor.whiteColor()
        
        
        let pagingMenuController = self.childViewControllers.first as! PagingMenuController
        
        pagingMenuController.view.bounds.size.width = UIScreen.mainScreen().bounds.size.width
        pagingMenuController.setup(viewControllers: viewControllers, options: options)
        pagingMenuController.menuView.scrollEnabled = false
        
        
        
    }
    
    
    func initialCouponVC(){
        
//        _HotelCouponListVC = self.storyboard?.instantiateViewControllerWithIdentifier("HotelCouponListVC") as! HotelCouponListVC
//        LocationViewController = self.storyboard?.instantiateViewControllerWithIdentifier("LocationVC") as! LocationVC
//        
//        // self.setViewWihtTopButton(appDelegate.viewWithTopButtons)
//        // self.navigationController?.navigationBar.addSubview(appDelegate.viewWithTopButtons)
//        // self.appDelegate.viewWithTopButtons.hidden = false
//        
//        
//        let viewControllers = [_HotelCouponListVC,LocationViewController]
//        
//        options.menuItemMode = .Underline(height: 3.0, color: UIColor.redColor(), horizontalPadding: 0, verticalPadding: 0)
//        let navwidth = self.navigationController?.navigationBar.bounds.size.width
//        print("nav width = \(navwidth)")
//        options.menuHeight = (self.navigationController?.navigationBar.bounds.size.height)! - 10
//        let menuWidth = navwidth! / 2
//        options.menuDisplayMode = .Standard(widthMode: PagingMenuOptions.MenuItemWidthMode.Fixed(width: menuWidth), centerItem: true, scrollingMode: PagingMenuOptions.MenuScrollingMode.PagingEnabled)
//        
//        
//        options.scrollEnabled = true
//        options.menuItemMargin = 0
//        options.textColor = UIColor.grayColor()
//        options.backgroundColor = UIColor.whiteColor()
//        
//        
//        let pagingMenuController = self.childViewControllers.first as! PagingMenuController
//        
//        pagingMenuController.view.bounds.size.width = UIScreen.mainScreen().bounds.size.width
//        pagingMenuController.setup(viewControllers: viewControllers, options: options)
//        pagingMenuController.menuView.scrollEnabled = false
//        
        
        
        
        
        
        
        
//        infoViewController = self.storyboard?.instantiateViewControllerWithIdentifier("InformationVC") as! InformationVC
//        LocationViewController = self.storyboard?.instantiateViewControllerWithIdentifier("LocationVC") as! LocationVC
//        RoominfoViewController = self.storyboard?.instantiateViewControllerWithIdentifier("RoomInfoVC") as! RoomInfoVC
        
        _HotelCouponListVC = self.storyboard?.instantiateViewControllerWithIdentifier("HotelCouponListVC") as! HotelCouponListVC
        _HotelCouponListExpireVC = self.storyboard?.instantiateViewControllerWithIdentifier("HotelCouponListExpireVC") as! HotelCouponListExpireVC
        
        
        //        let viewControllers = [infoViewController, LocationViewController, RoominfoViewController]
        let viewControllers = [_HotelCouponListVC,_HotelCouponListExpireVC]
        options.menuItemMode = .Underline(height: 3.0, color: UIColor.redColor(), horizontalPadding: 0, verticalPadding: 0)
        let navwidth = self.navigationController?.navigationBar.bounds.size.width
        print("nav width = \(navwidth)")
        options.menuHeight = (self.navigationController?.navigationBar.bounds.size.height)! - 10
        let menuWidth = navwidth!/2
        options.menuDisplayMode = .Standard(widthMode: PagingMenuOptions.MenuItemWidthMode.Fixed(width: menuWidth), centerItem: false, scrollingMode: PagingMenuOptions.MenuScrollingMode.PagingEnabled)
        options.defaultPage = 0
        if(appDelegate.pagecontrolIndex == 2){
            options.defaultPage = 2
        }else{
            options.defaultPage = 0
        }
        options.scrollEnabled = true
        options.menuItemMargin = 0
        options.textColor = UIColor.grayColor()
        options.backgroundColor = UIColor.whiteColor()
        
        
        let pagingMenuController = self.childViewControllers.first as! PagingMenuController
        pagingMenuController.delegate = self
        pagingMenuController.view.bounds.size.width = UIScreen.mainScreen().bounds.size.width
        pagingMenuController.setup(viewControllers: viewControllers, options: options)
        pagingMenuController.menuView.scrollEnabled = true
        pagingMenuController.menuView.menuItemViews.forEach{$0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ProviderInfoVC.handleTapGesture(_:)))) }
        
    }
    
    
    func topMenu(sender : UIButton){
        if (sender.tag == 0){
            btnInfo.setImage(UIImage(named: "ic_info2.png"), forState: .Normal)
            btnGallery.setImage(UIImage(named: "ic_gellary.png"), forState: .Normal)
            btnLive.setImage(UIImage(named: "ic_coupon_menu1.png"), forState: .Normal)
            self.initialInfoVC()
            print("info")
        }else if(sender.tag == 1){
            
            btnGallery.setImage(UIImage(named:"ic_gellary2.png"), forState: .Normal)
            btnLive.setImage(UIImage(named: "ic_coupon_menu1.png"), forState: .Normal)
            btnInfo.setImage(UIImage(named: "ic_info.png"), forState: .Normal)
            self.initialImageGalleryVC()
            
            
            print("Gallery")
        }else if(sender.tag == 2){
//            btnLive.setImage(UIImage(named: "ic_coupon_menu2.png"), forState: .Normal)
//            btnInfo.setImage(UIImage(named: "ic_info.png"), forState: .Normal)
//            btnGallery.setImage(UIImage(named: "ic_gellary.png"), forState: .Normal)
//            print("live stream")
            
//            let alertView = SCLAlertView()
//            alertView.showCircularIcon = false
//            alertView.showNotice("Comming Soon !!!", subTitle: "")
            
            btnLive.setImage(UIImage(named: "ic_coupon_menu2.png"), forState: .Normal)
            btnInfo.setImage(UIImage(named: "ic_info.png"), forState: .Normal)
            btnGallery.setImage(UIImage(named: "ic_gellary.png"), forState: .Normal)
            self.initialCouponVC()
            
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func getProviderByID()
    {
        //        PKHUD.sharedHUD.dimsBackground = false
        //        PKHUD.sharedHUD.userInteractionOnUnderlyingViewsEnabled = false
        //
        //        PKHUD.sharedHUD.contentView = PKHUDStatusView(title: "Loading", subtitle: "Subtitle", image: nil)
        //        PKHUD.sharedHUD.show()
        //        PKHUD.sharedHUD.hide(afterDelay: 1.0)
        
        let send = API_Model()
        print("providerId:::\(appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["provider_id"])")
        
        let dataJson = "{\"providerId\":\"\(appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["provider_id"] as! String)\"}"
        send.providerAPI(self.appDelegate.command["GetProviderInformationById"]!, dataJson: dataJson) {
            data in
            print("getProviderByID \(data)")
            self.appDelegate.providerIDData = data;
            //            PKHUD.sharedHUD.contentView = PKHUDSuccessView()
            //            PKHUD.sharedHUD.hide(afterDelay: 1.0)
            
        }
        
    }
    
}
