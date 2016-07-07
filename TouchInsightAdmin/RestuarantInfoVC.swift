//
//  RestuarantInfoVC.swift
//  TouchInsightAdmin
//
//  Created by Touch Developer on 2/23/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

import UIKit
import PagingMenuController

class RestuarantInfoVC: UIViewController, PagingMenuControllerDelegate {
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    @IBOutlet var containerView: UIView!
    @IBAction func backBtn(sender: AnyObject) {
        
    }
    var infoViewController = UIViewController()
    var LocationViewController = UIViewController()
    var MenulistViewController = UIViewController()
    var navunderlive = UIView()
    
    var options = PagingMenuOptions()
    
    
    
    //let viewWithTopButtons = UIView()
    let btnInfo = UIButton()
    let btnGallery = UIButton()
    let btnLive = UIButton()
    
    override func viewWillAppear(animated: Bool) {
        // self.getProviderByID()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViewWihtTopButton(appDelegate.viewWithTopButtons)
        self.navigationController?.navigationBar.addSubview(appDelegate.viewWithTopButtons)
        self.appDelegate.viewWithTopButtons.hidden = false
        self.initialInfoVC()
        self.reloadInputViews()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        btnInfo.addTarget(self, action: #selector(RestuarantInfoVC.topMenu(_:)), forControlEvents: .TouchUpInside)
        
        btnGallery.tag = 1
        btnGallery.frame = CGRect(origin:CGPoint(x: 30.0, y: 0.0), size: CGSize(width: 20.0, height: 20.0))
        
        // btnGallery.backgroundColor = UIColor.grayColor()
        btnGallery.setImage(UIImage(named: "ic_gellary.png"), forState: .Normal)
        btnGallery.addTarget(self, action: #selector(RestuarantInfoVC.topMenu(_:)), forControlEvents: .TouchUpInside)
        
        btnLive.tag = 2
        btnLive.frame = CGRect(origin:CGPoint(x: 60.0, y: 0.0), size: CGSize(width: 20.0, height: 20.0))
        // btnLive.backgroundColor = UIColor.yellowColor()
        btnLive.setImage(UIImage(named: "ic_livestream_menu.png"), forState: .Normal)
        btnLive.addTarget(self, action: #selector(RestuarantInfoVC.topMenu(_:)), forControlEvents: .TouchUpInside)
        
        
        viewWithTopButtons.addSubview(btnInfo)
        viewWithTopButtons.addSubview(btnGallery)
        viewWithTopButtons.addSubview(btnLive)
        
        
    }
    func initialInfoVC(){
        infoViewController = self.storyboard?.instantiateViewControllerWithIdentifier("RestuarantInfoVC") as! RestuarantInfoViewController
        LocationViewController = self.storyboard?.instantiateViewControllerWithIdentifier("RestLocationVC") as! RestLocationViewController
        MenulistViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MenuInfoVC") as! MenuViewController
        
        let viewControllers = [infoViewController,LocationViewController,MenulistViewController]
        
        options.menuItemMode = .Underline(height: 3.0, color: UIColor.redColor(), horizontalPadding: 0, verticalPadding: 0)
        let navwidth = self.navigationController?.navigationBar.bounds.size.width
        print("nav width = \(navwidth)")
        options.menuHeight = (self.navigationController?.navigationBar.bounds.size.height)! - 10
        let menuWidth = navwidth!/3
        options.menuDisplayMode = .Standard(widthMode: PagingMenuOptions.MenuItemWidthMode.Fixed(width: menuWidth), centerItem: false, scrollingMode: PagingMenuOptions.MenuScrollingMode.PagingEnabled)
        //options.defaultPage = 0
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
        pagingMenuController.view.bounds.size.width = UIScreen.mainScreen().bounds.size.width
        pagingMenuController.setup(viewControllers: viewControllers, options: options)
        pagingMenuController.menuView.scrollEnabled = true
        pagingMenuController.menuView.menuItemViews.forEach{$0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(RestuarantInfoVC.handleTapGesture(_:)))) }
    }
    func handleTapGesture(recognizer: UITapGestureRecognizer) {
        let pagingMenuController = self.childViewControllers.first as! PagingMenuController
        let tappedMenuView = recognizer.view as! MenuItemView
        let tappedPage = pagingMenuController.menuView.menuItemViews.indexOf(tappedMenuView)
        if (tappedPage != pagingMenuController.currentPage){
            print("not refresh");
        }
        else
        {
            if(tappedPage == 0){
                print("tapp 1")
            }
            else if(tappedPage == 1){
                print("tapp 2")
                
                
            }
            else if(tappedPage == 2){
                print("tapp 3")
            }
        }
    }
    
    
    func initialImageGalleryVC(){
        
        
        let galleryViewController = self.storyboard?.instantiateViewControllerWithIdentifier("imagegallery") as! ImageGalleryVC
        
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
    
    func topMenu(sender : UIButton){
        
        if (sender.tag == 0){
            btnInfo.setImage(UIImage(named: "ic_info2.png"), forState: .Normal)
            btnGallery.setImage(UIImage(named: "ic_gellary.png"), forState: .Normal)
            btnLive.setImage(UIImage(named: "ic_livestream_menu.png"), forState: .Normal)
            self.initialInfoVC()
            print("info")
            
        }else if(sender.tag == 1){
            btnGallery.setImage(UIImage(named:"ic_gellary2.png"), forState: .Normal)
            btnLive.setImage(UIImage(named: "ic_livestream_menu.png"), forState: .Normal)
            btnInfo.setImage(UIImage(named: "ic_info.png"), forState: .Normal)
            self.initialImageGalleryVC()
            print("Gallery")
            
        }
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


