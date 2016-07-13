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
class RestuarantListVC: UIViewController , PagingMenuControllerDelegate
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
    
    override func viewDidLoad() {
        print("RestuarantListVC")
        super.viewDidLoad()
        self.setViewWihtTopButton(appDelegate.viewWithTopButtons)
        self.navigationController?.navigationBar.addSubview(appDelegate.viewWithTopButtons)
        self.appDelegate.viewWithTopButtons.hidden = false
        self.initialInfoVC()
        //self.reloadInputViews()
        // self.appDelegate.pagecontrolIndex = 2
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
        self.getProviderByID()
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - PagingMenuControllerDelegate
    
    func willMoveToMenuPage(page: Int) {
    }
    
    func didMoveToMenuPage(page: Int) {
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
        btnInfo.addTarget(self, action: #selector(RestuarantListVC.topMenu(_:)), forControlEvents: .TouchUpInside)
        
        btnGallery.tag = 1
        btnGallery.frame = CGRect(origin:CGPoint(x: 30.0, y: 0.0), size: CGSize(width: 20.0, height: 20.0))
        
        // btnGallery.backgroundColor = UIColor.grayColor()
        btnGallery.setImage(UIImage(named: "ic_gellary.png"), forState: .Normal)
        btnGallery.addTarget(self, action: #selector(RestuarantListVC.topMenu(_:)), forControlEvents: .TouchUpInside)
        
        btnLive.tag = 2
        btnLive.frame = CGRect(origin:CGPoint(x: 60.0, y: 0.0), size: CGSize(width: 20.0, height: 20.0))
        // btnLive.backgroundColor = UIColor.yellowColor()
        btnLive.setImage(UIImage(named: "ic_livestream_menu.png"), forState: .Normal)
        btnLive.addTarget(self, action: #selector(RestuarantListVC.topMenu(_:)), forControlEvents: .TouchUpInside)
        
        
        viewWithTopButtons.addSubview(btnInfo)
        viewWithTopButtons.addSubview(btnGallery)
        viewWithTopButtons.addSubview(btnLive)
        
        
    }
    func initialInfoVC(){
        infoViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ResInformationVC") as! ResInformationVC
        LocationViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ResLocationVC") as! ResLocationVC
        RoominfoViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ResMenuInfoVC") as! ResMenuInfoVC
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
        }
        else{
            options.defaultPage = 0
        }
        options.scrollEnabled = true
        options.menuItemMargin = 0
        options.textColor = UIColor.grayColor()
        options.backgroundColor = UIColor.whiteColor()
        
        
        let pagingMenuController = self.childViewControllers.first as! PagingMenuController
        pagingMenuController.delegate = self
        pagingMenuController.view.bounds.size.width = self.view.frame.size.width // UIScreen.mainScreen().bounds.size.width
        pagingMenuController.setup(viewControllers: viewControllers, options: options)
        pagingMenuController.menuView.scrollEnabled = true
        pagingMenuController.menuView.menuItemViews.forEach{$0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(RestuarantListVC.handleTapGesture(_:)))) }
    }
    func handleTapGesture(recognizer: UITapGestureRecognizer) {
        let pagingMenuController = self.childViewControllers.first as! PagingMenuController
        let tappedMenuView = recognizer.view as! MenuItemView
        let tappedPage = pagingMenuController.menuView.menuItemViews.indexOf(tappedMenuView)
        if (tappedPage != pagingMenuController.currentPage){
            print("not refresh")
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
        
        pagingMenuController.view.bounds.size.width = self.view.frame.size.width // UIScreen.mainScreen().bounds.size.width
        pagingMenuController.setup(viewControllers: viewControllers, options: options)
        pagingMenuController.menuView.scrollEnabled = false
        
        
        
    }
    func topMenu(sender : UIButton){
        if (sender.tag == 0){
            btnInfo.setImage(UIImage(named: "ic_info2.png"), forState: .Normal)
            btnGallery.setImage(UIImage(named: "ic_gellary.png"), forState: .Normal)
            btnLive.setImage(UIImage(named: "ic_livestream_menu.png"), forState: .Normal)
            self.initialInfoVC()
            print("info")
        }
        else if(sender.tag == 1){
            
            btnGallery.setImage(UIImage(named:"ic_gellary2.png"), forState: .Normal)
            btnLive.setImage(UIImage(named: "ic_livestream_menu.png"), forState: .Normal)
            btnInfo.setImage(UIImage(named: "ic_info.png"), forState: .Normal)
            self.initialImageGalleryVC()
            
            
            print("Gallery")
        }
        //
        //
        //        else if(sender.tag == 2){
        //            btnLive.setImage(UIImage(named: "ic_livestream_menu.png"), forState: .Normal)
        //            btnInfo.setImage(UIImage(named: "ic_info.png"), forState: .Normal)
        //            btnGallery.setImage(UIImage(named: "ic_gellary.png"), forState: .Normal)
        //        print("live stream")
        //        }
        
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
