//
//  RModel.swift
//  TouchInsightAdmin
//
//  Created by Thirawat Phannet on 8/9/59.
//  Copyright © พ.ศ. 2559 weerapons suwanchatree. All rights reserved.
//

import Foundation
import RealmSwift

class RmMemberModel {
    var _member : Results<MemberData>!
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate


    
    
    func MemberData_Delete() {
        
        self._member = uiRealm.objects(MemberData)
        let realm = try! Realm()
        try! realm.write {
            realm.delete(self._member)
        }
        
    }
    
    func MemberData_IsExists()->[String:AnyObject] {
        var returnData = [String:AnyObject]()
        self._member = uiRealm.objects(MemberData)
        if self._member != nil && (self._member).toArray().count > 0{
            let mData = ((self._member).toArray().last!)
            returnData["status"] = true
            returnData["data"] = mData
        }else{
            returnData["status"] = false
            returnData["data"] = [:]
        }
        
//        print("- - - - - - - - MemberData_IsExists - - - - - - - - - - -")
//        print("- - - - - - - - returnData - - - - - - - - - - - - -")
//        print(returnData)
//        print("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -")
        
        return returnData
    }
    
    
    
    func MemberData_Fetch_RealmToLocal() {
        
        self._member = uiRealm.objects(MemberData)
        
        if self._member != nil && (self._member).toArray().count > 0{
            
            let mData = ((self._member).toArray().last!)
            
            self.appDelegate.userInfo["userID"] = (mData["userID"] as! String)
            self.appDelegate.userInfo["avatarImage"] = (mData["avatarImage"] as! String)
            self.appDelegate.userInfo["profileName"] = (mData["profileName"] as! String)
            self.appDelegate.userInfo["firstName"] = (mData["firstName"] as! String)
            self.appDelegate.userInfo["lastName"] = (mData["lastName"] as! String)
            self.appDelegate.userInfo["email"] = (mData["email"] as! String)
            self.appDelegate.userInfo["accessToken"] = (mData["accessToken"] as! String)
            self.appDelegate.userInfo["mobile"] = (mData["mobile"] as! String)
            self.appDelegate.userInfo["passWord"] = (mData["passWord"] as! String)
            self.appDelegate.userInfo["id"] = (mData["id"] as! String)
            
            print("- - - - - - - - MemberData_Fetch_RealmToLocal - - - - - - - - - - -")
            print("- - - - - - - - self.appDelegate.userInfo - - - - - - - - - - - - -")
            print(self.appDelegate.userInfo)
            print("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -")
            
        }
        
        
    }
    
    
    
    
}