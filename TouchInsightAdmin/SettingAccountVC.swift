//
//  SettingAccountVC.swift
//  TouchInsightAdmin
//
//  Created by Touch on 12/2/2558 BE.
//  Copyright © 2558 weerapons suwanchatree. All rights reserved.
//

import UIKit
import SCLAlertView
import RealmSwift
import SwiftyJSON

class SettingAccountVC: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let rmm = RmMemberModel()
    @IBOutlet var tableview: UITableView!
    var menu :[String] = ["Edit Profile","Notification","Help"]
    var navunderlive = UIView()
    
    
    @IBAction func btnBacktoMain(sender: AnyObject) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func btnLogout(sender: AnyObject) {
        let alert = SCLAlertView()
        alert.addButton("OK"){
            
//            let realm = try! Realm()
//            try! realm.write {
//                realm.deleteAll()
//            }

            self.rmm.MemberData_Delete()
            
            print("Logout")
            print("before Logout : \(self.appDelegate.userInfo)")
            self.appDelegate.userInfo = [:]
            print("after Logout : \(self.appDelegate.userInfo)")
            print(  self.appDelegate.userInfo["firstName"] )
            
            
            let loginview = self.storyboard?.instantiateViewControllerWithIdentifier("LoginVC") as! LoginVC
            loginview.modalTransitionStyle = .CrossDissolve
            
            let navCon : UINavigationController = self.storyboard?.instantiateViewControllerWithIdentifier("loginNav") as! UINavigationController
            //            self.navigationController?.pushViewController(navCon, animated: true)
            //             navCon.presentViewController(loginview, animated: true, completion: nil)
            
            
//            navCon.modalTransitionStyle = .CrossDissolve
            navCon.modalTransitionStyle = .CoverVertical
            self.presentViewController(navCon, animated: true, completion: nil)
        }
        
        alert.showCircularIcon = false
        alert.showInfo("Logout", subTitle: "logout?", closeButtonTitle: "Cancel",colorStyle:0xDB3F42 , colorTextButton: 0xFFFFFF )
        
    }
    
    override func viewDidLoad(){
        
        super.viewDidLoad()
        //        self.navigationController?.navigationBarHidden = false
//        
//        self.navigationController?.navigationBar.backgroundColor = UIColor.whiteColor()
        
        
        let appJson = JSON(self.appDelegate.userInfo)
        print("appJson")
        print(appJson)
        print("- - - - - - - - - - - -")
        
        
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
//        self.setViewStle()
        self.initNavUnderline()
        tableview.registerClass(UITableViewCell.self,forCellReuseIdentifier: "cell")
        
        //self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
    }
    override func viewWillAppear(animated: Bool) {
        
//        self.navigationController?.navigationBar.tintColor = UIColor.greenColor()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        if let indexPath = self.tableview.indexPathForSelectedRow as NSIndexPath?{
            
            self.tableview.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        
//        self.navigationController?.navigationBar.backgroundColor = UIColor.whiteColor()
        //self.navigationController?.navigationBar.backgroundColor = UIColor(red: 0.33, green: 0.33, blue: 0.33, alpha: 1)
//        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        print("viewWillDisappear")
        //self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    
    func initNavUnderline(){
        navunderlive.frame = CGRectMake(self.view.frame.size.width/3, (self.navigationController?.navigationBar.frame.size.height)! - 3, self.view.frame.size.width/3, 3)
        navunderlive.backgroundColor = UIColor.redColor()
        
        self.navigationController?.navigationBar.addSubview(navunderlive)
        
        

        
//        print("------- navView -------")
//        for navView in (self.navigationController?.navigationBar.items)! {
//            let navItem:UINavigationItem = navView
//            for itenInNav in navItem {
//                
//                print(itenInNav)
//                
//            }
////            print(navItem)
//        }
//        print("------- navView -------")
        
    }
    
//    func setViewStle(){
//        tableview.registerClass(UITableViewCell.self,forCellReuseIdentifier: "cell")
//        
//        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.21, green:0.21, blue:0.21, alpha:1)
//        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
//    }
    /*    func setViewStle2(){
     tableview.registerClass(UITableViewCell.self,forCellReuseIdentifier: "cell")
     navigationController?.setNavigationBarHidden(true, animated: true)
     navigationController!.navigationBar.barTintColor = UIColor(red:0.21, green:0.21, blue:0.21, alpha:1)
     navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
     
     
     }*/
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menu.count
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(" Index Path : \(indexPath.row)")
        
        if (indexPath.row == 0){
            let editProfileView = storyboard?.instantiateViewControllerWithIdentifier("editprofileVC") as! EditProfileVC
            self.navigationController?.pushViewController(editProfileView, animated:true)
            
        }
        else if (indexPath.row == 1){
            self.tableview.deselectRowAtIndexPath(indexPath, animated: true)
        }
        else if (indexPath.row == 2){
            
            let helpView = storyboard?.instantiateViewControllerWithIdentifier("introview") as! IntroViewVC
            self.navigationController?.pushViewController(helpView, animated:true)
            
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        
        cell.textLabel?.text = self.menu[indexPath.row]
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setTableViewStlye()
    {
        
    }
    
}
