//
//  AddProviderAlertVC.swift
//  TouchInsightAdmin
//
//  Created by Touch on 12/22/2558 BE.
//  Copyright © 2558 weerapons suwanchatree. All rights reserved.
//

import UIKit
import RNGridMenu
class AddProviderAlertVC: UIViewController , RNGridMenuDelegate {

    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    @IBAction func testAlertBtn(sender: AnyObject) {
        
        print("test Btn")
        self.showGrid()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.imageView.layer.borderWidth = 2
//        self.imageView.layer.borderColor = UIColor.whiteColor().CGColor
//        self.imageView.layer.cornerRadius = CGRectGetHeight(self.imageView.bounds) / 2
//        self.imageView.clipsToBounds = true
        
//        let longPress: RNLongPressGestureRecognizer = RNLongPressGestureRecognizer(target: self, action: Selector("handleLongPress:"))
//        self.view!.addGestureRecognizer(longPress)
//
       

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func showGrid() {
        let numberOfOptions: Int = 9
        let items: AnyObject = [RNGridMenuItem(image: UIImage(named: "arrow"), title: "Next"), RNGridMenuItem(image: UIImage(named: "attachment"), title: "Attach"), RNGridMenuItem(image: UIImage(named: "block"), title: "Cancel"), RNGridMenuItem(image: UIImage(named: "bluetooth"), title: "Bluetooth"), RNGridMenuItem(image: UIImage(named: "cube"), title: "Deliver"), RNGridMenuItem(image: UIImage(named: "download"), title: "Download"), RNGridMenuItem(image: UIImage(named: "enter"), title: "Enter"), RNGridMenuItem(image: UIImage(named: "file"), title: "Source Code"), RNGridMenuItem(image: UIImage(named: "github"), title: "Github")]
        
//        var items2:AnyObject = RNGridMenuItem(image: UIImage(named: "arrow"), title: "Next")
        let av: RNGridMenu = RNGridMenu(items: items.subarrayWithRange(NSMakeRange(0, numberOfOptions)))
        av.delegate = self
        //    av.bounces = NO;
        
        
        av.showInViewController(self, center: CGPointMake(self.view.bounds.size.width/2 , self.view.bounds.size.height/2))
}

    func gridMenu(gridMenu: RNGridMenu, willDismissWithSelectedItem item: RNGridMenuItem, atIndex itemIndex: Int) {
        NSLog("Dismissed with item %d: %@", itemIndex, item.title)
    }
    func showImagesOnly() {
        let numberOfOptions: Int = 5
        let images: AnyObject = [
            UIImage(named: "arrow")!,
            UIImage(named: "attachment")!,
            UIImage(named: "block")!,
            UIImage(named: "bluetooth")!,
            UIImage(named: "cube")!,
            UIImage(named: "download")!,
            UIImage(named: "enter")!,
            UIImage(named: "file")!,
            UIImage(named: "github")!]
        
        let av: RNGridMenu = RNGridMenu(images: images.subarrayWithRange(NSMakeRange(0, numberOfOptions)))
        av.delegate = self
        av.showInViewController(self, center: CGPointMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0))
    }
}