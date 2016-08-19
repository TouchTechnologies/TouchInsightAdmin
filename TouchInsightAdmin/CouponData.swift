//
//  CouponData.swift
//  TouchInsightAdmin
//
//  Created by weerapons suwanchatree on 8/19/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//
import Foundation
import RealmSwift


class CouponData: Object {
    
    dynamic var userID = ""
    dynamic var avatarImage = ""
    dynamic var profileName = ""
    dynamic var firstName = ""
    dynamic var lastName = ""
    dynamic var email = ""
    dynamic var accessToken = ""
    dynamic var mobile = ""
    dynamic var username = ""
    dynamic var passWord = ""
    dynamic var id = ""
    //dynamic var userData = NSData()
    
    
    // Specify properties to ignore (Realm won't persist these)
    
    //  override static func ignoredProperties() -> [String] {
    //    return []
    //  }
    
    
    
}


