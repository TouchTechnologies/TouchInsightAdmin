//
//  mUserData.swift
//  TouchInsightAdmin
//
//  Created by Thirawat Phannet on 18/7/59.
//  Copyright © พ.ศ. 2559 weerapons suwanchatree. All rights reserved.
//


import Foundation
import RealmSwift


class MemberData: Object {
    
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


